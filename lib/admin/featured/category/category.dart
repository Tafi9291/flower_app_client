import 'package:t_store/api/category_api_handler.dart';
import 'package:t_store/admin/common/widgets/appbar/appbar.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/admin/featured/category/add_category.dart';
import 'package:t_store/admin/featured/category/widgets/category_item.dart';
import 'package:t_store/utils/constants/colors.dart';
import 'package:t_store/utils/constants/image_strings.dart';
import 'package:t_store/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {

  final CategoryApiHandler cate = CategoryApiHandler();
  late List<Category> data = [];

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
        data = response;
      });
    } catch (e) {
      print('Failed to load admin detail: $e');
    }
  }

  


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: TAppBar(
        leadingIcon: Icons.menu, 
        leadingOnPressed: (){Scaffold.of(context).openDrawer();},
        title: const Text('Phân loại sản phẩm'),
      ),
      body: Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index){
              return Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: TCategoryItem(
                  title: data[index].categoryName, 
                  imageUrl: data[index].imageUrl != null && data[index].imageUrl!.isNotEmpty ? data[index].imageUrl! : TImages.hoa1,
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: TColors.primary,
            foregroundColor: Colors.black,
            onPressed: () => Get.to(() => const AddCategoryScreen()),
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}