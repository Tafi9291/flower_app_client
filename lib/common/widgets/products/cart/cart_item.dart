import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TCartItem extends StatelessWidget {
  const TCartItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        /// Image
        TRoundedImage(
          imageUrl: TImages.hoa1,
          width: 90,
          height: 90,
          padding: const EdgeInsets.all(TSizes.sm),
          backGroundColor: THelperFunctions.isDarkMode(context) ? TColors.darkerGrey : TColors.light,
        ),
        const SizedBox(width: TSizes.spaceBtwItems),
    
        /// Title, Price and Size
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const TBrandTitleWithVerifiedIcon(title: 'Nike'),
              const Flexible(child: TProductTitleText(title: 'Lovely', maxLine: 1)),
              /// Attributes
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Loại: ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Hoa hồng', style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(text: ', ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Size: ', style: Theme.of(context).textTheme.bodySmall),
                    TextSpan(text: 'Bó lớn ', style: Theme.of(context).textTheme.bodyLarge),
                  ],
                )
              ),
            ],
          ),
        ),
      ],
    );
  }
}