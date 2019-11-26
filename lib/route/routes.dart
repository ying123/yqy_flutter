import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './route_handlers.dart';

class Routes {

  static String rootPage = "/";
  
  static String mainPage = "/main";

  static String productDetailPage = "/productDetailPage";

  static String myProductListPage = "/myProductList";

  static String newProductPage = "/newProductPage";

  ////

  static String loginPage = "/login";

  static String registerPage = "/registerPage";

  static String homePage = "/homePage";


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

  static String realNamePage = "/realNamePage";

  static String feedBackPage = "/feedBackPage";

  static String personalPage = "/personalPage";

  static String updateExplainPage = "/updateExplainPage";

  static String myCollectionPage = "/myCollectionPage";

  static String settingPage = "/settingPage";

  static String aboutPage = "/aboutPage";

  static String myIntegralPage = "/myIntegralPage";

  static String myIntegralDetailPage = "/myIntegralDetailPage";

  static String shopHomePage = "/shopHomePage";


  static String orderListPage = "/orderListPage";


  static String myFootPage = "/myFootPage";


  static String taskQuestionNairePage = "/taskQuestionNairePage";


  static String taskVideoPage = "/taskVideoPage";

  static String myEnterprisePage = "/myEnterprisePage";

  static String enterpriseHomePage = "/enterpriseHomePage";

  static String staffListPage = "/staffListPage";

  static String searchPage = "/searchPage";

  static String searchHomePage = "/searchHomePage"; //首页的搜索

  static String noticeHomePage = "/noticeHomePage"; //首页的通知



  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
       print("ROUTE WAS NOT FOUND !!!");
       return null;
    });
    router.define(loginPage, handler:loginHandler);
    router.define(registerPage, handler:registerHandler);
    router.define(homePage, handler: homeDetailsHandler);
    router.define(videoDetailsPage, handler: videoDetailsHandler);
    router.define(liveMeeting, handler: liveHandler);
     router.define(webPage, handler: webHandler);
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
    router.define(realNamePage, handler: realNameHomeHandler);
    router.define(feedBackPage, handler: feedBackHandler);
    router.define(personalPage, handler: personalHandler);
    router.define(updateExplainPage, handler: updateExplainHandler);
    router.define(myCollectionPage, handler: myCollectionHandler);
    router.define(settingPage, handler:settingHandler);
    router.define(aboutPage, handler:aboutHandler);
    router.define(myIntegralPage, handler:myIntegralHandler);
    router.define(myIntegralDetailPage, handler:myIntegralDetailHandler);
    router.define(shopHomePage, handler: shopHomeHandler);
    router.define(orderListPage, handler: orderListHandler);
    router.define(myFootPage, handler: myFootHandler);
    router.define(taskQuestionNairePage, handler:taskQuestionNaireHandler);
    router.define(myEnterprisePage, handler:myEnterpriseHandler);
    router.define(enterpriseHomePage, handler:enterpriseHomeHandler);
    router.define(staffListPage, handler:staffListHandler);
    router.define(searchPage, handler:searchHandler);
    router.define(taskVideoPage, handler:taskVideoHandler);
    router.define(searchHomePage, handler:searchHomeHandler);
    router.define(noticeHomePage, handler:noticeHomeHandler);
   /* router.define(rootPage, handler: rootHandler);
    router.define(mainPage, handler: mainHandler);
    router.define(productDetailPage, handler: productDetailHandler);
    router.define(webPage, handler: webHandler);
    router.define(myProductListPage, handler: myProductListHandler);
    router.define(newProductPage, handler: newProductHandler);
   */
  }

}