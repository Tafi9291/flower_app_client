import 'package:t_store/data/models/Notification.dart';
import 'package:t_store/data/models/OrderDetail.dart';
import 'package:t_store/data/models/OrderStatus.dart';
import 'package:t_store/data/models/PaymentMethod.dart';
import 'package:t_store/data/models/Users.dart';

class Order {
  int orderId;
  int? shipPrice;
  int? finalPrice;
  DateTime? createAt;
  DateTime? updateAt;
  String? address;
  int? usersId;
  int? orderStatusId;
  int? paymentMethodId;
  List<Notification> notifications;
  List<OrderDetail>? orderDetails;
  OrderStatus? orderStatus;
  PaymentMethod? paymentMethod;
  Users? users;

  Order({
    required this.orderId,
    this.shipPrice,
    this.finalPrice,
    this.createAt,
    this.updateAt,
    this.address,
    this.usersId,
    this.orderStatusId,
    this.paymentMethodId,
    this.notifications = const [],
    this.orderDetails = const [],
    this.orderStatus,
    this.paymentMethod,
    this.users,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['orderId'],
      shipPrice: json['shipPrice'],
      finalPrice: json['finalPrice'],
      createAt: json['createAt'] != null ? DateTime.parse(json['createAt']) : null,
      updateAt: json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
      address: json['address'],
      usersId: json['usersId'],
      orderStatusId: json['orderStatusId'],
      paymentMethodId: json['paymentMethodId'],
      notifications: json['Notifications'] != null ? List<Notification>.from(json['Notifications'].map((x) => Notification.fromJson(x))) : [],
      orderDetails: json['OrderDetails'] != null ? List<OrderDetail>.from(json['OrderDetails'].map((x) => OrderDetail.fromJson(x))) : [],
      orderStatus: json['OrderStatus'] != null ? OrderStatus.fromJson(json['OrderStatus']) : null,
      paymentMethod: json['PaymentMethod'] != null ? PaymentMethod.fromJson(json['PaymentMethod']) : null,
      users: json['Users'] != null ? Users.fromJson(json['Users']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'OrderId': orderId,
    'ShipPrice': shipPrice,
    'FinalPrice': finalPrice,
    'CreateAt': createAt?.toIso8601String(),
    'UpdateAt': updateAt?.toIso8601String(),
    'Address': address,
    'UsersId': usersId,
    'OrderStatusId': orderStatusId,
    'PaymentMethodId': paymentMethodId,
    'Notifications': notifications.map((notification) => notification.toJson()).toList(),
    'OrderDetails': orderDetails?.map((orderDetail) => orderDetail.toJson()).toList(),
    'OrderStatus': orderStatus?.toJson(),
    'PaymentMethod': paymentMethod?.toJson(),
    'Users': users?.toJson(),
  };
}