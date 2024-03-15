import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/common/widgets/texts/product_title_text.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductAttributes extends StatelessWidget {
  const TProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        /// Selected Attributes Pricing & Description
        TRoundedContainer(
          padding: const EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Column(
            children: [
              /// Title, Price and Stock Status
              Row(
                children: [
                  const TSectionHeading(title: 'Variation', showActionButton: false),
                  const SizedBox(width: TSizes.spaceBtwItems),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [                      
                      Row(
                        children: [
                          const TProductTitleText(title: 'Price: ', smallSize: true),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Actual Price
                          Text(
                            '\$25',
                            style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),
                          ),
                          const SizedBox(width: TSizes.spaceBtwItems),

                          /// Sale Price
                          const TProductPriceText(price: '20'),
                        ],
                      ),

                      /// Stock
                      Row(
                        children: [
                          const TProductTitleText(title: 'Stock: ', smallSize: true),
                          const SizedBox(width: TSizes.spaceBtwItems),
                          Text('Còn hàng', style: Theme.of(context).textTheme.titleMedium),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              /// Variation Description
              const TProductTitleText(
                title: 'This is the Description of the Product and it can go up to max 4 lines.',
                smallSize: true,
                maxLine: 4,
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        /// Attributes
        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const TSectionHeading(title: 'Color', showActionButton: false,),
        //     const SizedBox(height: TSizes.spaceBtwItems / 2),
        //     Wrap (
        //       spacing: 5,
        //       children: [
        //         TChoiceChip(text: 'Green', selected: true, onSelected: (value){},),
        //         TChoiceChip(text: 'Blue', selected: false, onSelected: (value){},),
        //         TChoiceChip(text: 'Yellow', selected: false, onSelected: (value){},),
        //         TChoiceChip(text: 'Green', selected: false, onSelected: (value){},),
        //         TChoiceChip(text: 'Blue', selected: false, onSelected: (value){},),
        //         TChoiceChip(text: 'Yellow', selected: false, onSelected: (value){},),
        //       ],
        //     ),
            
        //   ],
        // ),

        // Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     const TSectionHeading(title: 'Size', showActionButton: false,),
        //     const SizedBox(height: TSizes.spaceBtwItems / 2),
        //     Wrap(
        //       spacing: 5,
        //       children: [
        //         TChoiceChip(text: 'EU 34', selected: true, onSelected: (value){}, ),
        //         TChoiceChip(text: 'EU 35', selected: false, onSelected: (value){}, ),
        //         TChoiceChip(text: 'EU 36', selected: false, onSelected: (value){}, ),
        //         TChoiceChip(text: 'EU 36', selected: false, onSelected: (value){}, ),
        //         TChoiceChip(text: 'EU 36', selected: false, onSelected: (value){}, ),
        //         TChoiceChip(text: 'EU 36', selected: false, onSelected: (value){}, ),
        //         TChoiceChip(text: 'EU 36', selected: false, onSelected: (value){}, ),
        //       ],
        //     ),
        //   ],
        // ),
      ],
    );
  }
}

