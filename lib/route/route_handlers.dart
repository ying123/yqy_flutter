import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/ui/home/news_content.dart';
import 'package:yqy_flutter/ui/home/zx_content.dart';
import 'package:yqy_flutter/ui/live/hd_details.dart';
import 'package:yqy_flutter/ui/live/live_details.dart';
import 'package:yqy_flutter/ui/special/special_details.dart';
import 'package:yqy_flutter/ui/special/special_page.dart';
import 'package:yqy_flutter/ui/special/special_video_details.dart';
import 'package:yqy_flutter/ui/special/special_web_details.dart';
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
  String title = params["title"]?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
  return NewsContentPage(id,title);
});



var zxDetailsHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {

  String id = params["id"]?.first;
  String title = params["title"]?.first;
  var list = List<int>();
  jsonDecode(title).forEach(list.add);
  title = Utf8Decoder().convert(list);
  return ZxContentPage(id,title);
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



/*
var rootHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserUtils.isLogin() ? ApplicationPage() : LoginPage();
});

var mainHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return ApplicationPage();
});

var loginHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LoginPage();
});

var registerHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return RegisterPage();
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









