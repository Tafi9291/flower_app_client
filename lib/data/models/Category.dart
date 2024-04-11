import 'package:t_store/data/models/Product.dart';

class Category {
  int categoryId;
  String categoryName;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  // List<Product>? products;

  Category({
    required this.categoryId,
    required this.categoryName,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
    // this.products,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category (
      categoryId: json['categoryId'], // Provide a default value if null
      categoryName: json['categoryName'],
      imageUrl: json['imageUrl'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      // products: json['products'] != null
      //     ? List<Product>.from(json['products'].map((productJson) => Product.fromJson(productJson)))
      //     : null,
  );
  Map<String, dynamic> toJson() => {
    "categoryId": categoryId,
    "categoryName": categoryName,
    "imageUrl": imageUrl,
  };
}


