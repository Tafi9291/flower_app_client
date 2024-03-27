import 'package:t_store/data/models/Order.dart';

class PaymentMethod {
  int paymentMethodId;
  String? paymentMethod;
  List<Order> orders;

  PaymentMethod({
    required this.paymentMethodId,
    this.paymentMethod,
    this.orders = const [],
  });

  factory PaymentMethod.fromJson(Map<String, dynamic> json) {
    return PaymentMethod(
      paymentMethodId: json['PaymentMethodId'],
      paymentMethod: json['PaymentMethod'],
      orders: json['Orders'] != null ? List<Order>.from(json['Orders'].map((x) => Order.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'PaymentMethodId': paymentMethodId,
    'PaymentMethod': paymentMethod,
    'Orders': orders.map((order) => order.toJson()).toList(),
  };
}
