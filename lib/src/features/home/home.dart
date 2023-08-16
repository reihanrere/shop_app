import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_app/src/features/home/ui/home.dart';

class Home {
  static final List<GoRoute> routes = [
    GoRoute(
      name: HomeFeature.routeName,
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeFeature();
      },
    ),
  ];

  // final locator = GetIt.instance;
  // void setupLocator() async {
  //   locator.registerFactory(() => ProductCubit());
  // }
}
