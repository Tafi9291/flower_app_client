import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:t_store/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';


class ProductDetailSrceen extends StatelessWidget {
  const ProductDetailSrceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// 1. Product Image Slider
            const TProductImageSlider(),
            /// 2. Product Details
            Padding(
              padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  /// Rating and share bottom
                  const TRatingAndShare(),

                  /// Price, Title, Stack, & Brand
                  const TProductMetaData(),

                  /// Attributes
                  // const TProductAttributes(),
                  const  SizedBox(height: TSizes.spaceBtwSections),

                  

                  /// Description
                  const TSectionHeading(title: 'Mô tả', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  const ReadMoreText(
                    'Đây là mô tả sản phẩm cho áo vest không tay Nike màu xanh lam. Còn nhiều thứ có thể bổ sung thêm nhưng tôi chỉ đang luyện tập thôi và không có gì khác. ',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: 'Hiện thêm',
                    trimExpandedText: 'Ẩn',
                    moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  const  SizedBox(height: TSizes.spaceBtwSections),

                  /// Checkout Button
                  SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), child: const Text('Checkout'))),
                  const  SizedBox(height: TSizes.spaceBtwItems),
                  /// Reviews
                  const Divider(),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TSectionHeading(title: 'Đánh giá (199)', showActionButton: false),
                      IconButton(onPressed: () => Get.to(() => ProductReviewsScreen()), icon: const Icon(Iconsax.arrow_right_3, size: 18,))
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



