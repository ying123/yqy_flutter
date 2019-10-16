import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {

  static String rootPage = "/";
  
  static String mainPage = "/main";

  static String loginPage = "/login";

  static String registerPage = "/registerPage";

  static String productDetailPage = "/productDetailPage";

  static String myProductListPage = "/myProductList";

  static String newProductPage = "/newProductPage";

  ////

  static String webPage = "/webPageView";

  static String liveMeeting = "/liveMeeting";

  static String videoListPage = "/videoListPage";

  static String videoDetailsPage = "/videoDetailsPage";

  static String tabMedicalPage = "/tabMedicalPage";

  static String newsContentPage = "/newsContentPage";

  static String specialPage = "/specialPage";

  static String specialDetailsPage = "/specialDetailsPage";

  static String specialDetailsVideoPage = "/specialDetailsVideoPage";

  static String specialDetailsWebPage = "/specialDetailsWebPage";


  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
       print("ROUTE WAS NOT FOUND !!!");
       return null;
    });
    router.define(videoDetailsPage, handler: videoDetailsHandler);
    router.define(liveMeeting, handler: liveHandler);
   // router.define(webPage, handler: webHandler);
    router.define(videoListPage, handler: videoHandler);
    router.define(tabMedicalPage, handler: tabMedicalHandler);
    router.define(newsContentPage, handler: newsDetailsHandler);
    router.define(specialPage, handler: specialHandler);
    router.define(specialDetailsPage, handler: specialDetailsHandler);
    router.define(specialDetailsVideoPage, handler: specialDetailsVideoHandler);
    router.define(specialDetailsWebPage, handler: specialDetailsWebHandler);
   /* router.define(rootPage, handler: rootHandler);
    router.define(mainPage, handler: mainHandler);
    router.define(productDetailPage, handler: productDetailHandler);
    router.define(webPage, handler: webHandler);
    router.define(myProductListPage, handler: myProductListHandler);
    router.define(newProductPage, handler: newProductHandler);
     router.define(loginPage, handler:loginHandler);
    router.define(registerPage, handler:registerHandler);*/
  }

}