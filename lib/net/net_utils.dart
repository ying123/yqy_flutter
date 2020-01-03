import 'dart:io';
import 'dart:async';
import 'package:yqy_flutter/bean/base_result.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/utils/user_utils.dart';

import 'http_manager.dart';
import 'dart:typed_data';
///
///   新版本接口   2020/1/3
///
///
class NetUtils {
  ///
  ///   获取验证码接口
  ///
  static Future<BaseResult> requestSmsCode() async {
    String url = APPConfig.Server + "/sms/user_login";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {});
    return result;
  }


}