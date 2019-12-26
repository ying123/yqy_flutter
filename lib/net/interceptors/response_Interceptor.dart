import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/bean/base_result.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/main.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/login/login_page.dart';
import 'dart:convert';

import 'package:yqy_flutter/utils/user_utils.dart';




class ResponseInterceptor extends InterceptorsWrapper {




  var lock = new Lock();


  @override
  onResponse(Response response) {
    // RequestOptions options = response.request;
    try {
      if (response.statusCode == 200 || response.statusCode == 201) { //http code
        BaseResult result = BaseResult.fromJsonMap(json.decode(response.data));


        //token 过期
        if(result.tokenCancel&&UserUtils.isLogin()){

          UserUtils.removeUserInfo();
          showToast(result.message);
        //  RRouter.push(MainHomePage.navigatorKey.currentState.context, Routes.loginPage,{},clearStack: true);
          MainHomePage.navigatorKey.currentState.pushNamedAndRemoveUntil("/login", (router) => router == null);
        //  MainHomePage.navigatorKey.currentState.pushNamed("/login");
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
        return BaseResult(response.data,response.data, response.statusCode, response.statusCode, e.toString());
    }
  }
}