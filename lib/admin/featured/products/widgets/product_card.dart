import 'package:t_store/admin/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/admin/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/admin/common/widgets/texts/noti_title_text.dart';
import 'package:t_store/admin/common/widgets/texts/product_price_text.dart';
import 'package:t_store/admin/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/admin/featured/products/edit_product.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TProductCard extends StatefulWidget {
  const TProductCard({super.key});

  @override
  State<TProductCard> createState() => _TProductCardState();
}

class _TProductCardState extends State<TProductCard> {
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
            child: const Stack(
              children: [
                /// Thumbnail Image
                SizedBox(
                  height: 120,
                  width: 70,
                  child: TRoundedImage(imageUrl: TImages.hoa1, applyImageRadius: true),
                ),
              ],
            ),
          ),

          /// Details
          const SizedBox(
            width: 180,
            child: Padding(
              padding: EdgeInsets.only(top: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TNotiTitleText(title: 'Lovely'),
                      SizedBox(height: TSizes.sm),
                      TBrandTitleWithVerifiedIcon(title: 'Hoa sinh nhật'),
                      SizedBox(height: TSizes.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TProductPriceText(price: '350.000'),
                          Text('SL: 20'),
                          SizedBox(width: 1)
                        ],
                      )
                      
                    ],
                  ),
                ], 
              ),
            ),
          ),
          IconButton(onPressed: () => Get.to(() => const EditProductScreen()), icon: const Icon(Icons.edit_outlined)),
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