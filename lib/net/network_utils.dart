import 'dart:io';
import 'dart:async';
import 'package:yqy_flutter/bean/base_result.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';

import 'http_manager.dart';
import 'dart:typed_data';

class NetworkUtils {




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
    BaseResult result = await httpManager.request(HttpMethod.POST, url,{"page":page,"token":"4aef8efb0f1b306901759d4152b468341751894"});
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
    BaseResult result = await httpManager.request(HttpMethod.POST, url, {"medicalnewsId":id,"token":"4aef8efb0f1b306901759d4152b468341751894"});
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
