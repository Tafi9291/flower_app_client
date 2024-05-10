import 'dart:io';

import 'package:get/get.dart';
import 'package:t_store/admin/featured/category/category.dart';
import 'package:t_store/admin/navigation_menu.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/CategoryWithImageInput.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/api/category_api_handler.dart';
import 'package:t_store/utils/popup/loaders.dart';


class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({super.key, required this.categoryId});

  final int categoryId;

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {

  File ? _selectedImage;
  bool isPicked = false;

  TextEditingController categoryNameController = TextEditingController();
  String? _categoryImageUrl;

  final CategoryApiHandler cate = CategoryApiHandler();

  @override
  void initState() {
    super.initState();
    // Fetch category details based on categoryId
    fetchData();
  }

  void fetchData() async {
    try {
      // Fetch category details from API based on widget.categoryId
      final category = await cate.getCategoryById(widget.categoryId);
      if (category != null) {
        // Set initial values in the form
        setState(() {
          categoryNameController.text = category.categoryName;
           _categoryImageUrl = category.imageUrl;
          // Set other initial values here if needed
        });
      } else {
        // Handle error fetching category
      }
    } catch (e) {
      print('Failed to fetch category: $e');
      // Handle error fetching category
    }
  }

  void updateData() async {
    try {
      if (_selectedImage != null) {
        // Update both category name and image
        CategoryWithImageInput categoryInput = CategoryWithImageInput(
          categoryName: categoryNameController.text,
          imageFile: _selectedImage,
        );
        await cate.updateCategory(
          widget.categoryId,
          categoryInput,
        );
      } else {
        // Update only category name
        CategoryWithImageInput categoryInput = CategoryWithImageInput(
          categoryName: categoryNameController.text,
        );
        await cate.updateCategory(
          widget.categoryId,
          categoryInput,
        );
      }

      TLoaders.successSnackBar(
        title: 'Cập nhật',
        message: 'Cập nhật phân loại thành công'.tr,
      );
      Navigator.pop(context);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationAdminMenu(), // Replace ProductScreen with your actual product screen
        ),
      );
    } catch (e) {
      print('Error updating category: $e');
      TLoaders.errorSnackBar(
        title: 'Cập nhật',
        message: 'Cập nhật phân loại thất bại'.tr,
      );
    }
  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Chỉnh sửa phân loại')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.category_rounded), labelText: 'Tên loại'),
                  controller: categoryNameController,
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                MaterialButton(
                  minWidth: double.infinity,
                  height: 50,
                  color: TColors.grey.withOpacity(0.5), 
                  onPressed: pickImageFromGallery, 
                  child: const Text(
                    'Chọn hình ảnh', 
                    style: TextStyle(
                      fontSize: 15, 
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                _selectedImage != null
                    ? Image.file(_selectedImage!, height: 100, width: 100, fit: BoxFit.contain)
                    : _categoryImageUrl != null
                        ? Image(image: NetworkImage(_categoryImageUrl!), height: 100, width: 100, fit: BoxFit.contain)
                        : const Image(image: AssetImage(TImages.hoa1), height: 100, width: 100, fit: BoxFit.contain),

                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: updateData, style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), child: const Text('Lưu'),),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image =
        await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      _selectedImage = File(image.path);
      setState(() {
        isPicked = true;
      });
    }
  }
}