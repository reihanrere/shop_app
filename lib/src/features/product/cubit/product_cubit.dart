import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_app/src/repositories/repositories.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  Timer? _debounce;
  List<ProductModel>? products = [];
  ProductCubit() : super(ProductState());

  void counterIncrement() {
    try {
      emit(state.copyWith(counter: state.counter + 1));
    } catch (e) {
      print(e.toString());
    }
  }

  void counterDecrement() {
    try {
      emit(state.copyWith(counter: state.counter != 0 ? state.counter - 1 : 0));
    } catch (e) {
      print(e.toString());
    }
  }

  void categoryString(String string) {
    try {
      emit(
        state.copyWith(
          category: string == state.category ? "" : string,
        ),
      );
    } catch (e) {
      print(e.toString());
    }
  }

  void getAllData({String category = ""}) async {
    try {
      // List<ProductModel>? productList =
      //     await ProductRepository().fetchGetListProduct(category);

      products = await ProductRepository().fetchGetListProduct(category);
      print(products);
      if (products != null) {
        emit(state.copyWith(productList: products));
      } else {
        print("Failed to fetch product list.");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void getSearchAllData(String keyword) async {
    try {
      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 500), () {
        List<ProductModel> searchData = products!
            .where((product) => product.title!.toLowerCase().contains(keyword))
            .toList();

        emit(state.copyWith(searchProductList: searchData));
      });
    } catch (e) {}
  }

  void getAllCategoryData() async {
    try {
      List<String>? productCategory =
          await ProductRepository().fetchGetProductCategory();

      if (productCategory != null) {
        emit(state.copyWith(productCategory: productCategory));
      } else {
        print("Failed to fetch category list.");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void addCartItem(CartItemModel cartItem) {
    try {
      List<CartItemModel> updatedCart = [...state.cartItem ?? [], cartItem];
      emit(
        state.copyWith(cartItem: updatedCart),
      );
      print(state.cartItem);
    } catch (e) {
      print(e.toString());
    }
  }
}
