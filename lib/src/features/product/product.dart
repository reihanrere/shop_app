import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/src/features/product/ui/cart.dart';
import 'package:shop_app/src/features/product/ui/detail.dart';
import 'package:shop_app/src/features/product/ui/product.dart';
import 'package:shop_app/src/features/product/ui/search_product.dart';
import 'package:shop_app/src/repositories/models/product/product_model.dart';

import 'cubit/product_cubit.dart';

class Product {
  static final List<GoRoute> routes = [
    GoRoute(
      name: DetailFeature.routeName,
      path: "/${DetailFeature.routeName}",
      builder: (BuildContext context, GoRouterState state) {
        final args = state.extra as ProductModel;
        return DetailFeature(
          productModel: args,
        );
      },
    ),
    GoRoute(
      name: ProductFeature.routeName,
      path: "/${ProductFeature.routeName}",
      builder: (BuildContext context, GoRouterState state) {
        return const ProductFeature();
      },
    ),
    GoRoute(
      name: SearchProductFeature.routeName,
      path: "/${SearchProductFeature.routeName}",
      builder: (BuildContext context, GoRouterState state) {
        return const SearchProductFeature();
      },
    ),
    GoRoute(
      name: CartProductFeature.routeName,
      path: "/${CartProductFeature.routeName}",
      builder: (BuildContext context, GoRouterState state) {
        return const CartProductFeature();
      },
    ),
  ];

  final locator = GetIt.instance;
  void setupLocator() async {
    locator.registerFactory(() => ProductCubit());
  }
}
