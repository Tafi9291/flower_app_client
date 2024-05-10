import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_circular_image.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/enums.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key, 
    required this.name, 
    required this.category,
    required this.percentDis, 
    required this.price, 
    required this.salePrice, 
    
  });

  final String name, category;
  final String percentDis, price, salePrice;

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        /// Price and Sale price
        Row(
          children: [
            /// Sale Tag
            if (percentDis != '0') ...{
              TRoundedContainer(
                radius: TSizes.sm,
                backgroundColor: TColors.secondary.withOpacity(0.8),
                padding: const EdgeInsets.symmetric(horizontal: TSizes.sm, vertical: TSizes.xs),
                child: Text('$percentDis%', style: Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black)),
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
            },

            /// Price
            if (price != salePrice) ...{
              Text('$price đ', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough)),
              const SizedBox(width: TSizes.spaceBtwItems),
            },
            
            TProductPriceText(price: salePrice.toString(), isLarge: true),
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Title
        TProductTitleText(title: name,),
        const SizedBox(height: TSizes.spaceBtwItems / 1.5),

        /// Stock Status
        Row(
          children: [
            // TCircularImage(
            //   image: TImages.shoeIcon,
            //   width: 32,
            //   height: 32,
            //   overlayColor: darkMode ? TColors.white : TColors.black,
            // ),
            TBrandTitleWithVerifiedIcon(title: category, brandTextSize: TextSizes.large),
          ],
        ),
      ],
    );
  }
}