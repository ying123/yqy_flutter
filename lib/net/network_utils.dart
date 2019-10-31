import 'dart:io';
import 'dart:async';
import 'package:yqy_flutter/bean/base_result.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';

import 'http_manager.dart';
import 'dart:typed_data';

class NetworkUtils {




  static String token = "4aef8efb0f1b306901759d4152b46834401351";

  ///
  ///  首页接口
  ///
  static Future<BaseResult> requestHomeData() async {
    String url = APPConfig.Server + "Index/index";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {});
    return result;
  }

  ///
  ///  热门会议接口
  ///
  static Future<BaseResult> requestHosListData(int page) async {
    String url = APPConfig.Server + "broadcast/listing";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"page":page,"token":token});
    return result;
  }



  ///
  ///  互动会议接口
  ///
  static Future<BaseResult> requestInteractListData(int page) async {
    String url = APPConfig.Server + "interact_live/listing";
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"page":page,"token":token});
    return result;
  }

  ///
  ///  往期会议接口
  ///
  static Future<BaseResult> requestVideoListData(int page) async {
    String url = APPConfig.Server + "review/listing";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"page":page});
    return result;
  }

  ///
  ///  医药资讯列表
  ///
  static Future<BaseResult> requestNewsListData(int page) async {
    String url = APPConfig.Server + "medicalnews/listing";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"page":page});
    return result;
  }


  ///
  ///  医药资讯详情
  ///
  static Future<BaseResult> requestNewsDetail(var id) async {
    String url = APPConfig.Server + "medicalnews/info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"medicalnewsId":id,"token":token});
    return result;
  }


  ///
  ///  专题视频列表
  ///
  static Future<BaseResult> requestSpecialList(var page) async {
    String url = APPConfig.Server + "special/lists";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"page":page});
    return result;
  }


  ///
  ///  专题视频banner
  ///
  static Future<BaseResult> requestSpecialBanner(var id) async {
    String url = APPConfig.Server + "special/banner";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"id":id,"token":token});
    return result;
  }


  ///
  ///  专题视频 tab  分类
  ///
  static Future<BaseResult> requestSpecialCate(var id) async {
    String url = APPConfig.Server + "special/cate_list";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"id":id,"token":token});
    return result;
  }


  ///
  ///  专题视频 分类 列表数据
  ///
  static Future<BaseResult> requestSpecialCateList(var id,var cid,var page) async {
    String url = APPConfig.Server + "special/art_list";
    Map<String, dynamic> map = new Map();
    map["id"] = id;
    map["token"] = token;
    map["cid"] = cid;
    map["page"] = page;
    BaseResult result = await httpManager.request(HttpMethod.POST, url, map);
    return result;
  }

  ///
  ///  专题视频 视频主页
  ///
  static Future<BaseResult> requestSpecialArticle(var id) async {
    String url = APPConfig.Server + "special/article";
    Map<String, dynamic> map = new Map();
    map["id"] = id;
    map["token"] = token;
    BaseResult result = await httpManager.request(HttpMethod.POST, url, map);
    return result;
  }

  ///
  ///  视频回顾详情页面
  ///
  static Future<BaseResult> requestReviewVideo(var id) async {
    String url = APPConfig.Server + "review/info";
    Map<String, dynamic> map = new Map();
    map["reviewId"] = id;
    map["token"] = token;
    BaseResult result = await httpManager.request(HttpMethod.POST, url, map);
    return result;
  }



  ///
  ///  直播详情页面
  ///
  static Future<BaseResult> requestLiveDetails(var id) async {
    String url = APPConfig.Server + "broadcast/info";
    Map<String, dynamic> map = new Map();
    map["broadcastId"] = id;
    map["token"] = token;
    BaseResult result = await httpManager.request(HttpMethod.POST, url, map);
    return result;
  }


  ///
  ///  互动详情页面
  ///
  static Future<BaseResult> requestHDDetails(var id) async {
    String url = APPConfig.Server + "interact_live/info";
    Map<String, dynamic> map = new Map();
    map["interactId"] = id;
    map["token"] = token;
    BaseResult result = await httpManager.request(HttpMethod.POST, url, map);
    return result;
  }




  ///
  ///  政策资讯页面
  ///
  static Future<BaseResult> requestPolicyadvisory(var page) async {
    String url = APPConfig.Server + "policyadvisory/listing";
    Map<String, dynamic> map = new Map();
    map["page"] = page;
    map["token"] = token;
    BaseResult result = await httpManager.request(HttpMethod.POST, url, map);
    return result;
  }


  ///
  ///  政策资讯详情
  ///
  static Future<BaseResult> requestPolicyDetail(var id) async {
    String url = APPConfig.Server + "policyadvisory/info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"policyId":id,"token":token});
    return result;
  }


  ///
  ///  法律法规列表
  ///
  static Future<BaseResult> requestLawsList(var page) async {
    String url = APPConfig.Server + "laws/laws_listing";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"page":page,"token":token});
    return result;
  }



  ///
  ///  法律法规详情
  ///
  static Future<BaseResult> requestLawsDetail(var id) async {
    String url = APPConfig.Server + "laws/laws_info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"lawsId":id,"token":token});
    return result;
  }





  ///
  ///  规范解读列表
  ///
  static Future<BaseResult> requestGFList(var page) async {
    String url = APPConfig.Server + "normativeinterpretation/listing";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"page":page,"token":token});
    return result;
  }


  ///
  ///  规范解读详情
  ///
  static Future<BaseResult> requestGFDetail(var id) async {
    String url = APPConfig.Server + "normativeinterpretation/info";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"normativeId":id,"token":token});
    return result;
  }


  ///
  ///  医生主页信息
  ///
  static Future<BaseResult> requestDoctorHome(var id) async {
    String url = APPConfig.Server + "User/index";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"userId":id,"token":token});
    return result;
  }
  ///
  ///  意见反馈
  ///
  static Future<BaseResult> requestFeedback(var userId,var content ,var phone,) async {
    String url = APPConfig.Server + "User/feedBack";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"userId":userId,"fb_phone":phone,"fb_content":content,"token":token});
    return result;
  }


  /**
   * 添加收藏
   *
   * @param type     收藏类型
   * @param otherId  收藏id
   * @param observer
   */
  ///
  static Future<BaseResult> requestCollectAdd(String type, String otherId) async {
    String url = APPConfig.Server + "collect/add";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"type":type,"otherId":otherId,"token":token});
    return result;
  }



  ///
  ///  删除收藏
  ///
  static Future<BaseResult> requestCollectDel(String type, String otherId) async {
    String url = APPConfig.Server + "collect/del";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"type":type,"otherId":otherId,"token":token});
    return result;
  }






