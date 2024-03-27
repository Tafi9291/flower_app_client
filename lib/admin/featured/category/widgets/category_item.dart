import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/texts/noti_title_text.dart';
import 'package:t_store/admin/featured/category/edit_category.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCategoryItem extends StatelessWidget {
  const TCategoryItem({super.key, required this.title, required this.imageUrl});

  final String title;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        border: Border.all(style: BorderStyle.solid, color: TColors.darkGrey),
        color: dark ? TColors.darkerGrey : TColors.softGrey,
      ),
      child: Row(
        children: [
          /// Thumbnail
          TRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                /// Thumbnail Image
                SizedBox(
                  height: 120,
                  width: 70,
                  child: TRoundedImage(imageUrl: imageUrl, applyImageRadius: true),
                ),
              ],
            ),
          ),

          /// Details
          SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.only(top: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TNotiTitleText(title: title,)
                      
                    ],
                  ),
                ], 
              ),
            ),
          ),
          IconButton(onPressed: () => Get.to(() => const EditCategoryScreen()), icon: const Icon(Icons.edit_outlined)),
          const SizedBox(width: TSizes.sm),
          IconButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder: (context) => AlertDialog(
                  title: const Text('Cảnh báo!!!'),
                  content: const Text('Bạn có chắc muốn xóa không?'),
                  actions: [
                    TextButton(onPressed: (){}, child: const Text('Hủy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
                    TextButton(onPressed: (){}, child: const Text('Ok', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
                  ],
                )
                
              );
            }, 
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}