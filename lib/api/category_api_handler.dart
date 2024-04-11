import 'dart:convert';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/CategoryWithImageInput.dart';
import 'package:t_store/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class CategoryApiHandler {
  final String baseUri = APIConstants.apiUri;

  Future<List<Category>> getCategories() async {
    List<Category> data = [];
    final uri = Uri.parse('$baseUri/api/categories');
    try {
      final response = await http.get(
        uri,
        headers: <String, String> {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
      // print(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final dynamic jsonData = json.decode(response.body);
        if (jsonData is List) {
          // Directly parse the responseData array
          data = jsonData.map((json) => Category.fromJson(json)).toList();
        }
      } 
    } catch (e) {
      print(e);
      return data;
    }
    return data;
  }

  Future<Category?> addCategory(CategoryWithImageInput categoryInput) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$baseUri/api/categories'),
      );

      // Add category name field
      request.fields['categoryName'] = categoryInput.categoryName!;

      // Add image file
      request.files.add(
        await http.MultipartFile.fromPath(
          'imageFile', // This should match the name used in the ASP.NET Core controller
          categoryInput.imageFile!.path,
        ),
      );

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 201) {
        // Category added successfully, parse the response body
        var responseBody = await response.stream.bytesToString();
        var category = Category.fromJson(json.decode(responseBody));
        return category;
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

  Future<Category?> getCategoryById(int categoryId) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUri/api/categories/$categoryId'),
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Category retrieved successfully, parse the response body
        var responseBody = response.body;
        var category = Category.fromJson(json.decode(responseBody));
        return category;
      } else {
        // Handle error
        print('Failed to get category. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error getting category: $e');
      return null;
    }
  }


  Future<void> updateCategory(int id, CategoryWithImageInput categoryInput) async {
    try {
      var uri = Uri.parse('$baseUri/api/categories/$id');
      var request = http.MultipartRequest('PUT', uri);

      // Add category name field if it's not null
      if (categoryInput.categoryName != null) {
        request.fields['categoryId'] = id.toString();
        request.fields['categoryName'] = categoryInput.categoryName!;
      }

      // Add image file if it's being updated
      if (categoryInput.imageFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'imageFile',
          categoryInput.imageFile!.path,
        ));
      }

      var response = await request.send();

      if (response.statusCode == 200) {
        print('Category updated successfully');
      } else {
        print('Failed to update category. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error updating category: $e');
    }
  }


}