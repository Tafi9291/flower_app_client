import 'dart:io';

import 'package:get/get.dart';
import 'package:t_store/admin/featured/products/product.dart';
import 'package:t_store/admin/utils/validators/validation.dart';
import 'package:t_store/api/category_api_handler.dart';
import 'package:t_store/api/product_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/models/ProductWithImageInput.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/utils/popup/loaders.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {

  File ? _selectedImage;
  bool isPicked = false;

  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController percentDisController = TextEditingController();
  TextEditingController stockQlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  final ProductApiHandler product = ProductApiHandler();

  int? selectedCategoryId;
  

  void addProduct() async {
    if (_selectedImage == null ||
      productNameController.text.isEmpty ||
      priceController.text.isEmpty ||
      percentDisController.text.isEmpty ||
      selectedCategoryId == null ||
      descriptionController.text.isEmpty) {
      TLoaders.warningSnackBar(
          title: 'Cảnh báo',
          message: 'Thông tin còn thiếu. Hãy kiểm tra lại.'.tr);
      return; // Exit the function early if any required fields are empty
    }

    // Create ProductWithImageInput object
    ProductWithImageInput productInput = ProductWithImageInput(
      productName: productNameController.text,
      price: int.tryParse(priceController.text),
      percentDis: int.tryParse(percentDisController.text),
      stockQl: int.tryParse(stockQlController.text),
      description: descriptionController.text,
      categoryId: selectedCategoryId,
      imageFile: _selectedImage!,
    );

    // Call the addProduct method from your ProductApiHandler
    try {
      Product? addedProduct = await product.addProduct(productInput);
      if (addedProduct != null) {
        // Product added successfully
        TLoaders.successSnackBar(title: 'Tạo sản phẩm mới', message: 'Tạo sản phẩm mới thành công'.tr);
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProductScreen(), // Replace ProductScreen with your actual product screen
          ),
        );
      } else {
        // Handle case where Product could not be added
        TLoaders.errorSnackBar(title: 'Tạo sản phẩm mới', message: 'Tạo sản phẩm mới thất bại'.tr);
      }
    } catch (e) {
      // Handle error scenario
      print('Error adding Product: $e');
    }
  }

  
  late List<Category> categories = [];

  final DataService  dataService = DataService();

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      final List<Category> response = await dataService.getCategoryData(); // Use the getData method from the DataService
      setState(() {
        categories = response;
      });
    } catch (e) {
      print('Failed to load detail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(showBackArrow: true, title: Text('Thêm sản phẩm mới')),
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
                _selectedImage != null ? Image.file(_selectedImage!, height: 200, width: 200, fit: BoxFit.contain) : const Text('Hãy chọn hình ảnh!'),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Product name
                TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.new_label), labelText: 'Tên sản phẩm')
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Category
                DropdownButtonFormField(
                  value: selectedCategoryId,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.category_rounded),
                    labelText: 'Phân loại'
                  ),
                  items: categories.map((Category category) {
                    return DropdownMenuItem(
                      value: category.categoryId,
                      child: Text(category.categoryName),
                    );
                  }).toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedCategoryId = newValue;
                    });
                  },
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Price
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.attach_money), labelText: 'Giá tiền')
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Percent sale & Quantity
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: percentDisController,
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.percent), labelText: 'Phần trăm giảm'),
                      ),
                    ),
                    const SizedBox(width: TSizes.spaceBtwInputFields),
                    Expanded(
                      child: TextFormField(
                        controller: stockQlController,
                        decoration: const InputDecoration(prefixIcon: Icon(Icons.add_chart), labelText: 'Số lượng'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                
                // Description
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.description), labelText: 'Mô tả')
                ),
                const SizedBox(height: TSizes.spaceBtwInputFields),
                
                
                const SizedBox(height: TSizes.defaultSpace * 1.5),
                SizedBox(
                  width: double.infinity, 
                  height: 60, 
                  child: ElevatedButton(
                    onPressed: addProduct, 
                    style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), 
                    child: const Text('Lưu', style: TextStyle(fontSize: 20),),
                  ),
                ),
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