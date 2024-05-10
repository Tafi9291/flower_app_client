import 'dart:convert';
import 'package:t_store/data/models/Address.dart';
import 'package:t_store/data/models/AddressCreateModel.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/CategoryWithImageInput.dart';
import 'package:t_store/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class AddressApiHandler {
  final String baseUri = APIConstants.apiUri;

  Future<List<Address>> getAddressesByUserId(int userId) async {
    List<Address> data = [];
    final uri = Uri.parse('$baseUri/api/addresses/user/$userId');
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
          data = jsonData.map((json) => Address.fromJson(json)).toList();
        }
      } 
    } catch (e) {
      print(e);
      return data;
    }
    return data;
  }

  Future<String> createAddress(AddressCreateModel model) async {
    final uri = Uri.parse('$baseUri/api/addresses/create');

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(model.toJson()),
      );

      if (response.statusCode == 200) {
        return 'Address created successfully';
      } else {
        return 'Failed to create address. Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Internal server error: $e';
    }
  }



}