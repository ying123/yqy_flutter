import 'package:flutter/material.dart';

/// 颜色
class AppColors {
  static const PrimaryColor = Colors.blueAccent;
  static const DividerColor = Color(0xffd9d9d9);
  static const ArrowNormalColor = Color(0xff999999);
  static const BackgroundColor = Color(0xffebebeb);
  static const DarkTextColor = Color(0xFF333333);
  static const MidTextColor = Color(0xFF666666);
  static const LightTextColor = Color(0xFF999999);
  static const DisableTextColor = Color(0xFFDCDCDC);
}



class AppRequest{

  ///  旧版----------------------------------------------------------------------------------- 废弃
  static const  String Loading_content = "正在加载,请稍后...";
  static const String Banner_home = "9";//首页banner 类型
  static const String Banner_doctor = "10";//名医分享banner
  static const String Banner_signExpert = "11";//签约专家 banner

  static const String Label_medicine = "6";//医药新闻分类
  static const String LawsAndRegulations = "7";//法律法规分类

  static const String Label_recommend = "2";//药品推荐
  static const String Label_doctor = "1";//名医分享
  static const String Label_disease = "3";//疾病类型
  static const String Label_department = "4";//疾病类型
  static const String Label_research = "5";//研究类型

  static const String Collect_doctor_share = "14";//名医分享
  static const String Collect_medical_park = "9";//医学园
  static const String Collect_live_broadcast = "5";//直播会议
  static const String Collect_HD_live_broadcast = "15";//互动直播
  static const String Collect_News = "11";//医药新闻收藏
  static const String Collect_ZX = "12";//政策资讯收藏
  static const String Collect_GF = "13";//规范解读收藏

  static const String Comment_meeting_HD_live = "12";//互动直播评论的type id
  static const String Comment_meeting_notice = "4";//会议预告
  static const String Comment_meeting_live = "5";//会议预告
  static const String Comment_video_meeting = "6";//视频会议
  static const String Comment_audio_meeting = "7";//音频会议
  static const String Comment_image_meeting = "8";//图文会议
  static const String Comment_medical_park = "9";//医学园
  static const String Comment_doctor_share = "11";//名医分享
  static const String Comment_Specail = "13";//视频会议



  static const String Awesome_doctor_share = "6";//名医分享
  static const String Awesome_medical_order = "5";//医者医言
  static const String Awesome_medical_park = "4";//医学园


  static const String Share_new_medical = "Home/news/medicineinfo/id/";//医药新闻
  static const String Share_new_policy = "Home/news/policyinfo/id/";//政策资讯
  static const String Share_new_standard = "Home/news/standardinfo/id/";//规范解读





  static const String SHARE_LIVE_START = "meeting/live_info/id/";//分享正在直播的会议 需要拼接 直播ID  74

  static const String SHARE_LIVE_HD_START = "meeting/interact_info/id/";//分享正在互动直播的会议 需要拼接 直播ID  74

  static const String SHARE_LIVE_END = ".html?from=groupmessage";//分享正在直播的会议结束



  static const String Share_meeting_notice = "Home/meeting/noticeinfo/id/";//会议预告
  static const String Share_meeting_broadcast = "Home/meeting/broadcastinfo/id/";//会议直播
  static const String Share_meeting_video = "Home/meeting/periodinfo/id/";//视频会议
  static const String Share_meeting_audio= "Home/meeting/audiomeetinginfo/id/";//音频会议
  static const String Share_meeting_image= "Home/meeting/meetinginfo/id/";//图文会议

  static const String Share_info_medicalpark = "home/medical/parkinfo/id/";//医学园
  static const String Share_info_doctorshare = "Home/doctor/shareInfo/id/";//名医分享

  static const String SP_NAME="com.yqy.medicine_sp";//SharedPreferences key
  static const String FOLDER="com.yqy.medicine";
  static const String FILE_PROVIDER="com.yqy.medicine.fileprovider";

  static const int Video = 1;//往期视频会议列表
  static const int Audio = 2;//往期音频会议列表
  static const int Image = 3;//往期图文会议列表



  static const int LIVE_XS = 1;//学术会议直播列表
  static const int LIVE_HD = 2;//互动直播列表

///  新版-----------------------------------------------------------------------------------
  static const String PAGE_ROUTE_LIVE  = "4";//会议直播 类型

  static const String PAGE_ROUTE_DOCTOR_VIDEO_INFO  = "20";//专家视频详情类型

}





class AppSize {
  static const DividerWidth = 0.5;
}

class Constant {
  static const IconFontFamily = "appIconFont";
}

class APPConfig {


  static const WX_APP_ID = "wx86155ed3e169e37a";

  static const WX_APP_SECRET = "246339deaf46d36e66719b3ad524d40f";


  static const APK_PATH = "/storage/emulated/0/shuiyan.apk";


  static const DEBUG = true;
  //static const Server = "http://api.yaoqiyuan.com/api/";


  static const Server = "http://apitest.yaoqiyuan.com/";//测试地址
 // static const Server = "http://test.yaoqiyuan.com/api/"; //测试地址
  // static const Server = "http://localhost:8090";


   static String onlinePicUrl = "http://api.yaoqiyuan.com/";//视频分享地址


   static String onlineLiveUrl = "http://m.yaoqiyuan.com/";//直播分享地址

  static const Agreement = Server+ "Register/agreement";  //用户协议

  static const WebIntro = Server+ "About/WebIntro"; // 平台资质


   static final String Share_meeting_broadcast =  onlinePicUrl+"Home/meeting/broadcastinfo/id/";//会议直播
  static final String Share_meeting_video = onlinePicUrl+"Home/meeting/periodinfo/id/";//视频会议


   static final String SHARE_LIVE_START = onlineLiveUrl+"meeting/live_info/id/";//分享正在直播的会议 需要拼接 直播ID  74

   static final String SHARE_LIVE_HD_START = onlineLiveUrl+"meeting/interact_info/id/";//分享正在互动直播的会议 需要拼接 直播ID  74

   static final String SHARE_LIVE_END = ".html?from=groupmessage";//分享正在直播的会议结束

}




class APPIcons {
  static const PlaceHolderAvatar = Icon(
    IconData(
      0xe642,
      fontFamily: Constant.IconFontFamily,
    ),
    size: 60.0,
    color: AppColors.ArrowNormalColor,
  );

  static const AddImgData = IconData(
    0xe70a,
    fontFamily: Constant.IconFontFamily,
  );

  static const ProfileListImgData = IconData(
    0xe64d,
    fontFamily: Constant.IconFontFamily,
  );

  static const ProfileAddImgData = IconData(
    0xe60c,
    fontFamily: Constant.IconFontFamily,
  );

  static const ProfileSettingImgData = IconData(
    0xe615,
    fontFamily: Constant.IconFontFamily,
  );

  static const EmptyData = IconData(
    0xe643,
    fontFamily: Constant.IconFontFamily,
  );

  static const NetworkErrorData = IconData(
    0xe86e,
    fontFamily: Constant.IconFontFamily,
  );
}
