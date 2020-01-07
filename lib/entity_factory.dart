import 'package:yqy_flutter/bean/banner_entity.dart';
import 'package:yqy_flutter/bean/personal_entity.dart';
import 'package:yqy_flutter/bean/update_version_entity.dart';
import 'package:yqy_flutter/ui/doctor/bean/doctor_info_entity.dart';
import 'package:yqy_flutter/ui/home/bean/home_data_entity.dart';
import 'package:yqy_flutter/ui/home/bean/laws_deails_entity.dart';
import 'package:yqy_flutter/ui/home/bean/live_list_entity.dart';
import 'package:yqy_flutter/ui/home/bean/news_details_entity.dart';
import 'package:yqy_flutter/ui/home/bean/news_list_entity.dart';
import 'package:yqy_flutter/ui/home/notice/bean/notice_home_entity.dart';
import 'package:yqy_flutter/ui/live/bean/hd_details_entity.dart';
import 'package:yqy_flutter/ui/live/bean/live_details_entity.dart';
import 'package:yqy_flutter/ui/login/bean/login_entity.dart';
import 'package:yqy_flutter/ui/login/bean/send_sms_entity.dart';
import 'package:yqy_flutter/ui/login/bean/wx_info_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_banner_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_cate_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_list_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_video_entity.dart';
import 'package:yqy_flutter/ui/task/bean/task_list_entity.dart';
import 'package:yqy_flutter/ui/task/bean/task_question_entity.dart';
import 'package:yqy_flutter/ui/task/bean/task_video_entity.dart';
import 'package:yqy_flutter/ui/task/bean/upload_naire_entity.dart';
import 'package:yqy_flutter/ui/user/bean/about_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_details_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_list_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_details_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "BannerEntity") {
      return BannerEntity.fromJson(json) as T;
    } else if (T.toString() == "PersonalEntity") {
      return PersonalEntity.fromJson(json) as T;
    } else if (T.toString() == "UpdateVersionEntity") {
      return UpdateVersionEntity.fromJson(json) as T;
    } else if (T.toString() == "DoctorInfoEntity") {
      return DoctorInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeDataEntity") {
      return HomeDataEntity.fromJson(json) as T;
    } else if (T.toString() == "LawsDeailsEntity") {
      return LawsDeailsEntity.fromJson(json) as T;
    } else if (T.toString() == "LiveListInfo") {
      return LiveListInfo.fromJson(json) as T;
    } else if (T.toString() == "NewsDetailsEntity") {
      return NewsDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "NewsListEntity") {
      return NewsListEntity.fromJson(json) as T;
    } else if (T.toString() == "NoticeHomeEntity") {
      return NoticeHomeEntity.fromJson(json) as T;
    } else if (T.toString() == "HdDetailsEntity") {
      return HdDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "LiveDetailsEntity") {
      return LiveDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginEntity") {
      return LoginEntity.fromJson(json) as T;
    } else if (T.toString() == "SendSmsEntity") {
      return SendSmsEntity.fromJson(json) as T;
    } else if (T.toString() == "WxInfoEntity") {
      return WxInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "ShopHomeEntity") {
      return ShopHomeEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialBannerEntity") {
      return SpecialBannerEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialCateEntity") {
      return SpecialCateEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialListEntity") {
      return SpecialListEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialVideoEntity") {
      return SpecialVideoEntity.fromJson(json) as T;
    } else if (T.toString() == "TaskListEntity") {
      return TaskListEntity.fromJson(json) as T;
    } else if (T.toString() == "TaskQuestionEntity") {
      return TaskQuestionEntity.fromJson(json) as T;
    } else if (T.toString() == "TaskVideoEntity") {
      return TaskVideoEntity.fromJson(json) as T;
    } else if (T.toString() == "UploadQuestionBean") {
      return UploadQuestionBean.fromJson(json) as T;
    } else if (T.toString() == "AboutEntity") {
      return AboutEntity.fromJson(json) as T;
    } else if (T.toString() == "IntegralDetailsEntity") {
      return IntegralDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "IntegralEntity") {
      return IntegralEntity.fromJson(json) as T;
    } else if (T.toString() == "IntegralListEntity") {
      return IntegralListEntity.fromJson(json) as T;
    } else if (T.toString() == "VideoDetailsEntity") {
      return VideoDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "VideoListEntity") {
      return VideoListEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}