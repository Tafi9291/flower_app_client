import 'package:intl/intl.dart';
import 'package:t_store/admin/featured/products/widgets/product_card.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/common/widgets/layouts/gird_layouts.dart';
import 'package:t_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:t_store/api/product_api_handler.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/services/data_service.dart';


class TSortableProducts extends StatefulWidget {
  const TSortableProducts({super.key});

  @override
  State<TSortableProducts> createState() => _TSortableProductsState();
}

class _TSortableProductsState extends State<TSortableProducts> {

  final ProductApiHandler pro = ProductApiHandler();
  late List<Product> dataPro = [];
  late List<Category> dataCate = [];

  final DataService  dataService = DataService();

  int? selectedCategoryId;

  @override
  void initState() {
    super.initState();
    getProductData();
    getCategoryData();
  }

  void getCategoryData() async {
    try {
      final List<Category> response = await dataService.getCategoryData(); // Use the getData method from the DataService
      setState(() {
        dataCate = response;
      });
    } catch (e) {
      print('Failed to load detail: $e');
    }
  }

  void getProductData() async {
    try {
      final List<Product> response = await dataService.getProductData(); // Use the getData method from the DataService
      setState(() {
        dataPro = response;
      });
    } catch (e) {
      print('Failed to load detail: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     /// Dropdown
    //     DropdownButtonFormField(
    //       decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
    //       onChanged: (value){},
    //       items: ['Name', 'Higher Price', 'Lower Price', 'Sale', 'Newest', 'Popularity']
    //           .map((option) => DropdownMenuItem(value: option, child: Text(option))).toList(),
    //     ),
    //     const SizedBox(height: TSizes.spaceBtwSections),
    
    //     /// Products
    //     TGridLayout(itemCount: 8, itemBuilder: (_, index) => const TProductCardVertical()),
    //   ],
    // );
    return Column(
      children: [
        /// Dropdown
        DropdownButtonFormField<int?>(
          value: selectedCategoryId,
          decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort), labelText: 'Phân loại'),
          dropdownColor: const Color.fromARGB(255, 221, 236, 218),
          items: [
            const DropdownMenuItem(
              value: null,
              child: Text('Tất cả'),
            ),
            ...dataCate.map((Category category) {
              return DropdownMenuItem(
                value: category.categoryId,
                child: Text(category.categoryName),
              );
            }).toList(),
          ],
          onChanged: (int? newValue) {
            setState(() {
              selectedCategoryId = newValue;
            });
          },
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
    
        /// Products
        Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(), 
            itemCount: dataPro.length, 
            itemBuilder: (_, index) {
              // Lọc danh sách sản phẩm nếu có danh mục được chọn
              if (selectedCategoryId != null && dataPro[index].category!.categoryId != selectedCategoryId) {
                return const SizedBox.shrink();
              }
              return Padding(
                padding: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
                child: TProductCard(
                  productId: dataPro[index].productId,
                  name: dataPro[index].productName,
                  image: dataPro[index].imageUrl != null && dataPro[index].imageUrl!.isNotEmpty ? dataPro[index].imageUrl! : TImages.hoa1,
                  // category: dataPro[index].categoryId != null ? dataPro[index].categoryId.toString() : 'Unknown',
                  category:  dataPro[index].category!.categoryName,
                  price: NumberFormat("#,##0").format(dataPro[index].salePrice ?? 0),
                  stockQl: dataPro[index].stockQl ?? 0,
                  
                ),
              );
            }
          ),
        ),
      ],
    );
  }
}
