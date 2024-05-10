import 'dart:io';

import 'package:get/get.dart';
import 'package:t_store/admin/featured/products/product.dart';
import 'package:t_store/admin/navigation_menu.dart';
import 'package:t_store/api/product_api_handler.dart';
import 'package:t_store/common/widgets/appbar/appbar.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/models/ProductWithImageInput.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:t_store/utils/popup/loaders.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, required this.productId});

  final int productId;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {

  File ? _selectedImage;
  bool isPicked = false;

  TextEditingController productNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController percentDisController = TextEditingController();
  TextEditingController stockQlController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String? _productImageUrl;
  final ProductApiHandler product = ProductApiHandler();

  int? selectedCategoryId;

  late List<Category> categories = [];

  final DataService  dataService = DataService();
  
  @override
  void initState() {
    super.initState();
    // Fetch category details based on categoryId
    fetchData();
    getCategoryData();
  }

  void fetchData() async {
    try {
      // Fetch category details from API based on widget.categoryId
      final products = await product.getProductById(widget.productId);
      if (products != null) {
        // Set initial values in the form
        setState(() {
          productNameController.text = products.productName;
          priceController.text  = products.price.toString();
          percentDisController.text = products.percentDis.toString();
          stockQlController.text =  products.stockQl.toString();
          descriptionController.text = products.description!;
          selectedCategoryId = products.categoryId;
          _productImageUrl = products.imageUrl;
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

  void getCategoryData() async {
    try {
      final List<Category> response = await dataService.getCategoryData(); // Use the getData method from the DataService
      setState(() {
        categories = response;
      });
    } catch (e) {
      print('Failed to load detail: $e');
    }
  }
  

  void updateProduct() async {
    try {
      // Validate the input fields
      if (_selectedImage != null) {
        if (productNameController.text.isEmpty) {
          // Show error message if product name is empty
          TLoaders.errorSnackBar(
            title: 'Cập nhật',
            message: 'Vui lòng nhập tên sản phẩm'.tr,
          );
          return;
        }
      }

      // Check if the user wants to update the image or other fields
      bool updateImageOrFields = _selectedImage != null ||
          priceController.text.isNotEmpty ||
          percentDisController.text.isNotEmpty ||
          stockQlController.text.isNotEmpty ||
          descriptionController.text.isNotEmpty ||
          selectedCategoryId != null;

      // Create a new instance of ProductWithImageInput
      ProductWithImageInput productInput = ProductWithImageInput(
        productName: productNameController.text,
        price: int.tryParse(priceController.text),
        percentDis: int.tryParse(percentDisController.text),
        stockQl: int.tryParse(stockQlController.text),
        description: descriptionController.text,
        categoryId: selectedCategoryId,
        imageFile: _selectedImage,
      );

      // Update both product name and image if an image is selected or other fields are updated
      if (updateImageOrFields) {
        // Call the API to update the product
        await product.updateProduct(
          widget.productId,
          productInput,
        );
      } else {
        // Update only product name
        // Remove price, percentDis, stockQl, description, and categoryId from the productInput
        productInput = ProductWithImageInput(
          productName: productNameController.text,
        );

        // Call the API to update the product name
        await product.updateProduct(
          widget.productId,
          productInput,
        );
      }

      // Show success message and navigate back
      TLoaders.successSnackBar(
        title: 'Cập nhật',
        message: 'Cập nhật sản phẩm thành công'.tr,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NavigationAdminMenu(), // Replace ProductScreen with your actual product screen
        ),
      );
    } catch (e) {
      // Show error message if updating the product fails
      print('Error updating category: $e');
      TLoaders.errorSnackBar(
        title: 'Cập nhật',
        message: 'Cập nhật sản phẩm thất bại'.tr,
      );
    }
  }

  
  
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
                _selectedImage != null 
                    ? Image.file(_selectedImage!, height: 200, width: 200, fit: BoxFit.contain)
                    : _productImageUrl != null
                    ? Image(image: NetworkImage(_productImageUrl!), height: 200, width: 200, fit: BoxFit.contain)
                      : const Image(image: AssetImage(TImages.hoa1), width: 200, height: 200,),
                
                const SizedBox(height: TSizes.spaceBtwInputFields),

                // Product name
                TextFormField(
                  controller: productNameController,
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.new_label), labelText: 'Tên sản phẩm'),
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
                  decoration: const InputDecoration(prefixIcon: Icon(Icons.attach_money), labelText: 'Giá tiền (VNĐ)')
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
                
                
                const SizedBox(height: TSizes.defaultSpace),
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: updateProduct, style: ElevatedButton.styleFrom(backgroundColor: TColors.darkPrimary), child: const Text('Lưu'),),)
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