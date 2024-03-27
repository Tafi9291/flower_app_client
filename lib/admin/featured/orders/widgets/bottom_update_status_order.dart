import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class TBottomUpdateStatusOrder extends StatefulWidget {
  const TBottomUpdateStatusOrder({super.key});

  @override
  State<TBottomUpdateStatusOrder> createState() => _TBottomUpdateStatusOrderState();
}

class _TBottomUpdateStatusOrderState extends State<TBottomUpdateStatusOrder> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace, vertical: TSizes.defaultSpace / 2),
      height: 140,
      decoration: BoxDecoration(
        color: dark ? TColors.darkGrey : TColors.softGrey,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(TSizes.cardRadiusLg),
          topRight: Radius.circular(TSizes.cardRadiusLg),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // Spread radius
            blurRadius: 5, // Blur radius
            offset: const Offset(0, 2), // Offset from the top
          ),
        ],
      ),
      
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: DropdownButtonFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.change_circle, 
                color: TColors.dark,), 
                labelText: 'Phân loại',
                fillColor: Colors.white,
                filled: true,
              ),
              value: 'Đang xử lý',
              items: ['Đang xử lý', 'Đã xử lý', 'Đang giao', 'Đã giao', 'Đơn hủy'] // Your list of categories
                  .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                  .toList(),
              onChanged: (selectedCategory) {
                // Handle the selected category here
              },
            ),
          ),
          const SizedBox(width: TSizes.md),
          ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(TSizes.md),
              backgroundColor: TColors.darkPrimary,
              side: const BorderSide(color: TColors.darkPrimary),
            ),
            child: const Text('Cập nhật'),
          ),
        ],
      ),
    );
  }
}