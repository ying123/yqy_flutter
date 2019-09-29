import 'package:dio/dio.dart';
import 'package:yqy_flutter/bean/base_result.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'dart:convert';

class ResponseInterceptor extends InterceptorsWrapper {
  @override
  onResponse(Response response) {
    // RequestOptions options = response.request;
    try {
      if (response.statusCode == 200 || response.statusCode == 201) { //http code
        BaseResult result = BaseResult.fromJsonMap(json.decode(response.data));
        return result;
      }else {
        if (APPConfig.DEBUG) {
          print("ResponseInterceptor: $response.statusCode");
        }
      }
    } catch(e) {
       if (APPConfig.DEBUG) {
          print("ResponseInterceptor: $e.toString() + options.path");
        }
        return BaseResult(response.data, response.statusCode, e.toString());
    }
  }
}