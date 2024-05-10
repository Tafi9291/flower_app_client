import 'package:t_store/data/models/Order.dart';

class OrderStatus {
  int? orderStatusId;
  String? orderStatus;
  List<Order> orders;

  OrderStatus({
    required this.orderStatusId,
    this.orderStatus,
    this.orders = const [],
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      orderStatusId: json['orderStatusId'] as int?,
      orderStatus: json['orderStatus1'],
      orders: json['Orders'] != null ? List<Order>.from(json['Orders'].map((x) => Order.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'orderStatusId': orderStatusId,
    'orderStatus1': orderStatus,
    'Orders': orders.map((order) => order.toJson()).toList(),
  };
}
