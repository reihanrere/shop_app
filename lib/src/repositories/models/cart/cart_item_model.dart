import '../product/product_model.dart';

class CartItemModel {
  final ProductModel? products;
  final int? quantity;

  CartItemModel({this.products, this.quantity});
}
