import 'package:t_store/api/category_api_handler.dart';
import 'package:t_store/data/models/Category.dart';

class DataService {
  final CategoryApiHandler cate = CategoryApiHandler();

  Future<List<Category>> getCategoryData() async {
    return await cate.getCategories();
  }
}