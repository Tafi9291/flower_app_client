import 'dart:convert';
import 'package:t_store/data/models/Category.dart';
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

  Future<http.Response> addCategory({required Category category}) async {
  final uri = Uri.parse('$baseUri/api/categories');

  late http.Response response;

    try {
      response = await http.post(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
        body: json.encode(category),
      );

    } catch (e) {
      return response;
    }
    return response;
}
}