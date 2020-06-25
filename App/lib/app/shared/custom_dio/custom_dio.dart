import 'package:App/app/shared/custom_dio/interceptors.dart';
import 'package:dio/dio.dart';
import 'package:App/app/constants.dart';
import 'package:dio/native_imp.dart';

class CustomDio extends DioForNative{

  CustomDio(){
    options.baseUrl = BASE_URL;
    options.connectTimeout = 5000;
    interceptors.add(CustomInterceptors());
  }
}