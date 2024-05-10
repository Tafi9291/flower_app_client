import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/cart_api_handler.dart';
import 'package:t_store/common/widgets/products/cart/add_remove_button.dart';
import 'package:t_store/common/widgets/products/cart/cart_item.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/data/models/Cart.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/utils/constants/sizes.dart';


class TCartItems extends StatefulWidget {
  const TCartItems({super.key, this.showAddRemoveButtons = true});

  final bool? showAddRemoveButtons;

  @override
  State<TCartItems> createState() => _TCartItemsState();
}

class _TCartItemsState extends State<TCartItems> {
  
  bool _isLoading = true; // Biến boolean để theo dõi trạng thái tải dữ liệu

  List<Cart> carts = [];
  List<Product> products = [];
  Map<String, dynamic> customerDetail = {};
  AuthUserApiHandler customerApiHandler = AuthUserApiHandler();
  final DataService  dataService = DataService();
  CartApiHandler  cartApi = CartApiHandler();

  @override
  void initState() {
    super.initState();
    loadcustomerDetail();
  }

  void loadcustomerDetail() async {
    try {
      final customerDetailResponse = await customerApiHandler.getUserDetail();
      setState(() {
        customerDetail = customerDetailResponse;
        fetchCart(customerDetail['email']);
      });
    } catch (e) {
      print('Failed to load customer detail: $e');
    }
  }

  void fetchCart(String email) async {
    try {
      // Fetch category details from API based on widget.categoryId
      final List<dynamic> response = await cartApi.getCartsByEmail(email);
      final List<Cart> cartList = response.map((item) => Cart.fromJson(item)).toList();
      setState(() {
        carts = cartList;
      });
      await Future.delayed(const Duration(milliseconds: 500));
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to fetch cart: $e');
      // Handle error fetching category
    }
  }

  void updateQuantity(int index, int newQuantity) {
    setState(() {
      carts[index].quantity = newQuantity;
    });
  }

  void updateTotalPrice(int index, int newSubtotalPrice) {
    setState(() {
      carts[index].subtotalPrice = newSubtotalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
      ? const Center(
          child: CircularProgressIndicator(), // Hiển thị tiêu chí tải dữ liệu
        )
      : carts.isEmpty
          ? const Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 100,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20),
                  Text('Không có sản phẩm nào trong giỏ hàng.'),
                ],
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: carts.length,
              separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
              itemBuilder: (_, index) => Column(
                children: [
                  TCartItem(
                    productId: carts[index].productId,
                  ),
                  if (widget.showAddRemoveButtons!) const SizedBox(height: TSizes.spaceBtwItems),
                  if (widget.showAddRemoveButtons!)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 90),
                            TProductQuantityWithAddRemoveButton(
                              quantity: carts[index].quantity,
                              productId: carts[index].productId,
                              onAddToCart: () {
                                setState(() {
                                  updateQuantity(index, carts[index].quantity! + 1);
                                });
                              },
                            ),
                          ],
                        ),
                        TProductPriceText(
                          price: NumberFormat("#,##0").format(carts[index].subtotalPrice),
                        ),
                      ],
                    ),
                ],
              ),
            );
  }
}
