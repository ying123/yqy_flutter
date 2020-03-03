import 'dart:io';

import 'package:dio/dio.dart';
import 'package:package_info/package_info.dart';
import 'package:yqy_flutter/bean/base_result_entity.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'interceptors/logs_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/response_Interceptor.dart';
import './code.dart';
import 'dart:typed_data';

enum HttpMethod { GET, POST }

const HTTPMethodValues = ['GET', 'POST'];
const ContentTypeURLEncoded = 'application/x-www-form-urlencoded';

class HttpManager {
  Dio _dio = Dio();

  HttpManager() {
    _dio.interceptors.add(LogsInterceptor());
    _dio.interceptors.add(ErrorInterceptor(_dio));
    _dio.interceptors.add(ResponseInterceptor());
  }


  request(HttpMethod method, String url, Map<String, dynamic> params,
      {ContentType contentType}) async {
    Options _options;
    Map<String, dynamic> header;

    if(UserUtils.isLogin()){
      params["token"] = UserUtils.getToken()?? "";
    }
    //	设备
    params["device"] = Platform.isAndroid?"android":"ios";
    //	版本号
    //获取当前版本
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    params["version"] = packageInfo.version;

    var type = contentType == null
        ? ContentType.parse(ContentTypeURLEncoded)
        : contentType;
    if (UserUtils.isLogin()) {
      header = {'token': UserUtils.getToken()?? ""};
    }
    if (method == HttpMethod.GET) {
      _options = Options(
          method: HTTPMethodValues[method.index],
          contentType: type,
          headers: header);
    } else {
      _options = Options(
          method: HTTPMethodValues[method.index],
          contentType: type,
          headers: header);
    }

    Response response;
    try {
      if (method == HttpMethod.GET) {
        response =
            await _dio.get(url, queryParameters: params, options: _options);
      } else {
        response = await _dio.post(url, data: params, options: _options);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      } else {
        response = Response(statusCode: 4001, statusMessage: "请求失败,稍后再试！");
      }

      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        response.statusCode = Code.NETWOEK_TIMEROUT;
        response.statusMessage = "请求超时,请稍后再试!";
      }
      response.data =
          BaseResult(msg: response.statusMessage,code: response.statusCode);
    }


    return response.data;
  }

  upload(String url, File data,{String path}) async {
    UploadFileInfo file = UploadFileInfo(data, data.path);
    FormData formData = FormData.from({'image': file,"token": UserUtils.getToken()??"","path":path??""});



    Map<String, dynamic> header = {
      'token':  UserUtils.getToken() ?? ""
    };

    Response response;
    try {
      response = await _dio.post(url,
          data: formData, options: Options(headers: header));
    } on DioError catch (e) {
      if (e.response != null) {
        response = e.response;
      } else {
        response = Response(statusCode: 4001, statusMessage: "请求失败,稍后再试！");
      }

      if (e.type == DioErrorType.CONNECT_TIMEOUT ||
          e.type == DioErrorType.RECEIVE_TIMEOUT) {
        response.statusCode = Code.NETWOEK_TIMEROUT;
        response.statusMessage = "请求超时,请稍后再试!";
      }
      response.data =
          BaseResult(msg: response.statusMessage,code: response.statusCode);
    }

    return response.data;
  }
}

final HttpManager httpManager = HttpManager();
