import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/models/Users.dart';

class Cart {
  int usersId;
  int productId;
  int? quantity;
  int? subtotalPrice;
  Product product;
  Users users;

  Cart({
    required this.usersId,
    required this.productId,
    this.quantity,
    this.subtotalPrice,
    required this.product,
    required this.users,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      usersId: json['UsersId'],
      productId: json['ProductId'],
      quantity: json['Quantity'],
      subtotalPrice: json['SubtotalPrice'],
      product: Product.fromJson(json['Product']),
      users: Users.fromJson(json['Users']),
    );
  }

  Map<String, dynamic> toJson() => {
    'UsersId': usersId,
    'ProductId': productId,
    'Quantity': quantity,
    'SubtotalPrice': subtotalPrice,
    'Product': product.toJson(),
    'Users': users.toJson(),
  };
}