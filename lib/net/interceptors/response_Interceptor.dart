import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/bean/base_result.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/login/login_page.dart';
import 'dart:convert';

import 'package:yqy_flutter/utils/user_utils.dart';




class ResponseInterceptor extends InterceptorsWrapper {



  EventBus eventBus = new EventBus();

  @override
  onResponse(Response response) {
    // RequestOptions options = response.request;
    try {
      if (response.statusCode == 200 || response.statusCode == 201) { //http code
        BaseResult result = BaseResult.fromJsonMap(json.decode(response.data));


        //token 过期
        if(result.tokenCancel){
          print(" //token 过期----------------------------------------11111111");
          UserUtils.removeUserInfo();
          eventBus.fire(new LoginPage());//refreshToken过期，eventBus弹出登录页面
        }
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