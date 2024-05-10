import 'dart:convert';
import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/CategoryWithImageInput.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/models/ProductWithImageInput.dart';
import 'package:t_store/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class ProductApiHandler {
  final String baseUri = APIConstants.apiUri;

  Future<List<Product>> getProducts() async {
    List<Product> data = [];
    final uri = Uri.parse('$baseUri/api/products');
    try {
      final response = await http.get(
        uri,
        headers: <String, String> {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        // Handle error response
        print('Failed to load products: ${response.statusCode}');
      }
    } catch (e) {
      print(e);
    }
    return data;
  }

  Future<Product?> addProduct(ProductWithImageInput productInput) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUri/api/products'),
      );

      // Calculate salePrice
      int prices = productInput.price!;
      int percentDiss = productInput.percentDis!;
      int salePrice = prices - (prices * percentDiss / 100).round();

      // Convert integers to strings
      String priceString = prices.toString();
      String percentDisString = percentDiss.toString();
      String salePriceString = salePrice.toString();

      // Add Product name field
      request.fields['productName'] = productInput.productName!;
      request.fields['price'] = priceString;
      request.fields['percentDis'] = percentDisString;
      request.fields['salePrice'] = salePriceString;
      request.fields['categoryId'] = productInput.categoryId!.toString();
      request.fields['stockQl'] = productInput.stockQl!.toString();
      request.fields['description'] = productInput.description!;
      request.fields['quantitySold'] = '0';

      // Add image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'imageFile', // This should match the name used in the ASP.NET Core controller
          productInput.imageFile!.path,
        ),
      );

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 201) {
        // Product added successfully, parse the response body
        var responseBody = await response.stream.bytesToString();
        var product = Product.fromJson(json.decode(responseBody));
        return product;
      } else {
        // Handle error
        print('Failed to add category. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error adding category: $e');
      return null;
    }
  }

  Future<Product?> getProductById(int productId) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUri/api/products/$productId'),
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Product retrieved successfully, parse the response body
        var responseBody = response.body;
        var product = Product.fromJson(json.decode(responseBody));
        return product;
      } else {
        // Handle error
        print('Failed to get product. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting product: $e');
      return null;
    }
  }


  Future<void> updateProduct(int id, ProductWithImageInput productInput) async {
    try {
      var uri = Uri.parse('$baseUri/api/products/$id');
      var request = http.MultipartRequest('PUT', uri);

      // Calculate salePrice
      int prices = productInput.price!;
      int percentDiss = productInput.percentDis!;
      int salePrice = prices - (prices * percentDiss / 100).round();

      // Convert integers to strings
      String priceString = prices.toString();
      String percentDisString = percentDiss.toString();
      String salePriceString = salePrice.toString();

      // Add category name field if it's not null
      if (productInput.productName != null) {
        request.fields['productId'] = id.toString();
        request.fields['productName'] = productInput.productName!;
        request.fields['price'] = priceString;
        request.fields['percentDis'] = percentDisString;
        request.fields['salePrice'] = salePriceString;
        request.fields['categoryId'] = productInput.categoryId!.toString();
        request.fields['stockQl'] = productInput.stockQl!.toString();
        request.fields['description'] = productInput.description!;
        request.fields['quantitySold'] = '0';
      }

      // Add image file if it's being updated
      if (productInput.imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'imageFile',
          productInput.imageFile!.path,
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Product updated successfully');
      } else {
        print('Failed to update product. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<List<dynamic>> getFavoriteProductsByEmail(String email) async {
    try {
      final token = await AuthUserApiHandler.getToken();
        if (token == null) {
          // Token không tồn tại, xử lý lỗi và trả về một danh sách rỗng
          print('Token is null');
          return [];
        }
      final response = await http.get(
        Uri.parse('$baseUri/api/products/users/$email/favorites'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> favoriteProducts = json.decode(response.body);
        return favoriteProducts;
      } else {
        throw Exception('Failed to get favorite products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get favorite products: $e');
    }
  }

  Future<String?> addToFavorite(String email, int productId) async {
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi
        return null;
      }

      final response = await http.post(
        Uri.parse('$baseUri/api/products/users/$email/favorites/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return 'Đã thêm sản phẩm vào mục yêu thích.';
      } else if (response.statusCode == 401) {
        return 'Unauthorized: Invalid or missing user email.';
      } else if (response.statusCode == 404) {
        return 'User or product not found.';
      } else if (response.statusCode == 409) {
        return 'Conflict: Product already exists in favorites.';
      } else {
        return 'Failed to add product to favorites.';
      }
    } catch (e) {
      print('Error during add to favorite: $e');
      return null;
    }
  }

  Future<String?> removeFromFavorite(String email, int productId) async {
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi
        return null;
      }

      final response = await http.delete(
        Uri.parse('$baseUri/api/products/users/$email/favorites/$productId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return 'Đã xóa sản phẩm khỏi mục yêu thích.';
      } else if (response.statusCode == 401) {
        return 'Unauthorized: Invalid or missing user email.';
      } else if (response.statusCode == 404) {
        return 'User or product not found.';
      } else if (response.statusCode == 409) {
        return 'Conflict: Product does not exist in favorites.';
      } else {
        return 'Failed to remove product from favorites.';
      }
    } catch (e) {
      print('Error during add to favorite: $e');
      return null;
    }
  }

  Future<String> deleteProduct(int id) async {
    final url = Uri.parse('$baseUri/api/products/$id');
    try {
      final response = await http.delete(url);
      if (response.statusCode == 200) {
        // Xóa thành công
        print('Xóa sản phẩm thành công');
        return "Xóa sản phẩm thành công";
      } else if (response.statusCode == 404) {
        // Không tìm thấy danh mục
        print('Không tìm thấy sản phẩm');
        return "Không tìm thấy sản phẩm";
      } else if (response.statusCode == 500) {
        // Xử lý các mã lỗi khác nếu cần
        print('Sản phẩm đang được sử dụng');
        return "Sản phẩm đang được sử dụng. Không thể xóa";
      }
    } catch (e) {
      // Xử lý lỗi kết nối hoặc lỗi khác
      print('Lỗi: $e');
      throw 'Lỗi: $e';
    }
    return 'error';
  }


}