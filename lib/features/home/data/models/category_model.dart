import 'package:process/core/entities/category.dart';

class CategoryModel extends Category {
  CategoryModel({
    required int id,
    required String name,
    required String slug,
  }) : super(
    id: id,
    name: name,
    slug: slug,
  );

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
    );
  }
}
