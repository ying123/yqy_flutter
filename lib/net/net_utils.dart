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
  ///  获取是否需要实名认证
  ///
  static Future<BaseResult> requestGetCertification() async {
    String url = APPConfig.Server + "users/get_certification";
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
    String url = APPConfig.Server + "meeting/info";
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
    String url = APPConfig.Server + "meeting/get_status";
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
    String url = APPConfig.Server + "meeting/get_meeting_info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"id":id});
    return result;
  }


  ///
  ///   点赞
  ///
  ///  token	是	string	用户token app必传
  /// member_id	是	string	用户id web必传
  /// type	否	string	页面类型ID 参考page_route数据字典
  /// other_id	否	string	页面内容ID
  ///
  static Future<BaseResult> requestGoodAdd(String type,String other_id) async {
    String url = APPConfig.Server + "good/add";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"type":type,"other_id":other_id});
    return result;
  }

  ///
  ///   取消点赞
  ///
  ///  token	是	string	用户token app必传
  /// id	否	string	点赞ID
  ///
  static Future<BaseResult> requestGoodDel(String id) async {
    String url = APPConfig.Server + "good/del";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"id":id});
    return result;
  }


  ///
  ///  获取点赞状态
  ///
  /// token	是	string	用户token app必传
  /// member_id	是	string	用户id web必传
  /// type	否	string	页面类型ID 参考page_route数据字典
  /// other_id	否	string	页面内容ID
  static Future<BaseResult> requestGoodCheckStatus(String type,String id) async {
    String url = APPConfig.Server + "good/check_status";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"type":type,"other_id":id});
    return result;
  }



  ///
  ///   收藏
  ///
  ///  token	是	string	用户token app必传
  /// member_id	是	string	用户id web必传
  /// type	否	string	页面类型ID 参考page_route数据字典
  /// other_id	否	string	页面内容ID
  ///
  static Future<BaseResult> requestCollectAdd(String type,String other_id) async {
    String url = APPConfig.Server + "collect/add";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"type":type,"other_id":other_id});
    return result;
  }

  ///
  ///   取消收藏
  ///
  ///  token	是	string	用户token app必传
  /// id	否	string	点赞ID
  ///
  static Future<BaseResult> requestCollectDel(String id) async {
    String url = APPConfig.Server + "collect/del";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"id":id});
    return result;
  }

  ///
  ///  获取收藏状态
  ///
  /// token	是	string	用户token app必传
  /// member_id	是	string	用户id web必传
  /// type	否	string	页面类型ID 参考page_route数据字典
  /// other_id	否	string	页面内容ID
  static Future<BaseResult> requestCollectCheckStatus(String type,String id) async {
    String url = APPConfig.Server + "collect/check_status";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"type":type,"other_id":id});
    return result;
  }


  ///
  ///   评论列表
  ///
  /// token	是	string	用户token
  /// member_id	是	string	用户ID
  /// type	否	string	页面类型ID
  /// other_id	否	string	页面内容ID
  /// page	否	string	评论页码，默认1
  ///
  static Future<BaseResult> requestCommentLists(String member_id,String type,String other_id,String page) async {
    String url = APPConfig.Server + "comment/lists";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"type":type,"member_id":member_id,"other_id":other_id,"page":page});
    return result;
  }


  ///
  ///   添加评论
  ///
  /// token	是	string	用户token，APP、小程序必填
  /// type	是	string	页面类型ID，参考数据字典 page_route页面路由
  /// other_id	是	string	页面内容ID
  /// fid	否	string	回复ID,仅回复他人时需要携带
  /// content	是	string	评论内容，100字以内
  ///
  static Future<BaseResult> requestCommentAdd(String type,String other_id,String content) async {
    String url = APPConfig.Server + "comment/add";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"type":type,"other_id":other_id,"content":content});
    return result;
  }


  ///
  ///   删除评论
  /// token	是	string	用户token，APP、小程序必填
  /// member_id	是	string	web必填
  /// id	是	string	评论ID
  ///
  static Future<BaseResult> requestCommentDel(String type,String other_id,String content) async {
    String url = APPConfig.Server + "comment/del";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"type":type,"other_id":other_id,"content":content});
    return result;
  }

  ///
  ///   首页的 医药资讯（包括轮播图的数据）
  ///
  static Future<BaseResult> requestNewsIndex() async {
    String url = APPConfig.Server + "news/index";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{});
    return result;
  }


  ///
  ///    医药资讯列表
  ///
  ///    id	是	string	分类ID
  ///  page	否	string	页码，默认1
  ///  limit	否	string	每页显示文章数量，默认20,范围1-30
  ///
  static Future<BaseResult> requestNewsLists({String id,String page}) async {
    String url = APPConfig.Server + "news/lists";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id,"page":page});
    return result;
  }

  ///
  ///   资讯详情
  ///   id	是	string	文章ID
  ///
  static Future<BaseResult> requestNewsInfo(String id) async {
    String url = APPConfig.Server + "news/info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id});
    return result;
  }



  ///
  ///   文献指南首页
  ///
  static Future<BaseResult> requestDocumentIndex() async {
    String url = APPConfig.Server + "document/index";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{});
    return result;
  }



  ///
  ///   文献指南首页
  ///   id	是	string	分类ID
  ///  page	否	string	页码，默认1
  ///  limit	否	string	每页显示文章数量，默认20,范围1-30
  ///
  ///
  static Future<BaseResult> requestDocumentLists(String id,String page) async {
    String url = APPConfig.Server + "document/lists";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id,"page":page});
    return result;
  }


  ///
  ///   文献详情
  ///   id	是	string	文献ID
  ///
  static Future<BaseResult> requestDocumentInfo(String id) async {
    String url = APPConfig.Server + "document/info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id});
    return result;
  }



  ///
  ///   产品详情
  ///  id	是	string	产品ID
  ///
  ///
  static Future<BaseResult> requestGoodsInfo(String id) async {
    String url = APPConfig.Server + "points/goods_info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id});
    return result;
  }



  ///
  ///   下单详情  （此接口不是向后台提交数据的）
  ///
  ///
  static Future<BaseResult> requestOrderInfo(String id) async {
    String url = APPConfig.Server + "points/order_info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id});
    return result;
  }


  ///
  ///   提交订单  （向后台提交数据的）
  ///
  ///
  static Future<BaseResult> requestAddOrder(Map map) async {
    String url = APPConfig.Server + "points/add_order";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,map);
    return result;
  }



  ///
  ///   我的订单列表
  ///  page	是	string	页码，默认1
  ///
  static Future<BaseResult> requestMyOrderLists(String page) async {
    String url = APPConfig.Server + "points/my_order_list";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"page":page});
    return result;
  }

  ///
  ///   我的订单详情
  ///  id	是	string	订单ID
  ///
  static Future<BaseResult> requestMyOrderInfo(String id) async {
    String url = APPConfig.Server + "points/my_order_info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id});
    return result;
  }


  ///
  ///   确认收货
  ///  id	是	string	订单ID
  ///
  static Future<BaseResult> requestMyOrderConfirm(String id) async {
    String url = APPConfig.Server + "points/confirm";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id});
    return result;
  }

  ///
  /// 收货地址列表
  ///
  static Future<BaseResult> requestAddressLists() async {
    String url = APPConfig.Server + "points/address_lists";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{});
    return result;
  }


  ///
  ///   新增收货地址
  ///
  ///   name	是	string	收件人姓名
  ///  tel	否	string	联系电话
  ///  pro_id	否	string	省份编号
  ///  city_id	否	string	城市编号
  ///  area_id	否	string	区县编号
  ///  address	否	string	详细地址
  ///
  ///
  static Future<BaseResult> requestAdAddress(Map map) async {
    String url = APPConfig.Server + "points/add_address";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,map);
    return result;
  }

  ///
  ///   设为默认收货地址
  ///
  ///   id	是	string	收件地址ID
  ///
  static Future<BaseResult> requestSetDefaultAddress(String id) async {
    String url = APPConfig.Server + "points/set_default_address";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id});
    return result;
  }


  ///
  ///   修改收货地址
  ///
  ///    id	是	string	收货地址ID
  ///   name	是	string	收件人姓名
  ///   tel	否	string	联系电话
  ///   pro_id	否	string	省份编号
  ///   city_id	否	string	城市编号
  ///   area_id	否	string	区县编号
  ///   address	否	string	详细地址
  ///
  ///
  static Future<BaseResult> requestEditAddress(Map map) async {
    String url = APPConfig.Server + "points/edit_address";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,map);
    return result;
  }




  ///
  ///   获取收货地址详情
  ///
  ///    id	是	string	收货地址ID
  ///
  static Future<BaseResult> requestGetAddress(String id) async {
    String url = APPConfig.Server + "points/get_address";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id});
    return result;
  }


  ///
  ///    视频首页（移动端）
  ///
  static Future<BaseResult> requestVideosIndex() async {
    String url = APPConfig.Server + "videos/index";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{});
    return result;
  }


  ///
  ///   专家视频详情
  ///
  static Future<BaseResult> requestVideosInfo(String id) async {
    String url = APPConfig.Server + "videos/info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"id":id});
    return result;
  }


}