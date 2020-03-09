import 'package:dio/dio.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/bean/base_result_entity.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/main.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/route/tokenCancelRouter.dart';
import 'dart:convert';

import 'package:yqy_flutter/utils/user_utils.dart';




class ResponseInterceptor extends InterceptorsWrapper {




  var lock = new Lock();


  @override
  onResponse(Response response) {


    try {

      BaseResult   result = BaseResult.fromJson(jsonDecode(response.data));

      if (response.statusCode!=500) { //http code

        //token 过期
        if(result.tokenCancel){
          UserUtils.removeToken();
          UserUtils.removeUserInfo();
          FLToast.error(text:result.msg);

          TokenRouter.navigatorKey.currentState.pushNamed(Routes.loginPage);
          TokenRouter.navigatorKey.currentState.pushNamedAndRemoveUntil(Routes.loginPage,
                  (router) => router == null);


        //  RRouter.push(MainHomePage.navigatorKey.currentState.context, Routes.loginPage,{},clearStack: true);
        //  MainHomePage.navigatorKey.currentState.pushNamedAndRemoveUntil("/login", (router) => router == null);
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
       //token 过期
         return BaseResult.fromJson(response.data);
    }
  }
}