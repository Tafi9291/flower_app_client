import 'package:flutter/material.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';


class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key, 
    required this.image, 
    required this.title, 
    this.textColor = TColors.white, 
    this.backGroundColor, 
    this.isNetWorkImage = false, 
    this.onTap,
  });

  final String image, title;
  final Color textColor;
  final Color? backGroundColor;
  final bool isNetWorkImage;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);

    // Kích thước ban đầu của hình ảnh
    double originalWidth = 150.0;
    double originalHeight = 180.0;

    // Kích thước mong muốn
    double targetWidth = 64.0;
    double targetHeight = 64.0;

    // Tính tỷ lệ scale
    double scale = 1.0;
    double widthScale = targetWidth / originalWidth;
    double heightScale = targetHeight / originalHeight;
    scale = widthScale < heightScale ? widthScale : heightScale;

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            /// Circular icon
            Container(
              width: 76,
              height: 76,
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color: backGroundColor ?? (dark ? TColors.black : TColors.white),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: ClipOval(
                  child: Image(
                    image: isNetWorkImage ? NetworkImage(image) : AssetImage(image) as ImageProvider, 
                    fit: BoxFit.cover, 
                    width: targetWidth,
                    height: targetHeight,
                    // color: dark ? TColors.light : TColors.dark
                  ),
                ),
              ),
            ),
        
            /// Text
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            SizedBox(
              width: 110,
              child: Text(
                title,
                // style: Theme.of(context).textTheme.titleMedium!.apply(color: TColors.dark, fontWeightDelta: 600,),
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
