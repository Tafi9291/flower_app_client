import 'dart:convert';
import 'package:t_store/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthUserApiHandler {
  final String baseUri = APIConstants.apiUri;

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUri/api/user/loginUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'FirstName': "",
          'LastName': "",
          'NickName': "",
          'Email': email,
          'Password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final token = responseData['token'];

        // Lưu token vào SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return token;
      } else {
        // Handle error
        return null;
      }
    } catch (e) {
      // Handle exception
      print('Error during login: $e');
      return null;
    }
  }

  Future<String?> register(String firstName, String lastName, String nickName, String email, String phoneNumber, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUri/api/user/registerUser'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'FirstName': firstName,
          'LastName': lastName,
          'NickName': nickName,
          'Email': email,
          'PhoneNumber': phoneNumber,
          'Password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final token = responseData['token'];

        // Lưu token vào SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        return token;
      } else {
        // Handle error
        return null;
      }
    } catch (e) {
      // Handle exception
      print('Error during registration: $e');
      return null;
    }
  }

  Future<bool> checkEmailExist(String email) async {
    final String apiUrl = '$baseUri/api/user/emailExist?email=$email';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        // Trả về true nếu email không tồn tại
        return true;
      } else if (response.statusCode == 400) {
        // Trả về false nếu email đã tồn tại
        return false;
      } else {
        // Xử lý trường hợp khác nếu cần
        return false;
      }
    } catch (e) {
      // Xử lý nếu có lỗi xảy ra
      print('Error checking email existence: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> getUserDetail() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('$baseUri/api/user/getuserDetail'),
      headers: <String, String>{
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to load admin detail');
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
    } catch (e) {
      print('Error during logout: $e');
    }
  }

  
}