import 'package:yqy_flutter/ui/home/bean/home_data_entity.dart';
import 'package:yqy_flutter/ui/home/bean/live_list_entity.dart';
import 'package:yqy_flutter/ui/home/bean/news_details_entity.dart';
import 'package:yqy_flutter/ui/home/bean/news_list_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "HomeDataEntity") {
      return HomeDataEntity.fromJson(json) as T;
    } else if (T.toString() == "LiveListEntity") {
      return LiveListInfo.fromJson(json) as T;
    } else if (T.toString() == "NewsDetailsEntity") {
      return NewsDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "NewsListEntity") {
      return NewsListEntity.fromJson(json) as T;
    } else if (T.toString() == "VideoListEntity") {
      return VideoListEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}