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



  ///
  ///   密码登录
  /// phone	是	string	手机号
  /// opentype	否	string	第三方登录类型
  /// openid	否	string	微信openid(仅H5注册、绑定时需要)
  /// unionid	否	string	微信unionid
  /// device	是	string	登录设备类型
  /// pass	是	string	登录密码
  ///
  static Future<BaseResult> requestPassLogin(String phone,String pass) async {
    String url = APPConfig.Server + "login/pass_login";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"phone":phone,"passwd":pass});
    return result;
  }


  ///
  ///  获取用户协议
  ///
  static Future<BaseResult> requestAgreements() async {
    String url = APPConfig.Server + "login/agreements";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, { });
    return result;
  }




  ///
  ///  完善资料
  ///
  ///  regtype	是	string	用户类型 1医生 2推广经理（代表）
  ///  phone	是	string	手机号
  ///  code	是	string	短信验证码
  ///  realName	是	string	真实姓名
  ///  hospital_name	否	string	医院名称（当医生用户的hospital_id为0时必传）
  ///  hospital_id	否	string	医院编号
  ///  provinceId	是	string	省份编号（代表必填，医生hospital_id为0时必填）
  ///  cityId	是	string	地市编号（代表必填，医生hospital_id为0时必填）
  ///  areaId	是	string	区县编号（代表必填，医生hospital_id为0时必填）
  ///  depart_id	是	string	一级科室编号（医生必填）
  ///  depart_ids	是	string	二级科室编号（医生必填）
  ///  device	是	string	登录设备类型
  ///  opentype	否	string	第三方登录类型
  ///  openid	否	string	微信openid(仅H5注册、绑定时需要)
  ///  unionid	否	string	微信unionid
  ///
  static Future<BaseResult> requestFinishInfo(Map<String, dynamic> map) async {
    String url = APPConfig.Server + "login/finish_info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, map);
    return result;
  }


  ///
  ///  获取医生的职称列表
  ///
  static Future<BaseResult> requestJobList() async {
    String url = APPConfig.Server + "label/job_list";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {});
    return result;
  }



  ///
  ///  个人中心接口
  ///
  static Future<BaseResult> requestIndex() async {
    String url = APPConfig.Server + "users/index_doctor";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {});
    return result;
  }


  ///
  ///  用户信息
  ///
  static Future<BaseResult> requestUserInfo() async {
    String url = APPConfig.Server + "users/user_info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {});
    return result;
  }


  ///
  ///  上传图片
  ///
  static Future<BaseResult> requestUploadsImages(File data,String path) async {
    String url = APPConfig.Server + "uploads/image";
    BaseResult result = await httpManager.upload(url, data,path: path);
    return result;
  }




  ///
  ///  会议预告详情
  ///
  ///   id	是	string	会议编号
  ///
  static Future<BaseResult> requestMeetingAdvance(String id) async {
    String url = APPConfig.Server + "/meeting/advance";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"id":id});
    return result;
  }


  ///
  ///  会议直播详情-正在直播
  ///
  ///   id	是	string	会议ID
  ///  token	是	string	用户token 仅app
  ///
  static Future<BaseResult> requestMeetingInfo(String id) async {
    String url = APPConfig.Server + "/meeting/info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"id":id});
    return result;
  }


  ///
  ///  会议直播状态查询
  ///
  ///
  ///  id	是	string	会议编号
  ///  token	是	string	用户token(仅APP)
  ///
  static Future<BaseResult> requestMeetinggGetStatus(String id) async {
    String url = APPConfig.Server + "/meeting/get_status";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"id":id});
    return result;
  }


  ///
  ///  单个会场信息及其日程信息
  ///
  ///
  ///  id	是	string	会议编号
  ///  token	是	string	用户token(仅APP)
  ///
  static Future<BaseResult> requestMeetinggGetMeetingInfo(String id) async {
    String url = APPConfig.Server + "/meeting/get_meeting_info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"id":id});
    return result;
  }
}