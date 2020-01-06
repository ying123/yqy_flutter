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
  static Future<BaseResult> requestSmsCode(String phone) async {
    String url = APPConfig.Server + "sms/user_login";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"phone":phone});
    return result;
  }
  ///
  ///   验证码登录
  ///
  ///   code	是	string	短信验证码
  ///   status	是	string	登录状态码（短信验证码接口返回）
  ///   phone	是	string	手机号
  ///   opentype	否	string	第三方登录类型
  ///   openid	否	string	微信openid(仅H5注册、绑定时需要)
  ///   unionid	否	string	微信unionid
  ///   device	是	string	登录设备类型
  ///
  ///
  static Future<BaseResult> requestSmsLogin(String phone,String code,String status) async {
    String url = APPConfig.Server + "login/sms_login";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"phone":phone,"code":code,"status":status});
    return result;
  }


  ///
  ///   验证码登录
  ///
  ///   device	是	string	设备类型
  ///   type	是	string	登录设备 qq/wx，当前只支持微信(wx)
  ///   unionid	否	string	第三方登录ID
  ///
  static Future<BaseResult> requestQuickLogin(String type,String unionid) async {
    String url = APPConfig.Server + "login/quick_login";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"type":type,"unionid":unionid});
    return result;
  }

}