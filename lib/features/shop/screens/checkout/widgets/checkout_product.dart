import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/cart_api_handler.dart';
import 'package:t_store/common/widgets/products/cart/cart_item.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/data/models/Cart.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TCheckoutProduct extends StatefulWidget {
  const TCheckoutProduct({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  State<TCheckoutProduct> createState() => _TCheckoutProductState();
}

class _TCheckoutProductState extends State<TCheckoutProduct> {

  bool _isLoading = true;

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
        // _isLoading = false;
      });
      // Delay 1 second before setting _isLoading to false
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

  @override
  Widget build(BuildContext context) {
    return _isLoading
    ? const Center(child: CircularProgressIndicator())
    : ListView.separated(
      shrinkWrap: true,
      itemCount: carts.length,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
      itemBuilder: (_, index) => Column(
        children: [
          /// Cart Item
          TCartItem(productId: carts[index].productId,),
          if (widget.showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),
          /// Add Remove Button Row with total Price
          if (widget.showAddRemoveButtons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    /// Extra Space
                    const SizedBox(width: 90),
                    /// Quantity
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Text(carts[index].quantity.toString(), style: Theme.of(context).textTheme.titleSmall),
                    const SizedBox(width: TSizes.spaceBtwItems),
                  ],
                ),
    
                /// Product total price
                TProductPriceText(price: NumberFormat("#,##0").format(carts[index].subtotalPrice)),
              ],
            ),
        ],
      ),
    );
  }
}
