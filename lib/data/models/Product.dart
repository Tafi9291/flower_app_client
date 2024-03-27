import 'package:t_store/data/models/Cart.dart';
import 'package:t_store/data/models/Category.dart';
import 'package:t_store/data/models/Notification.dart';
import 'package:t_store/data/models/OrderDetail.dart';
import 'package:t_store/data/models/Users.dart';

class Product {
  int productId;
  String productName;
  int? price;
  int? percentDis;
  int? salePrice;
  int? stockQl;
  String? imageUrl;
  String? description;
  int? quantitySold;
  DateTime? createAt;
  DateTime? updateAt;
  int? categoryId;
  List<Cart> carts;
  Category? category;
  List<Notification> notifications;
  List<OrderDetail> orderDetails;
  List<Users> users;

  Product({
    required this.productId,
    required this.productName,
    this.price,
    this.percentDis,
    this.salePrice,
    this.stockQl,
    this.imageUrl,
    this.description,
    this.quantitySold,
    this.createAt,
    this.updateAt,
    this.categoryId,
    this.carts = const [],
    this.category,
    this.notifications = const [],
    this.orderDetails = const [],
    this.users = const [],
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productId: json['ProductId'],
      productName: json['ProductName'],
      price: json['Price'],
      percentDis: json['PercentDis'],
      salePrice: json['SalePrice'],
      stockQl: json['StockQl'],
      imageUrl: json['ImageUrl'],
      description: json['Description'],
      quantitySold: json['QuantitySold'],
      createAt: json['CreateAt'] != null ? DateTime.parse(json['CreateAt']) : null,
      updateAt: json['UpdateAt'] != null ? DateTime.parse(json['UpdateAt']) : null,
      categoryId: json['CategoryId'],
      carts: json['Carts'] != null ? List<Cart>.from(json['Carts'].map((x) => Cart.fromJson(x))) : [],
      category: json['Category'] != null ? Category.fromJson(json['Category']) : null,
      notifications: json['Notifications'] != null ? List<Notification>.from(json['Notifications'].map((x) => Notification.fromJson(x))) : [],
      orderDetails: json['OrderDetails'] != null ? List<OrderDetail>.from(json['OrderDetails'].map((x) => OrderDetail.fromJson(x))) : [],
      users: json['Users'] != null ? List<Users>.from(json['Users'].map((x) => Users.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'ProductId': productId,
    'ProductName': productName,
    'Price': price,
    'PercentDis': percentDis,
    'SalePrice': salePrice,
    'StockQl': stockQl,
    'ImageUrl': imageUrl,
    'Description': description,
    'QuantitySold': quantitySold,
    'CreateAt': createAt?.toIso8601String(),
    'UpdateAt': updateAt?.toIso8601String(),
    'CategoryId': categoryId,
    'Carts': carts.map((cart) => cart.toJson()).toList(),
    'Category': category?.toJson(),
    'Notifications': notifications.map((notification) => notification.toJson()).toList(),
    'OrderDetails': orderDetails.map((orderDetail) => orderDetail.toJson()).toList(),
    'Users': users.map((user) => user.toJson()).toList(),
  };
}