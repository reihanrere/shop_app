class ProductCategoryModel {
  final List<String> categories;

  ProductCategoryModel({required this.categories});

  factory ProductCategoryModel.fromJson(List<dynamic> json) {
    return ProductCategoryModel(categories: List<String>.from(json));
  }
}
