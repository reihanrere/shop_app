import 'package:dio/dio.dart';

class DioHelper {
  Dio createDio() {
    final Dio dio = Dio();

    dio.interceptors
        .add(CustomInterceptor()); // Tambahkan interceptor ke Dio instance

    return dio;
  }
}

class CustomInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Lakukan sesuatu sebelum permintaan dikirimkan
    // Contoh: Menambahkan header, logging, dll.
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // Lakukan sesuatu setelah menerima respon dari server
    // Contoh: Logging respon, validasi, dll.
    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // Tangani kesalahan yang terjadi selama permintaan
    // Contoh: Logging kesalahan, penanganan kesalahan spesifik, dll.
    super.onError(err, handler);
  }
}
