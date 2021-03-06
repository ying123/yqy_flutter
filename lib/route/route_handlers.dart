import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/bean/personal_entity.dart';
import 'package:yqy_flutter/main.dart';
import 'package:yqy_flutter/ui/doctor/doctor_home.dart';
import 'package:yqy_flutter/ui/home/flfg_content.dart';
import 'package:yqy_flutter/ui/home/gf_content.dart';
import 'package:yqy_flutter/ui/home/home_page.dart';
import 'package:yqy_flutter/ui/home/news_content.dart';
import 'package:yqy_flutter/ui/home/notice/notice_home_page.dart';
import 'package:yqy_flutter/ui/home/search/search_home_page.dart';
import 'package:yqy_flutter/ui/home/zx_content.dart';
import 'package:yqy_flutter/ui/live/hd_details.dart';
import 'package:yqy_flutter/ui/live/live_details.dart';
import 'package:yqy_flutter/ui/login/login_page.dart';
import 'package:yqy_flutter/ui/login/register_page.dart';
import 'package:yqy_flutter/ui/shop/order_list_page.dart';
import 'package:yqy_flutter/ui/shop/shop_details_page.dart';
import 'package:yqy_flutter/ui/shop/shop_home_page.dart';
import 'package:yqy_flutter/ui/special/special_details.dart';
import 'package:yqy_flutter/ui/special/special_page.dart';
import 'package:yqy_flutter/ui/special/special_video_details.dart';
import 'package:yqy_flutter/ui/special/special_web_details.dart';
import 'package:yqy_flutter/ui/task/task_question_naire_page.dart';
import 'package:yqy_flutter/ui/task/task_video_page.dart';
import 'package:yqy_flutter/ui/user/about_page.dart';
import 'package:yqy_flutter/ui/user/enterprise/enterprise_home_page.dart';
import 'package:yqy_flutter/ui/user/enterprise/my_enterprise_page.dart';
import 'package:yqy_flutter/ui/user/enterprise/search_company_page.dart';
import 'package:yqy_flutter/ui/user/enterprise/staff_list_page.dart';
import 'package:yqy_flutter/ui/user/feed_back_page.dart';
import 'package:yqy_flutter/ui/user/my_collection_page.dart';
import 'package:yqy_flutter/ui/user/my_foot_page.dart';
import 'package:yqy_flutter/ui/user/my_integral_detail_page.dart';
import 'package:yqy_flutter/ui/user/my_integral_page.dart';
import 'package:yqy_flutter/ui/user/personal_page.dart';
import 'package:yqy_flutter/ui/user/real_name_doctor_page.dart';
import 'package:yqy_flutter/ui/user/real_name_represent_page.dart';
import 'package:yqy_flutter/ui/user/setting_page.dart';
import 'package:yqy_flutter/ui/user/update_explain.dart';
import 'package:yqy_flutter/ui/video/video_details.dart';
import 'package:yqy_flutter/ui/video/video_page.dart';

import 'package:yqy_flutter/ui/web/webview_page.dart';
import '../utils/user_utils.dart';
import 'package:yqy_flutter/ui/live/live_page.dart';
import 'package:yqy_flutter/ui/home/tab/tab_medical.dart';

/*
var webHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params['title']?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
  String url = params['url']?.first;
  return WebviewPage(title: title, url: url);
});
*/
var webHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String url = params["url"]?.first;
  String title = params["title"]?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
  return CommonWebviewPage(url: url,title: title,);
});


var loginHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

var registerHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegisterPage();
});

var homeDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeMainPage();
});



var liveHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LiveHomePage("act");
});


var videoHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return VideoHomePage();
});


var tabMedicalHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TabMedicalPage();
});


var videoDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  String reviewId = params["reviewId"]?.first;

  return VideoDetailsPage(id:reviewId);
});


var newsDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  String id = params["id"]?.first;
/*
  String title = params["title"]?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
*/
  return NewsContentPage(id);
});



var zxDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  String id = params["id"]?.first;
/*
  String title = params["title"]?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
*/
  return ZxContentPage(id);
});



var flfgDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  String id = params["id"]?.first;
  String title = params["title"]?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
  return FLFGContentPage(id,title);
});



var gfDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  String id = params["id"]?.first;
 /* String title = params["title"]?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);*/
  return GFContentPage(id);
});



var specialHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  String type = params["type"]?.first;
  return SpecialPage(type);
});


var specialDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  String title = params["title"]?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
  return SpecialDetailsPage(title,id);
});


var specialDetailsVideoHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return SpecialVideoDetailsPage(id);
});


var specialDetailsWebHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return SpecialWebDetailsPage(id);
});




var liveDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["broadcastId"]?.first;
  return LiveDetailsPage(id);
});


var hdDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["interactId"]?.first;
  return HdDetailsPage(id);
});



var doctorHomeHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["userId"]?.first;
  return DoctorHomePage(userId: id,);
});


var realNameHomeHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["userId"]?.first;
  return RealNamePage();
});

var feedBackHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["userId"]?.first;
  return FeedBackPage();
});

var personalHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String avatarUrl = params["avatar"]?.first;
  String userInfo = params["info"]?.first;
  var list = List<int>();
  jsonDecode(userInfo).forEach(list.add);
  userInfo = Utf8Decoder().convert(list);
  return PersonalPage(avatarUrl,userInfo);
});

var updateExplainHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["userId"]?.first;
  return UpdateExplainPage();
});

var myCollectionHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["userId"]?.first;
  return MyCollectionPage();
});

var settingHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SettingPage();
});


var aboutHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutPage();
});

var myIntegralHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  return MyIntegralPage();
});


var myIntegralDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;

  return MyIntegralDetailPage(id);
});

var shopHomeHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  return ShopHomePage();
});

var orderListHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  return OrderListPage();
});


var myFootHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  return MyFootPage();
});


var taskQuestionNaireHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["tid"]?.first;
  return TaskQuestionNairePage(id);
});

var myEnterpriseHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MyEnterprisePage();
});


var enterpriseHomeHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String cid = params["cid"]?.first;
  String bid = params["bid"]?.first;
  return EnterpriseHomePage(cid,bid);
});



var staffListHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return StaffListPage();
});



var taskVideoHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["tid"]?.first;
  return TaskVideoPage(id);
});

var searchHomeHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchHomePage();
});

var noticeHomeHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NoticeHomePage();
});


var realNameRepresentHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RealNameRepresentPage();
});



var shopDetailsPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return ShopDetailsPage(id);
});


var searchCompanyPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchCompanyPage();
});

/*
var rootHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserUtils.isLogin() ? ApplicationPage() : LoginPage();
});

var mainHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ApplicationPage();
});



var productDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String productId = params['productId']?.first;
  return GoodsDetailPage(productId: int.parse(productId));
});

var webHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String title = params['title']?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
  String url = params['url']?.first;
  return WebviewPage(title: title, url: url);
});

var myProductListHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return MyProductListPage();
});

var newProductHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String productId = params['productId']?.first;
  return NewGoodsPage(productId: int.parse(productId));
});
*/









