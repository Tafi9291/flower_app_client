import 'package:t_store/api/category_api_handler.dart';
import 'package:t_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:t_store/common/widgets/images/t_rounded_image.dart';
import 'package:t_store/common/widgets/texts/noti_title_text.dart';
import 'package:t_store/admin/featured/category/edit_category.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TCategoryItem extends StatefulWidget {
  const TCategoryItem({super.key, required this.id, required this.title, required this.imageUrl});

  final int id;
  final String title;
  final String imageUrl;


  @override
  State<TCategoryItem> createState() => _TCategoryItemState();
}

class _TCategoryItemState extends State<TCategoryItem> {
  final CategoryApiHandler categoryApiHandler = CategoryApiHandler();

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
                final result = await categoryApiHandler.deleteCategory(widget.id);
                // Xóa thành công
                print('Category deleted successfully');
                // Thực hiện các hành động sau khi xóa, ví dụ: cập nhật UI, hiển thị thông báo, v.v.
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(result)),
                );
              } catch (e) {
                // Xử lý ngoại lệ và hiển thị thông báo lên UI
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Loại sản phẩm đang được sử dụng. Không thể xóa')),
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
                  child: TRoundedImage(imageUrl: widget.imageUrl, applyImageRadius: true, isNetWorkImage: true,),
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
                      TNotiTitleText(title: widget.title,)
                      
                    ],
                  ),
                ], 
              ),
            ),
          ),
          IconButton(onPressed: () => Get.to(() => EditCategoryScreen(categoryId: widget.id)), icon: const Icon(Icons.edit_outlined)),
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