part of 'product_cubit.dart';

class ProductState extends Equatable {
  final int counter;
  final List<ProductModel>? productList;
  final List<ProductModel>? searchProductList;
  final List<String>? productCategory;
  final String? category;
  final List<CartItemModel>? cartItem;

  ProductState({
    this.counter = 0,
    this.productList,
    this.searchProductList,
    this.productCategory,
    this.category,
    this.cartItem,
  });

  ProductState copyWith({
    int? counter,
    String? category,
    List<ProductModel>? productList,
    List<ProductModel>? searchProductList,
    List<String>? productCategory,
    List<CartItemModel>? cartItem,
  }) {
    return ProductState(
      counter: counter ?? this.counter,
      productList: productList ?? this.productList,
      searchProductList: searchProductList ?? this.searchProductList,
      productCategory: productCategory ?? this.productCategory,
      category: category ?? this.category,
      cartItem: cartItem ?? this.cartItem,
    );
  }

  @override
  List<Object?> get props => [
        counter,
        productList,
        searchProductList,
        productCategory,
        category,
        cartItem,
      ];
}
