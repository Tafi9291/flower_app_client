import 'package:t_store/data/models/Product.dart';
import 'package:t_store/data/models/Users.dart';

class Cart {
  int usersId;
  int productId;
  int? quantity;
  int? subtotalPrice;
  // List<Product>? products;
  // Users? users;

  Cart({
    required this.usersId,
    required this.productId,
    this.quantity,
    this.subtotalPrice,
    // this.products = const [],
    // this.users,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      usersId: json['usersId'] as int,
      productId: json['productId'] as int,
      quantity: json['quantity'] ?? 0,
      subtotalPrice: json['subtotalPrice'] ?? 0,
      // products: json['Products'] != null
      //   ? List<Product>.from(json['Products'].map((x) => Product.fromJson(x)))
      //   : [],
      // users: json['users'],
    );
  }

  Map<String, dynamic> toJson() => {
    'usersId': usersId,
    'productId': productId,
    'quantity': quantity,
    'subtotalPrice': subtotalPrice,
    // 'Products': products?.map((user) => user.toJson()).toList(),
    // 'users': users?.toJson(),
  };
}