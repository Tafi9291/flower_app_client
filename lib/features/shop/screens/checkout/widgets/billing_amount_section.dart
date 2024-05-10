import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:t_store/api/address_api_handler.dart';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/api/cart_api_handler.dart';
import 'package:t_store/data/models/Address.dart';
import 'package:t_store/data/models/Cart.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TBillingAmountSection extends StatefulWidget {
  const TBillingAmountSection({super.key, required this.subTotal, required this.finalPrice});

  final String subTotal, finalPrice;

  @override
  State<TBillingAmountSection> createState() => _TBillingAmountSectionState();
}

class _TBillingAmountSectionState extends State<TBillingAmountSection> {

  bool _isLoading = true;
  List<Cart> carts = [];
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
      int totalPrice = 0;
      for (final cartItem in cartList) {
        if (cartItem.usersId == customerDetail['usersId']) {
          totalPrice += cartItem.subtotalPrice!;
        }
      }
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

  int? getTotalPriceForUser(int? usersId) {
    int total = 0;
    for (final cartItem in carts) {
      if (cartItem.usersId == usersId) {
        total += cartItem.subtotalPrice!;
      }
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final int? totalPriceForUser = getTotalPriceForUser(customerDetail['usersId'] as int?);
    return _isLoading
    ? const Center(child: CircularProgressIndicator())
    : Column(
      children: [
        /// Subtotal
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng tiền hàng', style: Theme.of(context).textTheme.bodyMedium),
            Text(NumberFormat("#,##0 đ").format(totalPriceForUser), style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Shipping fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí vận chuyển', style: Theme.of(context).textTheme.bodyMedium),
            Text('0 đ', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Tax fee
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Phí dịch vụ', style: Theme.of(context).textTheme.bodyMedium),
            Text('0 đ', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),

        const SizedBox(height: TSizes.spaceBtwItems / 2),

        /// Order Total
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Thành tiền', style: Theme.of(context).textTheme.titleMedium),
            Text(NumberFormat("#,##0 đ").format(totalPriceForUser), style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
      ],
    );
  }
}
