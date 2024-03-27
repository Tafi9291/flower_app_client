import 'dart:io';
import 'dart:math';
import 'package:t_store/api/category_api_handler.dart';

import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

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
  final _formKey = GlobalKey<FormBuilderState>();
  void addUser() async {
    try {
      if (_formKey.currentState != null && _formKey.currentState!.saveAndValidate()) {
        final data = _formKey.currentState!.value;

        // Lưu hình ảnh vào thư mục và lấy đường dẫn
        final imageUrl = await saveImageToDirectory();

        if (imageUrl != null) {
          final categories = Category(
            categoryId: 0,
            categoryName: data['categoryName'],
            imageUrl: imageUrl,
          );
          await cate.addCategory(category: categories);
        }
      }
    } catch (e) {
      print(e);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Thêm phân loại mới')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            key: _formKey,
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
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: addUser, style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), child: const Text('Lưu'),),)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String?> saveImageToDirectory() async {
    try {
      final Directory? tempDir = await getTemporaryDirectory();
      if (tempDir == null) {
        print('Temporary directory not found.');
        return null;
      }
      final String tempPath = tempDir.path;

      if (_selectedImage != null) {
        final fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
        final tempFile = File('$tempPath/$fileName');
        await tempFile.writeAsBytes(await _selectedImage!.readAsBytes());

        final Directory assetDir = Directory('assets/images/category');
        if (!assetDir.existsSync()) {
          assetDir.createSync(recursive: true);
        }
        await tempFile.copy('${assetDir.path}/$fileName');

        return 'assets/images/category/$fileName';
      }
      return null;
    } catch (e) {
      print('Error saving image to assets: $e');
      return null;
    }
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