import 'package:t_store/admin/featured/orders/widgets/order_detail_price_item.dart';
import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/texts/product_price_text.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductOrderHorizontal extends StatelessWidget {
  const TProductOrderHorizontal({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        border: Border.all(width: 0.5, style: BorderStyle.solid, color: const Color.fromARGB(255, 131, 131, 131)),
        color: dark ? TColors.darkerGrey : TColors.softGrey,
      ),
      child: Column(
        children: [
          /// Order detail price items
          TOrderDetailPriceItem(dark: dark),
          TOrderDetailPriceItem(dark: dark),
          
          const Padding(
            padding: EdgeInsets.all(TSizes.sm),
            child: Column(
              children: [
                /// Price info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tổng tiền hàng', style: TextStyle(fontSize: 16),),
                    Text('đ 1.024.000'),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Tiền ship', style: TextStyle(fontSize: 16),),
                    Text('đ 15.000'),
                  ],
                ),
                SizedBox(height: TSizes.spaceBtwItems / 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Thành tiền', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    TProductPriceText(price: '1.039.000'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

