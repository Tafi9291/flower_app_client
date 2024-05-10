import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:t_store/api/product_api_handler.dart';
import 'package:t_store/common/widgets/texts/section_heading.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/bottom_add_to_cart_widget.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_detail_image_slider.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/product_meta_data.dart';
import 'package:t_store/features/shop/screens/product_details/widgets/rating_share_widget.dart';
import 'package:t_store/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';

class ProductDetailSrceen extends StatefulWidget {
  const ProductDetailSrceen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductDetailSrceen> createState() => _ProductDetailSrceenState();
}

class _ProductDetailSrceenState extends State<ProductDetailSrceen> {

  late ProductApiHandler product = ProductApiHandler();
  late Future<void> _fetchProductFuture;
  late Product? data;

  @override
  void initState() {
    super.initState();
    // Fetch category details based on categoryId
    product = ProductApiHandler();
    _fetchProductFuture = fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Fetch category details from API based on widget.categoryId
      data = await product.getProductById(widget.productId);
      setState(() {});
    } catch (e) {
      print('Failed to fetch product: $e');
      // Handle error fetching category
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const TBottomAddToCart(),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _fetchProductFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return Column(
                children: [
                  /// 1. Product Image Slider
                  TProductImageSlider(imageUrl: data!.imageUrl, isNetworkImage: true,),
                  /// 2. Product Details
                  Padding(
                    padding: const EdgeInsets.only(right: TSizes.defaultSpace, left: TSizes.defaultSpace, bottom: TSizes.defaultSpace),
                    child: Column(
                      children: [
                        /// Rating and share bottom
                        const TRatingAndShare(),

                        /// Price, Title, Stack, & Brand
                        TProductMetaData(
                          name: data!.productName,
                          category: data!.category!.categoryName,
                          percentDis: data!.percentDis.toString(),
                          price: NumberFormat("#,##0").format(data!.price ?? 0),
                          salePrice: NumberFormat("#,##0").format(data!.salePrice ?? 0),
                        ),

                        /// Attributes
                        // const TProductAttributes(),
                        const  SizedBox(height: TSizes.spaceBtwSections),

                        

                        /// Description
                        const TSectionHeading(title: 'Mô tả', showActionButton: false),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        ReadMoreText(
                          data!.description!,
                          trimLines: 2,
                          trimMode: TrimMode.Line,
                          trimCollapsedText: 'Hiện thêm',
                          trimExpandedText: 'Ẩn',
                          moreStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                          lessStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                        ),
                        const  SizedBox(height: TSizes.spaceBtwSections),

                        /// Checkout Button
                        SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), child: const Text('Thanh toán', style: TextStyle(fontSize: 18),))),
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
              );
            }
          }
        ),
      ),
    );
  }
}



