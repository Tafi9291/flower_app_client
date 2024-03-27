import 'package:t_store/admin/featured/products/widgets/product_card.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/layouts/gird_layouts.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/utils/constants/sizes.dart';


class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     /// Dropdown
    //     DropdownButtonFormField(
    //       decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
    //       onChanged: (value){},
    //       items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
    //           .map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
    //     ),
    //     const SizedBox(height: TSizes.spaceBtwSections),
    
    //     /// Products
    //     TGridLayout(itemCount: 8, itemBuilder: (_, index) => const TProductCardVertical()),
    //   ],
    // );
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField(
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort), labelText: 'Phân loại'),
          dropdownColor: const Color.fromARGB(255, 195, 237, 187),
          onChanged: (value){},
          items: ['All', 'Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
              .map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
    
        /// Products
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), 
          itemCount: 8, 
          itemBuilder: (_, index) => const Padding(
            padding: EdgeInsets.only(bottom: TSizes.spaceBtwItems),
            child: TProductCard(),
        )),
      ],
    );
  }
}