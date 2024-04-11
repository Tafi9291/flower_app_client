import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:t_store/api/category_api_handler.dart';
import 'package:t_store/common/widgets/image_text_widgets/vertical_image_text.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/services/data_service.dart';
import 'package:t_store/features/shop/screens/sub_category/sub_categories.dart';
import 'package:t_store/utils/constants/image_strings.dart';

class THomeCategories extends StatefulWidget {
  const THomeCategories({super.key});

  @override
  State<THomeCategories> createState() => _THomeCategoriesState();
}

class _THomeCategoriesState extends State<THomeCategories> {

  CategoryApiHandler categoryApiHandler = CategoryApiHandler();
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
    return SizedBox(
      height: 130,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: data.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return TVerticalImageText(
            image: data[index].imageUrl != null && data[index].imageUrl!.isNotEmpty ? data[index].imageUrl! : TImages.hoa1, 
            // image: TImages.hoa1,
            title: data[index].categoryName,
            onTap: () => Get.to(() => const SubCategoriesScreen()),
            isNetWorkImage: true,
          );
        },
      ),
    );
  }
}

