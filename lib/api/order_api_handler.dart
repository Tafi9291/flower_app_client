import 'dart:convert';

import 'package:t_store/api/auth_api_handler.dart';
import 'package:t_store/data/models/Order.dart';
import 'package:t_store/data/models/OrderDetail.dart';
import 'package:t_store/data/models/OrderStatus.dart';
import 'package:t_store/utils/constants/api_constants.dart';
import 'package:http/http.dart' as http;

class OrderApiHandler {
  final String baseUri = APIConstants.apiUri;

  Future<List<Order>> getOrders() async {
    List<Order> data = [];
    final uri = Uri.parse('$baseUri/api/orders');
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi hoặc yêu cầu người dùng đăng nhập lại
        print("Token not found. Please log in.");
        return [];
      }
      final response = await http.get(
        uri,
        headers: <String, String> {
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',

        },
      );
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final dynamic jsonData = json.decode(response.body);
        if (jsonData is List) {
          // Directly parse the responseData array
          data = jsonData.map((json) => Order.fromJson(json)).toList();
        }
      } 
    } catch (e) {
      print(e);
      return data;
    }
    return data;
  }

  Future<Order?> getOrderById(int orderId) async {
    final uri = Uri.parse('$baseUri/api/orders/$orderId');
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi
        print("Token not found. Please log in.");
      } // Thay token bằng token xác
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      // Check the response status
      if (response.statusCode == 200) {
        // Category retrieved successfully, parse the response body
        var responseBody = response.body;
        var order = Order.fromJson(json.decode(responseBody));
        return order;
      } else {
        // Handle error
        print('Failed to get category. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error loading order status: $e');
    }
    return null;
  }

  Future<OrderDetail?> getOrderDetailById(int orderId) async {
    final uri = Uri.parse('$baseUri/api/orders/$orderId/details');
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi
        print("Token not found. Please log in.");
      } // Thay token bằng token xác
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      // Check the response status
      if (response.statusCode == 200) {
        // Category retrieved successfully, parse the response body
        var responseBody = response.body;
        var order = OrderDetail.fromJson(json.decode(responseBody));
        return order;
      } else {
        // Handle error
        print('Failed to get category. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error loading order status: $e');
    }
    return null;
  }

  Future<List<Order>> getOrdersByUser(int userId) async {
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi hoặc yêu cầu người dùng đăng nhập lại
        print("Token not found. Please log in.");
        return [];
      }

      final response = await http.get(
        Uri.parse('$baseUri/api/orders/user/$userId'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // Phân tích các đơn hàng từ phản hồi
        final List<dynamic> responseData = jsonDecode(response.body);
        return responseData.map((json) => Order.fromJson(json)).toList();
      } else {
        print('Failed to fetch orders: ${response.statusCode}');
        // Xử lý lỗi ở đây nếu cần
        return [];
      }
    } catch (e) {
      print("Error fetching orders: $e");
      return [];
    }
  }

  Future<void> createOrder(int userId, int? addressId) async {
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi
        print("Token not found. Please log in.");
        return;
      }

      // Tạo dữ liệu yêu cầu
      var requestBody = {'addressId': addressId};

      final response = await http.post(
        Uri.parse('$baseUri/api/orders/user/$userId/create'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Order created successfully.');
        // Xử lý đơn hàng được tạo thành công ở đây nếu cần
      } else {
        print('Failed to create order: ${response.statusCode}');
        // Xử lý lỗi ở đây nếu cần
      }
    } catch (e) {
      print("Error creating order: $e");
    }
  }

  Future<void> updateOrder(int orderId, int? orderStatusId) async {
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi
        print("Token not found. Please log in.");
        return;
      }

      // Tạo dữ liệu yêu cầu
      var requestBody = {'orderStatusId': orderStatusId};

      final response = await http.post(
        Uri.parse('$baseUri/api/orders/$orderId/update'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        print('Order created successfully.');
        // Xử lý đơn hàng được tạo thành công ở đây nếu cần
      } else {
        print('Failed to create order: ${response.statusCode}');
        // Xử lý lỗi ở đây nếu cần
      }
    } catch (e) {
      print("Error creating order: $e");
    }
  }



  Future<List<OrderStatus>> getOrderStatus() async {
    final uri = Uri.parse('$baseUri/api/orders/orderStatus');
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        // Kiểm tra dữ liệu trả về từ API
        final responseData = json.decode(response.body);
        if (responseData != null && responseData is List) {
          // Phân tích dữ liệu JSON và trả về danh sách trạng thái đơn hàng
          List<OrderStatus> orderStatusList = responseData
              .map<OrderStatus>((json) => OrderStatus.fromJson(json))
              .toList();
          return orderStatusList;
        } else {
          print('Invalid response data format');
          return [];
        }
      } else {
        // Nếu yêu cầu thất bại, in mã trạng thái và thông báo lỗi
        print('Failed to load order status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error loading order status: $e');
      return [];
    }
  }

  Future<List<OrderDetail>> getOrderDetail() async {
    final uri = Uri.parse('$baseUri/api/orders/orderDetail');
    try {
      final token = await AuthUserApiHandler.getToken();
      if (token == null) {
        // Token không tồn tại, xử lý lỗi
        print("Token not found. Please log in.");
        return [];
      } // Thay token bằng token xác
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        // Kiểm tra dữ liệu trả về từ API
        final responseData = json.decode(response.body);
        if (responseData != null && responseData is List) {
          // Phân tích dữ liệu JSON và trả về danh sách trạng thái đơn hàng
          List<OrderDetail> orderDetailList = responseData
              .map<OrderDetail>((json) => OrderDetail.fromJson(json))
              .toList();
          return orderDetailList;
        } else {
          print('Invalid response data format');
          return [];
        }
      } else {
        // Nếu yêu cầu thất bại, in mã trạng thái và thông báo lỗi
        print('Failed to load order status: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Xử lý lỗi nếu có
      print('Error loading order status: $e');
      return [];
    }
  }



}