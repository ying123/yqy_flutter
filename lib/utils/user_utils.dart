import 'package:yqy_flutter/ui/login/bean/login_entity.dart';
import 'package:yqy_flutter/utils/local_storage_utils.dart';
import './local_storage_utils.dart';
import 'package:yqy_flutter/bean/user_info.dart';
class UserUtils {
  static const USER_INFO_KEY = "USER_INFO_KEY";

  static const USER_NAME_KEY = "USER_NAME_KEY";




  static  saveUserInfo(LoginEntity userInfo) {
    if (userInfo != null) {
      LocalStorage.putObject(USER_INFO_KEY, userInfo.toJson());
    }
  }

  static saveUserName(String username) {
    if (username != null) {
      LocalStorage.putString(USER_NAME_KEY, username);
    }
  }

  static removeUserInfo() {
    LocalStorage.remove(USER_INFO_KEY);
  }

  static LoginEntity getUserInfo() {
    Map userJson = LocalStorage.getObject(USER_INFO_KEY);
    return userJson == null ? null : LoginEntity.fromJson(userJson);
  }

  static String getUserName() {
    return LocalStorage.getString(USER_NAME_KEY);
  }

  static bool isLogin() {

    var res = getUserInfo()== null ? false : true;
    return res;
  }
}
