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
  List<Cart>? carts;
  Category? category;
  List<Notification>? notifications;
  List<OrderDetail>? orderDetails;
  List<Users>? users;

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
      productId: json['productId'] as int,
      productName: json['productName'] as String,
      price: json['price'] != null ? json['price'] as int : null,
      percentDis: json['percentDis'] != null ? json['percentDis'] as int : null,
      salePrice: json['salePrice'] != null ? json['salePrice'] as int : null,
      stockQl: json['stockQl'] != null ? json['stockQl'] as int : null,
      imageUrl: json['imageUrl'] as String?,
      description: json['description'] as String?,
      quantitySold: json['quantitySold'] != null ? json['quantitySold'] as int : null,
      createAt: json['createAt'] != null ? DateTime.parse(json['createAt']) : null,
      updateAt: json['updateAt'] != null ? DateTime.parse(json['updateAt']) : null,
      categoryId: json['categoryId'] != null ? json['categoryId'] as int : null,
      carts: json['carts'] != null ? List<Cart>.from(json['carts'].map((x) => Cart.fromJson(x))) : [],
      category: json['category'] != null ? Category.fromJson(json['category']) : null,
      notifications: json['notifications'] != null ? List<Notification>.from(json['notifications'].map((x) => Notification.fromJson(x))) : [],
      orderDetails: json['orderDetails'] != null ? List<OrderDetail>.from(json['orderDetails'].map((x) => OrderDetail.fromJson(x))) : [],
      users: json['users'] != null ? List<Users>.from(json['users'].map((x) => Users.fromJson(x))) : [],
    );
  }

  Map<String, dynamic> toJson() => {
    'productId': productId,
    'productName': productName,
    'price': price,
    'percentDis': percentDis,
    'salePrice': salePrice,
    'stockQl': stockQl,
    'imageUrl': imageUrl,
    'description': description,
    'quantitySold': quantitySold,
    'createAt': createAt?.toIso8601String(),
    'updateAt': updateAt?.toIso8601String(),
    'categoryId': categoryId,
    'carts': carts?.map((cart) => cart.toJson()).toList(),
    'category': category?.toJson(),
    'notifications': notifications?.map((notification) => notification.toJson()).toList(),
    'orderDetails': orderDetails?.map((orderDetail) => orderDetail.toJson()).toList(),
    'users': users?.map((user) => user.toJson()).toList(),
  };
}