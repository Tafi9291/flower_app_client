import 'package:flutter/material.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/texts/noti_title_text.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TNotificationItem extends StatefulWidget {
  const TNotificationItem({super.key});

  @override
  State<TNotificationItem> createState() => _TNotificationItemState();
}

class _TNotificationItemState extends State<TNotificationItem> {
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
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
            width: 230,
            child: Padding(
              padding: EdgeInsets.only(top: TSizes.sm, left: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TNotiTitleText(title: 'Bạn đã đặt hàng thành công Lovely chủ đề Sinh nhật'),
                      
                      
                    ],
                  ),
                ], 
              ),
            ),
          ),
          const Icon(Icons.keyboard_arrow_right_outlined),
        ],
      ),
    );
  }
}