/* static requestHomeAdvertisementsAndRecommendProductsData() async {
    String url = APPConfig.Server + "/home/index";
    BaseResult result = await httpManager.request(HttpMethod.GET, url, null);
    return result;
  }



  static Future<BaseResult> requestCategoryListData() async {
    String url = APPConfig.Server + "/category/list";
    BaseResult result = await httpManager.request(HttpMethod.GET, url, null);
    return result;
  }

  static requestProductListByCateId(int cateId, int currentPage) async {
    String url = APPConfig.Server + "/product/pageListByCateId";
    
    var params = {"currentPage": currentPage, "pageSize": 20};
    if (cateId != null) {
      params["cateId"] = cateId;
    }
    BaseResult result = await httpManager.request(HttpMethod.GET, url, params);
    return result;
  }

  static Future<BaseResult> requestProductDetailByProductId(int productId) async {
    String url = APPConfig.Server + "/product/detail";
    var params = {"productId": productId};
    BaseResult result = await httpManager.request(HttpMethod.GET, url, params);
    return result;
  }

  static login(String account, String password) async {
    String url = APPConfig.Server + "/user/login";
    var params = {"account": account, "password": password};
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
    return result;
  }

  static register(String account, String password) async {
    String url = APPConfig.Server + "/user/register";
    var params = {"account": account, "password": password};
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
    return result;
  }

  static logout(String userId) async {
    String url = APPConfig.Server + "/user/logout";
    var params = {"userId": userId};
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params);
    return result;
  }

  static Future<BaseResult> uploadToken() async {
    String url = APPConfig.Server + "/upload/token";
    BaseResult result = await httpManager.request(HttpMethod.GET, url, null);
    return result;
  }

  static Future<BaseResult> onUpload(Uint8List data) async {
    String url = APPConfig.Server + "/upload/qiniu";
    BaseResult result = await httpManager.upload(url, data);
    return result;
  }

  static submitProduct(Map<String, dynamic> params) async {
    String url = APPConfig.Server + "/product/submit";
    BaseResult result = await httpManager.request(HttpMethod.POST, url, params, contentType: ContentType.json);
    return result;
  }

  static requestMyProductListData(int userId) async {
    String url = APPConfig.Server + "/product/pageListByCreateUserId";
    var params = {"userId": userId};
    BaseResult result = await httpManager.request(HttpMethod.GET, url, params, contentType: ContentType.json);
    return result;
  }*/
}
