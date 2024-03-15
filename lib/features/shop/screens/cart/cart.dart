import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:t_store/features/shop/screens/checkout/checkout.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Giỏ hàng', style: Theme.of(context).textTheme.headlineMedium)),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),

        /// Items in cart
        child: TCartItems(),
      ),

      /// Checkout Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()), 
          style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), 
          child: const Text('Thanh toán đ 256.000')),
      ),
    );
  }
}

