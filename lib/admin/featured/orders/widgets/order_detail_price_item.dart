import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TOrderDetailPriceItem extends StatelessWidget {
  const TOrderDetailPriceItem({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Column(
        children: [
          Row(
            children: [
              /// Thumbnail
              TRoundedContainer(
                height: 150,
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.md),
                backgroundColor: dark ? TColors.dark : TColors.light,
                child: const Stack(
                  children: [
                    /// Thumbnail Image
                    TRoundedImage(imageUrl: TImages.hoa1, applyImageRadius: true, height: 120, width: 80),
                  ],
                ),
              ),
          
              /// Details
              /// Product name
              SizedBox(
                width: 255,
                child: Padding(
                  padding: const EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(width: 200 ,child: TProductTitleText(title: 'Green Nike Half Sleeves Shirt Green Nike Half Sleeves Shirtasdsad', smallSize: false)),
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(text: 'Loại: ', style: Theme.of(context).textTheme.bodySmall),
                                TextSpan(text: 'Hoa hồng', style: Theme.of(context).textTheme.bodyLarge),
                                TextSpan(text: ', ', style: Theme.of(context).textTheme.bodySmall),
                                TextSpan(text: 'Size: ', style: Theme.of(context).textTheme.bodySmall),
                                TextSpan(text: 'Bó lớn ', style: Theme.of(context).textTheme.bodyLarge),
                              ],
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: 'Số lượng: ', style: Theme.of(context).textTheme.bodySmall),
                                    TextSpan(text: '2', style: Theme.of(context).textTheme.bodyLarge),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text('đ 256.000', style: Theme.of(context).textTheme.bodyLarge),
                            ],
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems / 2),
                        ],
                      ),
                    ], 
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(),
          ),
        ],
      ),
    );
  }
}