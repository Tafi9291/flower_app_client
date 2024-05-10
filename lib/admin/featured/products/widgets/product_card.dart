import 'package:t_store/admin/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/admin/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/admin/common/widgets/texts/noti_title_text.dart';
import 'package:t_store/admin/common/widgets/texts/product_price_text.dart';
import 'package:t_store/admin/common/widgets/texts/t_brand_title_text_with_verified_icon.dart';
import 'package:t_store/admin/featured/products/edit_product.dart';
import 'package:t_store/api/product_api_handler.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TProductCard extends StatefulWidget {
  const TProductCard({
    super.key, 
    required this.productId,
    required this.name, 
    required this.image, 
    required this.price,
    required this.category,
    required this.stockQl, 
  });

  final int productId;
  final String name, category, image;
  final int? stockQl;
  final String price;

  @override
  State<TProductCard> createState() => _TProductCardState();
}

class _TProductCardState extends State<TProductCard> {

  final ProductApiHandler productApiHandler = ProductApiHandler();

  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cảnh báo!!!'),
        content: const Text('Bạn có chắc muốn xóa không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Đóng dialog
              child: const Text('Hủy', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            TextButton(
              onPressed: () async {
              try {
                final result = await productApiHandler.deleteProduct(widget.productId);
                // Xóa thành công
                print('Product deleted successfully');
                // Thực hiện các hành động sau khi xóa, ví dụ: cập nhật UI, hiển thị thông báo, v.v.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
              } catch (e) {
                // Xử lý ngoại lệ và hiển thị thông báo lên UI
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Sản phẩm đang được sử dụng. Không thể xóa')),
                );
              }
              Navigator.pop(context); // Đóng dialog
            },
            child: const Text('Ok', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(TSizes.productImageRadius),
        border: Border.all(style: BorderStyle.solid, color: TColors.darkGrey),
        color: dark ? TColors.darkerGrey : TColors.softGrey,
      ),
      child: Row(
        children: [
          /// Thumbnail
          TRoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(TSizes.sm),
            backgroundColor: dark ? TColors.dark : TColors.light,
            child: Stack(
              children: [
                /// Thumbnail Image
                SizedBox(
                  height: 120,
                  width: 70,
                  child: TRoundedImage(imageUrl: widget.image, applyImageRadius: true, isNetWorkImage: true,),
                ),
              ],
            ),
          ),

          /// Details
          SizedBox(
            width: 180,
            child: Padding(
              padding: const EdgeInsets.only(top: TSizes.sm),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TNotiTitleText(title: widget.name),
                      const SizedBox(height: TSizes.sm),
                      TBrandTitleWithVerifiedIcon(title: widget.category),
                      const SizedBox(height: TSizes.sm),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TProductPriceText(price: widget.price.toString()),
                          Text('SL: ${widget.stockQl}'),
                          const SizedBox(width: 1)
                        ],
                      )
                      
                    ],
                  ),
                ], 
              ),
            ),
          ),
          IconButton(onPressed: () => Get.to(() => EditProductScreen(productId: widget.productId,)), icon: const Icon(Icons.edit_outlined)),
          const SizedBox(width: TSizes.sm),
          IconButton(
            onPressed: () => _confirmDelete(context),
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
    );
  }
}