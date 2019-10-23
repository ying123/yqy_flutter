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

  static String zxContentPage = "/zxContentPage";

  static String flfgContentPage = "/flfgContentPage";

  static String gfContentPage = "/gfContentPage";

  static String specialPage = "/specialPage";

  static String specialDetailsPage = "/specialDetailsPage";

  static String specialDetailsVideoPage = "/specialDetailsVideoPage";

  static String specialDetailsWebPage = "/specialDetailsWebPage";

  static String liveDetailsPage = "/liveDetailsPage";

  static String hdDetailsPage = "/hdDetailsPage";

  static String doctorHomePage = "/doctorHomePage";

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
    router.define(liveDetailsPage, handler: liveDetailsHandler);
    router.define(hdDetailsPage, handler: hdDetailsHandler);
    router.define(zxContentPage, handler: zxDetailsHandler);
    router.define(flfgContentPage, handler: flfgDetailsHandler);
    router.define(gfContentPage, handler: gfDetailsHandler);
    router.define(doctorHomePage, handler: doctorHomeHandler);
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