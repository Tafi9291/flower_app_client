import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/admin/featured/category/category.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class THomeCardVertical extends StatelessWidget {
  const THomeCardVertical({
    super.key, 
    required this.backgroundColor, 
    required this.title,
    this.quantity = 0,
  });

  final String title;
  final int? quantity;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () => Get.to(() => const CategoryScreen()),
      child: Column(
        children: [
          /// Thumbnail, WishList Button, Discount Tag
          TRoundedContainer(
            height: 170,
            width: 170,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: backgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: TSizes.md,),
                Text('$quantity', style: const TextStyle(fontSize: 18)),
      
              ],
            ),
          ),
        ],
      ),
    );
  }
}




