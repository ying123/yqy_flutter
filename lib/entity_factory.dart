import 'package:yqy_flutter/ui/doctor/bean/doctor_info_entity.dart';
import 'package:yqy_flutter/ui/home/bean/home_data_entity.dart';
import 'package:yqy_flutter/ui/home/bean/laws_deails_entity.dart';
import 'package:yqy_flutter/ui/home/bean/live_list_entity.dart';
import 'package:yqy_flutter/ui/home/bean/news_details_entity.dart';
import 'package:yqy_flutter/ui/home/bean/news_list_entity.dart';
import 'package:yqy_flutter/ui/live/bean/hd_details_entity.dart';
import 'package:yqy_flutter/ui/live/bean/live_details_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_banner_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_cate_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_list_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_video_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_details_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
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
    } else if (T.toString() == "HdDetailsEntity") {
      return HdDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "LiveDetailsEntity") {
      return LiveDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialBannerEntity") {
      return SpecialBannerEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialCateEntity") {
      return SpecialCateEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialListEntity") {
      return SpecialListEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialVideoEntity") {
      return SpecialVideoEntity.fromJson(json) as T;
    } else if (T.toString() == "VideoDetailsEntity") {
      return VideoDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "VideoListEntity") {
      return VideoListEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}