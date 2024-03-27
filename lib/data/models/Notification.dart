import 'package:t_store/data/models/Order.dart';
import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/models/Users.dart';

class Notification {
  int notiId;
  String? message;
  DateTime? createAt;
  String? status;
  int? orderId;
  int? productId;
  int? usersId;
  Order? order;
  Product? product;
  Users? users;

  Notification({
    required this.notiId,
    this.message,
    this.createAt,
    this.status,
    this.orderId,
    this.productId,
    this.usersId,
    this.order,
    this.product,
    this.users,
  });

  factory Notification.fromJson(Map<String, dynamic> json) {
    return Notification(
      notiId: json['NotiId'],
      message: json['Message'],
      createAt: json['CreateAt'] != null ? DateTime.parse(json['CreateAt']) : null,
      status: json['Status'],
      orderId: json['OrderId'],
      productId: json['ProductId'],
      usersId: json['UsersId'],
      order: json['Order'] != null ? Order.fromJson(json['Order']) : null,
      product: json['Product'] != null ? Product.fromJson(json['Product']) : null,
      users: json['Users'] != null ? Users.fromJson(json['Users']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'NotiId': notiId,
    'Message': message,
    'CreateAt': createAt?.toIso8601String(),
    'Status': status,
    'OrderId': orderId,
    'ProductId': productId,
    'UsersId': usersId,
    'Order': order?.toJson(),
    'Product': product?.toJson(),
    'Users': users?.toJson(),
  };
}