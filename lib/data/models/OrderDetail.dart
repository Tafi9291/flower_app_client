import 'package:t_store/data/models/Order.dart';
import 'package:t_store/data/models/Product.dart';

class OrderDetail {
  int? orderDetailId;
  int? quantity;
  int? price;
  int? totalPrice;
  int? orderId;
  int? productId;
  // Order? order;
  // Product? product;

  OrderDetail({
    required this.orderDetailId,
    this.quantity,
    this.price,
    this.totalPrice,
    this.orderId,
    this.productId,
    // this.order,
    // this.product,
  });

  factory OrderDetail.fromJson(Map<String, dynamic> json) {
    return OrderDetail(
      orderDetailId: json['orderDetailId'] as int?,
      quantity: json['quantity'] as int?, // Add "as int?" to handle nullable integer values
      price: json['price'] as int?, // Add "as int?" to handle nullable integer values
      totalPrice: json['totalPrice'] as int?, // Add "as int?" to handle nullable integer values
      orderId: json['orderId'] as int?, // Add "as int?" to handle nullable integer values
      productId: json['productId'] as int?, // Add "as int?" to handle nullable integer values
      // order: json['Order'] != null ? Order.fromJson(json['Order']) : null,
      // product: json['Product'] != null ? Product.fromJson(json['Product']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderDetailId': orderDetailId,
      'quantity': quantity,
      'price': price,
      'totalPrice': totalPrice,
      'orderId': orderId,
      'productId': productId,
      // 'Order': order?.toJson(),
      // 'Product': product?.toJson(),
    };
  }
}