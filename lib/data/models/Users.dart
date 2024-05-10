
import 'package:t_store/data/models/Address.dart';
import 'package:t_store/data/models/Cart.dart';
import 'package:t_store/data/models/Order.dart';
import 'package:t_store/data/models/Product.dart';

class Users {
  int usersId;
  String firstName;
  String lastName;
  String nickName;
  String email;
  String password;
  String? phoneNumber;
  DateTime? birthDay;
  String? imageUrl;
  String? gender;
  DateTime? createAt;
  DateTime? updateAt;
  int? rolesId;
  List<Address>? addresses;
  List<Cart>? carts;
  // List<Notification> notifications;
  List<Order>? orders;
  // Role? roles;
  List<Product>? products;

  Users({
    required this.usersId,
    required this.firstName,
    required this.lastName,
    required this.nickName,
    required this.email,
    required this.password,
    this.phoneNumber,
    this.birthDay,
    this.imageUrl,
    this.gender,
    this.createAt,
    this.updateAt,
    this.rolesId,
    this.addresses = const [],
    this.carts = const [],
    // this.notifications = const [],
    this.orders = const [],
    // this.roles,
    this.products = const [],
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      usersId: json['UsersId'] ?? 0,
      firstName: json['FirstName'] ?? '',
      lastName: json['LastName'] ?? '',
      nickName: json['NickName'] ?? '',
      email: json['Email'] ?? '',
      password: json['Password'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      birthDay: parseDateTime(json['BirthDay']),
      imageUrl: json['ImageUrl'] ?? '',
      gender: json['Gender'] ?? '',
      createAt: parseDateTime(json['CreateAt']),
      updateAt: parseDateTime(json['UpdateAt']),
      rolesId: json['RolesId'] ?? 0,
      addresses: json['Carts'] != null
        ? List<Address>.from(json['Addresses'].map((x) => Address.fromJson(x)))
        : [],
      products: json['Products'] != null
        ? List<Product>.from(json['Products'].map((x) => Product.fromJson(x)))
        : [],
      carts: json['Carts'] != null
        ? List<Cart>.from(json['Carts'].map((x) => Cart.fromJson(x)))
        : [],
      orders: json['Order'] != null
        ? List<Order>.from(json['Order'].map((x) => Order.fromJson(x)))
        : [],
      // Bạn cần xử lý các danh sách và đối tượng Roles ở đây nếu cần
    );
  }

  static DateTime? parseDateTime(dynamic value) {
    if (value != null && value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        print('Failed to parse DateTime: $e');
      }
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
    "UsersId": usersId,
    "FirstName": firstName,
    "LastName": lastName,
    "NickName": nickName,
    "Email": email,
    "Password": password,
    "PhoneNumber": phoneNumber,
    "BirthDay": birthDay?.toIso8601String(), // Chuyển đổi DateTime sang chuỗi ISO 8601
    "ImageUrl": imageUrl,
    "Gender": gender,
    "CreateAt": createAt?.toIso8601String(), // Chuyển đổi DateTime sang chuỗi ISO 8601
    "UpdateAt": updateAt?.toIso8601String(), // Chuyển đổi DateTime sang chuỗi ISO 8601
    "RolesId": rolesId,
    'Addresses': addresses?.map((user) => user.toJson()).toList(),
    'Products': products?.map((user) => user.toJson()).toList(),
    'Carts': carts?.map((user) => user.toJson()).toList(),
    'Order': orders?.map((user) => user.toJson()).toList(),
    // Bạn cũng cần xử lý các danh sách và đối tượng Roles ở đây nếu cần
  };
}
