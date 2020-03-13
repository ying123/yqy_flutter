import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/bean/personal_entity.dart';
import 'package:yqy_flutter/main.dart';
import 'package:yqy_flutter/ui/doctor/doctor_details.dart';
import 'package:yqy_flutter/ui/doctor/doctor_video_info_page.dart';
import 'package:yqy_flutter/ui/doctor/doctor_video_list_page.dart';
import 'package:yqy_flutter/ui/drugs/drugs_company_detail_page.dart';
import 'package:yqy_flutter/ui/drugs/drugs_company_home_page.dart';
import 'package:yqy_flutter/ui/guide/guide_content.dart';
import 'package:yqy_flutter/ui/guide/pdf_view_page.dart';
import 'package:yqy_flutter/ui/home/flfg_content.dart';
import 'package:yqy_flutter/ui/home/gf_content.dart';
import 'package:yqy_flutter/ui/home/home_page.dart';
import 'package:yqy_flutter/ui/home/news_content.dart';
import 'package:yqy_flutter/ui/home/notice/notice_home_page.dart';
import 'package:yqy_flutter/ui/home/search/search_home_page.dart';
import 'package:yqy_flutter/ui/home/special_detail_page.dart';
import 'package:yqy_flutter/ui/home/zx_content.dart';
import 'package:yqy_flutter/ui/live/hd_details.dart';
import 'package:yqy_flutter/ui/live/live_details.dart';
import 'package:yqy_flutter/ui/live/live_ing_page.dart';
import 'package:yqy_flutter/ui/live/live_no_page.dart';
import 'package:yqy_flutter/ui/live/live_notice_page.dart';
import 'package:yqy_flutter/ui/live/live_playback_page.dart';
import 'package:yqy_flutter/ui/login/bind_phone_page.dart';
import 'package:yqy_flutter/ui/login/login_home_page.dart';
import 'package:yqy_flutter/ui/login/login_send_sms_page.dart';
import 'package:yqy_flutter/ui/login/perfect_info_page.dart';
import 'package:yqy_flutter/ui/shop/add_address_page.dart';
import 'package:yqy_flutter/ui/shop/address_list_page.dart';
import 'package:yqy_flutter/ui/shop/order_detail_page.dart';
import 'package:yqy_flutter/ui/shop/order_list_page.dart';
import 'package:yqy_flutter/ui/shop/shop_buy_order_page.dart';
import 'package:yqy_flutter/ui/shop/shop_details_page.dart';
import 'package:yqy_flutter/ui/shop/shop_home_page.dart';
import 'package:yqy_flutter/ui/shop/update_address_page.dart';
import 'package:yqy_flutter/ui/special/special_details.dart';
import 'package:yqy_flutter/ui/special/special_page.dart';
import 'package:yqy_flutter/ui/special/special_video_details.dart';
import 'package:yqy_flutter/ui/special/special_web_details.dart';
import 'package:yqy_flutter/ui/task/integral_list_page.dart';
import 'package:yqy_flutter/ui/task/task_list_page.dart';
import 'package:yqy_flutter/ui/task/task_question_naire_page.dart';
import 'package:yqy_flutter/ui/task/task_video_page.dart';
import 'package:yqy_flutter/ui/user/about_page.dart';
import 'package:yqy_flutter/ui/user/collect/collect_home_page.dart';
import 'package:yqy_flutter/ui/user/enterprise/enterprise_home_page.dart';
import 'package:yqy_flutter/ui/user/enterprise/my_enterprise_page.dart';
import 'package:yqy_flutter/ui/user/enterprise/search_page.dart';
import 'package:yqy_flutter/ui/user/enterprise/staff_list_page.dart';
import 'package:yqy_flutter/ui/user/feed_back_page.dart';
import 'package:yqy_flutter/ui/user/follow/follow_home_page.dart';
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

import 'package:yqy_flutter/ui/web/webview_page.dart';
import '../utils/user_utils.dart';
import 'package:yqy_flutter/ui/live/live_page.dart';
import 'package:yqy_flutter/ui/home/tab/tab_medical.dart';
import 'package:yqy_flutter/ui/task/task_page_new.dart';
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
  return LoginHomePage();
});

var homeDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HomeMainPage();
});



var liveHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LiveHomePage("act");
});


/*var videoHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return VideoHomePage();
});*/


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
  return DoctorDetailsPage(userId: id,);
});



var feedBackHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["userId"]?.first;
  return FeedBackPage();
});

var personalHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  //String avatarUrl = params["avatar"]?.first;
 // String userInfo = params["info"]?.first;
 // var list = List<int>();
  //jsonDecode(userInfo).forEach(list.add);
 // userInfo = Utf8Decoder().convert(list);
  return PersonalPage();
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
  return EnterpriseHomePage();
});



var staffListHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return StaffListPage();
});


var searchHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SearchPage();
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

var specialDetailHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SpecialDetailPage();
});


var liveNoticeHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return LiveNoticePage(id);
});


var liveNoHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return LiveNoPage(id);
});


var liveIngHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return LiveIngPage(id);
});


var livePaybackHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LivePaybackPage();
});


var taskNewPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TaskNewPage();
});


var drugsCompanyHomePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DrugsCompanyHomePage();
});


var drugsCompanyDetailPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DrugsCompanyDetailPage();
});


var realNameNewPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RealNameDoctorPage();
});

var followHomePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return FollowHomePage();
});

var collectHomePageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CollectHomePage();
});


var loginSendSmsPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String phone = params["phone"]?.first;
  return LoginSendSmsPage(phone);
});

var bindPhonePageeHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String unionid = params["unionid"]?.first;
  return BindPhonePage(unionid);
});

var perfectInfoPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String phone = params["phone"]?.first;
  String code = params["code"]?.first;
  return PerfectInfoPage(phone,code);
});


var shopBuyOrderPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return ShopBuyOrderPage(id);
});


var guideContentPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return GuideContentPage(id);
});


var addAddressPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AddAddressPage();
});



var taskListPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TaskListPage();
});

var integralListPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return IntegralListPage();
});


var orderDetailPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return OrderDetailPage(id);
});


var addressListPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AddressListPage();
});



var updateAddressPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return UpdateAddressPage(id);
});


var doctorVideoInfoPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params["id"]?.first;
  return DoctorVideoInfoPage(id);
});


var doctorVideoListPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DoctorVideoListPage();
});


var loginPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginHomePage();
});


var pdfViewPageHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return PdfViewPage();
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









