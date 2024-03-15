import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/common/widgets/custom_shapes/curved_edges/curved_edges_widget.dart';
import 'package:t_store/common/widgets/icons/t_circular_icon.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';

class TProductImageSlider extends StatelessWidget {
  const TProductImageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return TCurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: const Stack(
          children: [
            /// Main Large Image
            SizedBox(
              height: 400,
              child: Padding(
                padding: EdgeInsets.all(TSizes.productImageRadius * 3),
                child: Center(child: Image(image: AssetImage(TImages.hoa1))),
              ),
            ),
    
            /// Image Slider
            // Positioned(
            //   right: 0,
            //   bottom: 30,
            //   left: TSizes.defaultSpace,
            //   child: SizedBox(
            //     height: 80,
            //     child: ListView.separated(
            //       itemCount: 6,
            //       shrinkWrap: true,
            //       scrollDirection: Axis.horizontal,
            //       physics: const AlwaysScrollableScrollPhysics(),
            //       separatorBuilder: (_,__) => const SizedBox(width: TSizes.spaceBtwItems),
            //       itemBuilder: (_, index) => TRoundedImage(
            //         width: 80,
            //         backGroundColor: dark ? TColors.dark : TColors.white,
            //         border: Border.all(color: TColors.primary),
            //         padding: const EdgeInsets.all(TSizes.sm),
            //         imageUrl: TImages.productImage4,
            //       ),
    
            //     ),
            //   ),
            // ),
            /// Appbar Icon
            TAppBar(
              showBackArrow: true,
              actions: [TCircularIcon(icon: Iconsax.heart5, color: Colors.red,)],
            ),
            
          ],
        ),
      ),
    );
  }
}