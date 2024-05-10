import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/features/shop/screens/cart/cart.dart';
import 'package:t_store/utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key, 
    this.iconColor = TColors.dark, 
    required this.onPressed, 
    this.count = 0,
    
  });

  final Color iconColor;
  final VoidCallback onPressed;
  final int? count;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(onPressed: () => Get.to(() => const CartScreen()), icon: Icon(Iconsax.shopping_bag, color: iconColor,)),
        Positioned(
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(count.toString(), style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.white),),
            ),
          ),
        ),
      ],
    );
  }
}