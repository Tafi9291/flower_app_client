import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:t_store/admin/featured/category/category.dart';
import 'package:t_store/api/category_api_handler.dart';

import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/CategoryWithImageInput.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:path_provider/path_provider.dart';
import 'package:t_store/utils/popup/loaders.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {

  File ? _selectedImage;
  bool isPicked = false;
  TextEditingController categoryNameController = TextEditingController();

  final CategoryApiHandler cate = CategoryApiHandler();

  void addCategory() async {
    if (_selectedImage == null || categoryNameController.text.isEmpty) {
      TLoaders.warningSnackBar(title: 'Cảnh báo', message: 'Thông tin còn thiếu. Hãy kiểm tra lại.'.tr);
    }

    // Create CategoryWithImageInput object
    CategoryWithImageInput categoryInput = CategoryWithImageInput(
      categoryName: categoryNameController.text,
      imageFile: _selectedImage!,
    );

    // Call the addCategory method from your CategoryApiHandler
    try {
      Category? addedCategory = await cate.addCategory(categoryInput);
      if (addedCategory != null) {
        // Category added successfully
        TLoaders.successSnackBar(title: 'Tạo phân loại mới', message: 'Tạo phân loại mới thành công'.tr);
        Navigator.pop(context);
      } else {
        // Handle case where category could not be added
        TLoaders.errorSnackBar(title: 'Tạo phân loại mới', message: 'Tạo phân loại mới thất bại'.tr);
      }
    } catch (e) {
      // Handle error scenario
      print('Error adding category: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Thêm phân loại mới')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: categoryNameController,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.category_rounded), labelText: 'Tên loại'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a category name';
                    }
                    return null;
                  },
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
                _selectedImage != null ? Image.file(_selectedImage!, height: 200, width: 200, fit: BoxFit.contain) : const Text('Hãy chọn hình ảnh!'),

                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: addCategory, style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), child: const Text('Lưu'),),)
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