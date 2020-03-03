import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';
import 'package:yqy_flutter/bean/base_result_entity.dart';
import '../code.dart';
class ErrorInterceptor extends InterceptorsWrapper {
  final Dio _dio;
  ErrorInterceptor(this._dio);

  @override
  onRequest(RequestOptions options) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return _dio.resolve(BaseResult(code:  Code.NETWORK_ERROR,msg: "网络错误"));
    }
    return super.onRequest(options);

  }
}