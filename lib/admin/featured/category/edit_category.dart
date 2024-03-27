import 'dart:io';

import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditCategoryScreen extends StatefulWidget {
  const EditCategoryScreen({super.key});

  @override
  State<EditCategoryScreen> createState() => _EditCategoryScreenState();
}

class _EditCategoryScreenState extends State<EditCategoryScreen> {

  File ? _selectedImage;
  bool isPicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(showBackArrow: true, title: Text('Chỉnh sửa phân loại')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Icons.category_rounded), labelText: 'Tên loại'), initialValue: 'Hoa sinh nhật',),
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
                _selectedImage != null ? Image.file(_selectedImage!, height: 100, width: 100, fit: BoxFit.contain) : const Image(image: AssetImage(TImages.hoa1), width: 100, height: 100,),

                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: (){}, style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), child: const Text('Lưu'),),)
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