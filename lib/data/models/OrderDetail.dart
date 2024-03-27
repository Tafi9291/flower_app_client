import 'package:t_store/data/models/Order.dart';
import 'package:t_store/data/models/Product.dart';

class OrderDetail {
  int orderDetailId;
  int? quantity;
  int? price;
  int? totalPrice;
  int? orderId;
  int? productId;
  Order? order;
  Product? product;

  OrderDetail({
    required this.orderDetailId,
    this.quantity,
    this.price,
    this.totalPrice,
    this.orderId,
    this.productId,
    this.order,
    this.product,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      orderDetailId: json['OrderDetailId'],
      quantity: json['Quantity'],
      price: json['Price'],
      totalPrice: json['TotalPrice'],
      orderId: json['OrderId'],
      productId: json['ProductId'],
      order: json['Order'] != null ? Order.fromJson(json['Order']) : null,
      product: json['Product'] != null ? Product.fromJson(json['Product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'OrderDetailId': orderDetailId,
      'Quantity': quantity,
      'Price': price,
      'TotalPrice': totalPrice,
      'OrderId': orderId,
      'ProductId': productId,
      'Order': order?.toJson(),
      'Product': product?.toJson(),
    };
  }
}