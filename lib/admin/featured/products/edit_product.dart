import 'dart:io';

import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key});

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  File ? _selectedImage;
  bool isPicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Chỉnh sửa sản phẩm')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                // Choose image
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
                _selectedImage != null ? Image.file(_selectedImage!, height: 200, width: 200, fit: BoxFit.contain) 
                              : const Image(image: AssetImage(TImages.hoa1), width: 200, height: 200,),
                
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Product name
                TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Icons.new_label), labelText: 'Tên sản phẩm'), initialValue: 'Lovely',),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Category
                DropdownButtonFormField(
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.category_rounded), labelText: 'Phân loại'),
                  value: 'Hoa sinh nhật',
                  items: ['Hoa sinh nhật', 'Hoa cưới', 'Hoa kỷ niệm', 'Hoa Valentine'] // Your list of categories
                      .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                      .toList(),
                  onChanged: (selectedCategory) {
                    // Handle the selected category here
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Price
                TextFormField(decoration: const InputDecoration(prefixIcon: Icon(Icons.attach_money), labelText: 'Giá tiền (VNĐ)'), initialValue: '200.000',),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Percent sale & Quantity
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.percent), labelText: 'Phần trăm giảm'),
                        initialValue: '0',
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.add_chart), labelText: 'Số lượng'),
                        initialValue: '12',
                      ),
                    ),
                  ],
                ),
                
                
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