import 'dart:io';

class CategoryWithImageInput {
  final int? categoryId;
  final String? categoryName;
  final File? imageFile; // Path of the image file

  CategoryWithImageInput({this.categoryId, this.categoryName, this.imageFile});
}