import 'dart:convert';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/data/models/Cart.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/CategoryWithImageInput.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/models/ProductWithImageInput.dart';
import 'package:t_store/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class CartApiHandler {
  final String baseUri = APIConstants.apiUri;

  Future<List<dynamic>> getCartsByEmail(String email) async {
    try {
      final token = await AuthUserApiHandler.getToken();
        if (token == null) {
          // Token không tồn tại, xử lý lỗi và trả về một danh sách rỗng
          print('Token is null');
          return [];
        }
      final response = await http.get(
        Uri.parse('$baseUri/api/carts/users/$email/carts'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData;
      } else {
        throw Exception('Failed to get carts products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get carts products: $e');
    }
  }

  Future<String?> addToCart(int userId, int productId) async {
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi
        return 'Token is null'; // Indicate the error condition
      }

      final response = await http.post(
        Uri.parse('$baseUri/api/carts/users/$userId/cart/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Product added to cart successfully
        print('Thêm sản phẩm vào giỏ hàng thành công.');
        return 'Thêm sản phẩm vào giỏ hàng thành công'; // Return success message
      } else if (response.statusCode == 201) {
        // Product created in cart successfully
        print('Thêm sản phẩm vào giỏ hàng thành công.');
        return 'Thêm sản phẩm vào giỏ hàng thành công'; // Return success message
      } else {
        // Failed to add product to cart
        print('Thêm sản phẩm vào giỏ hàng thất bại.');
        print('Status code: ${response.statusCode}');
        print('Error message: ${response.body}');
        return 'Thêm sản phẩm vào giỏ hàng thất bại'; // Return failure message
      }
    } catch (e) {
      // Error occurred during HTTP request
      print('Thêm sản phẩm vào giỏ hàng thất bại: $e');
      return 'Thêm sản phẩm vào giỏ hàng thất bại: $e'; // Return error message
    }
  }


  Future<String?> removeFromCart(int userId, int productId) async {
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi
        return 'Token is null'; // Indicate the error condition
      }

      final response = await http.put(
        Uri.parse('$baseUri/api/carts/users/$userId/cart/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Product added to cart successfully
        print('Cập nhật giỏ hàng thành công.');
        return 'Cập nhật giỏ hàng thành công'; // Return success message
      } else {
        // Failed to add product to cart
        print('Cập nhật giỏ hàng thất bại.');
        print('Status code: ${response.statusCode}');
        print('Error message: ${response.body}');
        return 'Cập nhật giỏ hàng thất bại'; // Return failure message
      }
    } catch (e) {
      // Error occurred during HTTP request
      print('Cập nhật giỏ hàng thất bại: $e');
      return 'Cập nhật giỏ hàng thất bại: $e'; // Return error message
    }
  }



}