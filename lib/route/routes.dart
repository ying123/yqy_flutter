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

  static String doctorDetailsPage = "/doctorDetailsPage";

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

  static String realNameRepresentPage = "/realNameRepresentPage"; // 代表的实名认证页面

  static String shopDetailsPage = "/shopDetailsPage"; //  积分商城详情

  //

  static String  loginHomePage = "/loginHomePage"; //  登陆首页


  static String  loginSendSmsPage = "/loginSendSmsPage"; //  发送短信页面

  static String specialDetailPage = "/specialDetailPage"; //  新的主题二级页面详情

  static String liveNoticePage = "/liveNoticePage"; //  新的直播预告

  static String liveNoPage = "/liveNoPage"; //  新的直播预告 临时

  static String liveIngPage = "/liveIngPage"; //  新的正在直播

  static String livePaybackPage = "/livePaybackPage"; //  新的直播回放

  static String liveReviewPage = "/liveReviewPage"; //  新的直播回放


  static String taskNewPage = "/taskNewPage"; //  新的积分兑换任务首页

  static String drugsCompanyHomePage = "/drugsCompanyHomePage"; //  药企首页

  static String drugsCompanyDetailPage = "/drugsCompanyDetailPage"; //  药企详情

  static String realNameNewPage = "/realNameNewPage"; //  新的实名认证页面

  static String followHomePage = "/followHomePage"; //  关注首页

  static String collectHomePage = "/collectHomePage"; //  收藏首页

  static String bindPhonePage = "/bindPhonePage"; //  绑定手机页面

  static String perfectInfoPage = "/perfectInfoPage"; //  完善资料页面

  static String shopBuyOrderPage = "/shopBuyOrderPage"; //  提交订单页面

  static String guideContentPage = "/guideContentPage"; //  文献详情页面


  static String addAddressPage = "/addAddressPage"; //  添加收货地址页面


  static String addressListPage = "/addressListPage"; //  收货地址列表管理页面

  static String taskListPage = "/taskListPage"; //  积分任务列表

  static String integralListPage = "/integralListPage"; //  积分明细列表


  static String orderDetailPage = "/orderDetailPage"; //  订单详情页面


  static String updateAddressPage = "/updateAddressPage"; //  修改地址页面


  static String doctorVideoListPage = "/doctorVideoListPage"; //  专家视频列表页面


  static String doctorVideoInfoPage = "/doctorVideoInfoPage"; //  专家视频详情页面


  static String pdfViewPage = "/pdfViewPage"; //  pdf页面


  static String hdCollectionPage = "/hdCollectionPage"; //  互动消息  收藏的消息

  static String hdCommentPage = "/hdCommentPage"; //  互动消息  评论的消息

  static String hdFollowPage = "/hdFollowPage"; //  互动消息  关注的消息

  static String doctorHomePage = "/doctorHomePage"; //  互动消息  关注的消息

  static String fansDoctorPage = "/fansDoctorPage"; //  我的粉丝列表

  static String myGoodsPage = "/myGoodsPage"; //  我的点赞列表




  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params) {
       print("ROUTE WAS NOT FOUND !!!");
       return null;
    });
    router.define(loginPage, handler:loginHandler);
    router.define(homePage, handler: homeDetailsHandler);
    router.define(videoDetailsPage, handler: videoDetailsHandler);
    router.define(liveMeeting, handler: liveHandler);
     router.define(webPage, handler: webHandler);
  //  router.define(videoListPage, handler: videoHandler);
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
    router.define(doctorDetailsPage, handler: doctorDetailsHandler);
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
    router.define(realNameRepresentPage, handler:realNameRepresentHandler);
    router.define(shopDetailsPage, handler:shopDetailsPageHandler);
    router.define(specialDetailPage, handler:specialDetailHandler);
    router.define(liveNoticePage, handler:liveNoticeHandler);
    router.define(liveIngPage, handler:liveIngHandler);
    router.define(livePaybackPage, handler:livePaybackHandler);
    router.define(liveReviewPage, handler:liveReviewPageHandler);
    router.define(taskNewPage, handler:taskNewPageHandler);
    router.define(drugsCompanyHomePage, handler:drugsCompanyHomePageHandler);
    router.define(drugsCompanyDetailPage, handler:drugsCompanyDetailPageHandler);
    router.define(realNameNewPage, handler:realNameNewPageHandler);
    router.define(followHomePage, handler:followHomePageHandler);
    router.define(collectHomePage, handler:collectHomePageHandler);
    router.define(loginHomePage, handler:loginPageHandler);
    router.define(loginSendSmsPage, handler:loginSendSmsPageHandler);
    router.define(bindPhonePage, handler:bindPhonePageeHandler);
    router.define(perfectInfoPage, handler:perfectInfoPageHandler);
    router.define(shopBuyOrderPage, handler:shopBuyOrderPageHandler);
    router.define(guideContentPage, handler:guideContentPageHandler);
    router.define(addAddressPage, handler:addAddressPageHandler);
    router.define(taskListPage, handler:taskListPageHandler);
    router.define(integralListPage, handler:integralListPageHandler);
    router.define(orderDetailPage, handler:orderDetailPageHandler);
    router.define(addressListPage, handler:addressListPageHandler);
    router.define(updateAddressPage, handler:updateAddressPageHandler);
    router.define(doctorVideoInfoPage, handler:doctorVideoInfoPageHandler);
    router.define(doctorVideoListPage, handler:doctorVideoListPageHandler);
    router.define(pdfViewPage, handler:pdfViewPageHandler);
    router.define(doctorHomePage, handler:doctorHomePageHandler);
    router.define(fansDoctorPage, handler:fansDoctorPageHandler);
    router.define(myGoodsPage, handler:myGoodsPageHandler);


   /* router.define(rootPage, handler: rootHandler);
    router.define(mainPage, handler: mainHandler);
    router.define(productDetailPage, handler: productDetailHandler);
    router.define(webPage, handler: webHandler);
    router.define(myProductListPage, handler: myProductListHandler);
    router.define(newProductPage, handler: newProductHandler);
   */
  }

}