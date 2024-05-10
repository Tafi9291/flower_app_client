import 'dart:io';

class ProductWithImageInput {
  final int? productId;
  final String? productName;
  final int? price;
  final int? percentDis;
  final int? salePrice;
  final int? stockQl;
  final File? imageFile; // Path of the image file
  final String? description;
  final int? quantitySold;
  final int? categoryId;

  ProductWithImageInput({this.productId, this.productName, this.price, this.percentDis, this.salePrice, this.stockQl, this.imageFile, this.description, this.quantitySold, this.categoryId, });
}