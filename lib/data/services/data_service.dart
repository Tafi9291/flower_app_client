import 'package:t_store/api/category_api_handler.dart';
import 'package:t_store/api/order_api_handler.dart';
import 'package:t_store/api/product_api_handler.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/Order.dart';
import 'package:t_store/data/models/Product.dart';

class DataService {
  final CategoryApiHandler cate = CategoryApiHandler();
  final ProductApiHandler pro = ProductApiHandler();
  final OrderApiHandler od = OrderApiHandler();

  Future<List<Category>> getCategoryData() async {
    return await cate.getCategories();
  }

  Future<List<Product>> getProductData() async {
    return await pro.getProducts();
  }

  Future<List<Order>> getOrderData() async {
    return await od.getOrders();
  }
}