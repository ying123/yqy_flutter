import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';

class BannerRouter {

  static BannerRouter _bannerRouter;

   static BannerRouter router() {
     return _bannerRouter;

   }

   static push(BuildContext context,int type,int id ){

     switch(type){

       case 200: // 跳转专家视频页面  用于首页的 视频 和 专家  的bannner 跳转
         RRouter.push(context, Routes.doctorVideoInfoPage, {"id":id});
         break;
     case 300: // 跳转专题详情
        RRouter.push(context ,Routes.specialDetailPage,{"id":id});
         break;
       case 0: // 直播详情
        FLToast.error(text: "暂无链接");
         break;
       case 5: // 直播详情
         RRouter.push(context, Routes.liveIngPage, {"id":id});
         break;
       case 6: // 积分专区
         RRouter.push(context, Routes.taskNewPage, {"id":id});
         break;
       case 8: // 预告详情
         RRouter.push(context, Routes.liveNoticePage, {"id":id});
         break;
       case 9: // 直播回看
         RRouter.push(context, Routes.liveReviewPage, {"id":id});
         break;
       case 11: // 资讯详情
         RRouter.push(context, Routes.newsContentPage, {"id":id});
         break;
       case 17: // 文献详情
         RRouter.push(context, Routes.guideContentPage, {"id":id});
         break;
       case 20: // 专家视频详情
         RRouter.push(context, Routes.doctorVideoInfoPage, {"id":id});
         break;
       case 22: // 专家个人主页
        RRouter.push(context, Routes.doctorDetailsPage, {"userId":id});
         break;
     }


   }



}