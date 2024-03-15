import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/products/cart/cart_item.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/utils/constants/sizes.dart';

class TCheckoutProduct extends StatelessWidget {
  const TCheckoutProduct({super.key, this.showAddRemoveButtons = true});

  final bool showAddRemoveButtons;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
          shrinkWrap: true,
          itemCount: 2,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwSections),
          itemBuilder: (_, index) => Column(
            children: [
              /// Cart Item
              const TCartItem(),
              if (showAddRemoveButtons) const SizedBox(height: TSizes.spaceBtwItems),

              /// Add Remove Button Row with total Price
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        /// Extra Space
                        const SizedBox(width: 90),
                        /// Quantity
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Text('x2', style: Theme.of(context).textTheme.titleSmall),
                        const SizedBox(width: TSizes.spaceBtwItems),
                      ],
                    ),
        
                    /// Product total price
                    const TProductPriceText(price: '256.000'),
                  ],
                ),
            ],
          ),
        );
  }
}