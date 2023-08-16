import 'package:get_it/get_it.dart';
import 'package:shop_app/src/features/product/product.dart';
import 'package:shop_app/src/helpers/dio.dart';

final locator = GetIt.instance;
Future<void> setupLocator() async {
  Product().setupLocator();
  locator.registerLazySingleton(() => DioHelper());
}
