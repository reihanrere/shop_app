import 'dart:async';

import 'package:shop_app/src/helpers/dio.dart';
import 'package:shop_app/src/helpers/injection.dart';

import '../../../models/product/product_model.dart';

class ProductRepository {
  final DioHelper dio = locator<DioHelper>();

  Future<List<ProductModel>?> fetchGetListProduct(String? string) async {
    try {
      final response = await dio.createDio().get(
          "https://fakestoreapi.com/products${string!.isEmpty ? '/' : '/category/$string'}");

      List<ProductModel> productList = (response.data as List)
          .map((item) => ProductModel?.fromJson(item))
          .toList();

      return productList;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<String>?> fetchGetProductCategory() async {
    try {
      final response = await dio
          .createDio()
          .get("https://fakestoreapi.com/products/categories");

      return response.data != null ? List<String>.from(response.data) : null;
    } catch (e) {
      print(e.toString());
    }
  }
}
