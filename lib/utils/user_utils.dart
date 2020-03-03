import 'package:yqy_flutter/bean/user_entity.dart';
import 'package:yqy_flutter/ui/login/bean/login_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_buy_order_entity.dart';
import 'package:yqy_flutter/utils/local_storage_utils.dart';
import './local_storage_utils.dart';
import 'package:yqy_flutter/ui/user/bean/user_info_entity.dart';
class UserUtils {


  static const USER_TOKEN_KEY = "USER_TOKEN__KEY";
  static const USER_INFO_KEY = "USER_INFO_KEY";
  static const USER_ADDRESS_KEY = "USER_ADDRESS_KEY";
  static const USER_NAME_KEY = "USER_NAME_KEY";


  static  saveToken(String token) {
    if (token != null) {
      LocalStorage.putObject(USER_TOKEN_KEY,token);
    }
  }


  static removeToken() {
    LocalStorage.remove(USER_TOKEN_KEY);
  }

  static  saveUserInfo(UserInfoInfo userInfo) {
    if (userInfo != null) {
      LocalStorage.putObject(USER_INFO_KEY, userInfo.toJson());
    }
  }


  static removeUserInfo() {
    LocalStorage.remove(USER_INFO_KEY);
  }

  static saveUserName(String username) {
    if (username != null) {
      LocalStorage.putString(USER_NAME_KEY, username);
    }
  }


  // 已废弃
  static LoginEntity getUserInfo() {
    Map userJson = LocalStorage.getObject(USER_INFO_KEY);
    return userJson == null ? null : LoginEntity.fromJson(userJson);
  }

  // 新版 获取个人信息
  static UserInfoInfo getUserInfoX() {
    Map userJson = LocalStorage.getObject(USER_INFO_KEY);
    return userJson == null ? null : UserInfoInfo.fromJson(userJson);
  }


  ///
  ///  当前 收货地址
  ///
  static  saveAddress(ShopBuyOrderInfoAddress orderInfoAddress) {
    if (orderInfoAddress != null) {
      LocalStorage.putObject(USER_ADDRESS_KEY, orderInfoAddress.toJson());
    }
  }
  static ShopBuyOrderInfoAddress getAddress() {
    Map orderInfoAddress = LocalStorage.getObject(USER_ADDRESS_KEY);
    return orderInfoAddress == null ? null : ShopBuyOrderInfoAddress.fromJson(orderInfoAddress);
  }



  static String getUserName() {
    return LocalStorage.getString(USER_NAME_KEY);
  }

  static String getToken() {
    return LocalStorage.getString(USER_TOKEN_KEY).replaceAll("\"", "");
  }

  static bool isLogin() {

    var res = getToken()== "" ? false : true;
    return res;
  }
}
