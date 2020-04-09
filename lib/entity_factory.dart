import 'package:yqy_flutter/bean/banner_entity.dart';
import 'package:yqy_flutter/bean/personal_entity.dart';
import 'package:yqy_flutter/bean/status_entity.dart';
import 'package:yqy_flutter/bean/update_version_entity.dart';
import 'package:yqy_flutter/bean/upload_image_entity.dart';
import 'package:yqy_flutter/bean/user_entity.dart';
import 'package:yqy_flutter/ui/doctor/bean/doctor_details_entity.dart';
import 'package:yqy_flutter/ui/doctor/bean/doctor_home_entity.dart';
import 'package:yqy_flutter/ui/doctor/bean/doctor_info_entity.dart';
import 'package:yqy_flutter/ui/doctor/bean/doctor_video_info_entity.dart';
import 'package:yqy_flutter/ui/guide/bean/guide_index_entity.dart';
import 'package:yqy_flutter/ui/guide/bean/guide_info_entity.dart';
import 'package:yqy_flutter/ui/guide/bean/guide_lists_entity.dart';
import 'package:yqy_flutter/ui/home/bean/home_data_entity.dart';
import 'package:yqy_flutter/ui/home/bean/is_certification_entity.dart';
import 'package:yqy_flutter/ui/home/bean/laws_deails_entity.dart';
import 'package:yqy_flutter/ui/home/bean/live_list_entity.dart';
import 'package:yqy_flutter/ui/home/bean/news_details_entity.dart';
import 'package:yqy_flutter/ui/home/bean/news_list_entity.dart';
import 'package:yqy_flutter/ui/home/bean/video_page_entity.dart';
import 'package:yqy_flutter/ui/home/notice/bean/notice_home_entity.dart';
import 'package:yqy_flutter/ui/home/search/bean/search_home_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/special_details_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_home_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_live_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_meeting_list_info_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_news_index_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_news_info_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_news_lists_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_special_entity.dart';
import 'package:yqy_flutter/ui/live/bean/comment_list_entity.dart';
import 'package:yqy_flutter/ui/live/bean/hc_status_entity.dart';
import 'package:yqy_flutter/ui/live/bean/hd_details_entity.dart';
import 'package:yqy_flutter/ui/live/bean/live_details_entity.dart';
import 'package:yqy_flutter/ui/live/bean/live_entity.dart';
import 'package:yqy_flutter/ui/live/bean/live_review_info_entity.dart';
import 'package:yqy_flutter/ui/live/bean/review_video_list_entity.dart';
import 'package:yqy_flutter/ui/login/bean/login_entity.dart';
import 'package:yqy_flutter/ui/login/bean/send_sms_entity.dart';
import 'package:yqy_flutter/ui/login/bean/wx_info_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/order_detail_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/order_list_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_address_list_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_buy_order_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_details_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_all_details_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_banner_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_cate_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_list_entity.dart';
import 'package:yqy_flutter/ui/special/bean/special_video_entity.dart';
import 'package:yqy_flutter/ui/task/bean/question_task_entity.dart';
import 'package:yqy_flutter/ui/task/bean/task_list_entity.dart';
import 'package:yqy_flutter/ui/task/bean/task_page_entity.dart';
import 'package:yqy_flutter/ui/task/bean/task_question_entity.dart';
import 'package:yqy_flutter/ui/task/bean/task_video_entity.dart';
import 'package:yqy_flutter/ui/task/bean/upload_naire_entity.dart';
import 'package:yqy_flutter/ui/task/bean/video_task_entity.dart';
import 'package:yqy_flutter/ui/user/bean/about_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_details_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_list_entity.dart';
import 'package:yqy_flutter/ui/user/bean/user_home_entity.dart';
import 'package:yqy_flutter/ui/user/bean/user_info_entity.dart';
import 'package:yqy_flutter/ui/user/collect/bean/cl_news_entity.dart';
import 'package:yqy_flutter/ui/user/collect/bean/cl_video_entity.dart';
import 'package:yqy_flutter/ui/user/enterprise/bean/my_enterprise_entity.dart';
import 'package:yqy_flutter/ui/user/follow/bean/flow_doctor_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_details_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_info_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "BannerEntity") {
      return BannerEntity.fromJson(json) as T;
    } else if (T.toString() == "PersonalEntity") {
      return PersonalEntity.fromJson(json) as T;
    } else if (T.toString() == "StatusEntity") {
      return StatusEntity.fromJson(json) as T;
    } else if (T.toString() == "UpdateVersionEntity") {
      return UpdateVersionEntity.fromJson(json) as T;
    } else if (T.toString() == "UploadImageEntity") {
      return UploadImageEntity.fromJson(json) as T;
    } else if (T.toString() == "UserEntity") {
      return UserEntity.fromJson(json) as T;
    } else if (T.toString() == "DoctorDetailsEntity") {
      return DoctorDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "DoctorHomeEntity") {
      return DoctorHomeEntity.fromJson(json) as T;
    } else if (T.toString() == "DoctorInfoEntity") {
      return DoctorInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "DoctorVideoInfoEntity") {
      return DoctorVideoInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "GuideIndexEntity") {
      return GuideIndexEntity.fromJson(json) as T;
    } else if (T.toString() == "GuideInfoEntity") {
      return GuideInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "GuideListsEntity") {
      return GuideListsEntity.fromJson(json) as T;
    } else if (T.toString() == "HomeDataEntity") {
      return HomeDataEntity.fromJson(json) as T;
    } else if (T.toString() == "IsCertificationEntity") {
      return IsCertificationEntity.fromJson(json) as T;
    } else if (T.toString() == "LawsDeailsEntity") {
      return LawsDeailsEntity.fromJson(json) as T;
    } else if (T.toString() == "LiveListInfo") {
      return LiveListInfo.fromJson(json) as T;
    } else if (T.toString() == "NewsDetailsEntity") {
      return NewsDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "NewsListEntity") {
      return NewsListEntity.fromJson(json) as T;
    } else if (T.toString() == "VideoPageEntity") {
      return VideoPageEntity.fromJson(json) as T;
    } else if (T.toString() == "NoticeHomeEntity") {
      return NoticeHomeEntity.fromJson(json) as T;
    } else if (T.toString() == "SearchHomeEntity") {
      return SearchHomeEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialDetailsEntity") {
      return SpecialDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "TabHomeEntity") {
      return TabHomeEntity.fromJson(json) as T;
    } else if (T.toString() == "TabLiveEntity") {
      return TabLiveEntity.fromJson(json) as T;
    } else if (T.toString() == "TabMeetingListInfoEntity") {
      return TabMeetingListInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "TabNewsIndexEntity") {
      return TabNewsIndexEntity.fromJson(json) as T;
    } else if (T.toString() == "TabNewsInfoEntity") {
      return TabNewsInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "TabNewsListsEntity") {
      return TabNewsListsEntity.fromJson(json) as T;
    } else if (T.toString() == "TabSpecialEntity") {
      return TabSpecialEntity.fromJson(json) as T;
    } else if (T.toString() == "CommentListEntity") {
      return CommentListEntity.fromJson(json) as T;
    } else if (T.toString() == "HcStatusEntity") {
      return HcStatusEntity.fromJson(json) as T;
    } else if (T.toString() == "HdDetailsEntity") {
      return HdDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "LiveDetailsEntity") {
      return LiveDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "LiveEntity") {
      return LiveEntity.fromJson(json) as T;
    } else if (T.toString() == "LiveReviewInfoEntity") {
      return LiveReviewInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "ReviewVideoListEntity") {
      return ReviewVideoListEntity.fromJson(json) as T;
    } else if (T.toString() == "LoginEntity") {
      return LoginEntity.fromJson(json) as T;
    } else if (T.toString() == "SendSmsEntity") {
      return SendSmsEntity.fromJson(json) as T;
    } else if (T.toString() == "WxInfoEntity") {
      return WxInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "OrderDetailEntity") {
      return OrderDetailEntity.fromJson(json) as T;
    } else if (T.toString() == "OrderListEntity") {
      return OrderListEntity.fromJson(json) as T;
    } else if (T.toString() == "ShopAddressListEntity") {
      return ShopAddressListEntity.fromJson(json) as T;
    } else if (T.toString() == "ShopBuyOrderEntity") {
      return ShopBuyOrderEntity.fromJson(json) as T;
    } else if (T.toString() == "ShopDetailsEntity") {
      return ShopDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "ShopHomeEntity") {
      return ShopHomeEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialAllDetailsEntity") {
      return SpecialAllDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialBannerEntity") {
      return SpecialBannerEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialCateEntity") {
      return SpecialCateEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialListEntity") {
      return SpecialListEntity.fromJson(json) as T;
    } else if (T.toString() == "SpecialVideoEntity") {
      return SpecialVideoEntity.fromJson(json) as T;
    } else if (T.toString() == "QuestionTaskEntity") {
      return QuestionTaskEntity.fromJson(json) as T;
    } else if (T.toString() == "TaskListEntity") {
      return TaskListEntity.fromJson(json) as T;
    } else if (T.toString() == "TaskPageEntity") {
      return TaskPageEntity.fromJson(json) as T;
    } else if (T.toString() == "TaskQuestionEntity") {
      return TaskQuestionEntity.fromJson(json) as T;
    } else if (T.toString() == "TaskVideoEntity") {
      return TaskVideoEntity.fromJson(json) as T;
    } else if (T.toString() == "UploadQuestionBean") {
      return UploadQuestionBean.fromJson(json) as T;
    } else if (T.toString() == "VideoTaskEntity") {
      return VideoTaskEntity.fromJson(json) as T;
    } else if (T.toString() == "AboutEntity") {
      return AboutEntity.fromJson(json) as T;
    } else if (T.toString() == "IntegralDetailsEntity") {
      return IntegralDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "IntegralEntity") {
      return IntegralEntity.fromJson(json) as T;
    } else if (T.toString() == "IntegralListEntity") {
      return IntegralListEntity.fromJson(json) as T;
    } else if (T.toString() == "UserHomeEntity") {
      return UserHomeEntity.fromJson(json) as T;
    } else if (T.toString() == "UserInfoEntity") {
      return UserInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "ClNewsEntity") {
      return ClNewsEntity.fromJson(json) as T;
    } else if (T.toString() == "ClVideoEntity") {
      return ClVideoEntity.fromJson(json) as T;
    } else if (T.toString() == "MyEnterpriseEntity") {
      return MyEnterpriseEntity.fromJson(json) as T;
    } else if (T.toString() == "FlowDoctorEntity") {
      return FlowDoctorEntity.fromJson(json) as T;
    } else if (T.toString() == "VideoDetailsEntity") {
      return VideoDetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "VideoInfoEntity") {
      return VideoInfoEntity.fromJson(json) as T;
    } else if (T.toString() == "VideoListEntity") {
      return VideoListEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}