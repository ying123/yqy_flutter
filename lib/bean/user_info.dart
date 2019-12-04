import 'package:yqy_flutter/utils/string_utils.dart';
class UserInfo{

  int userId;

  String nickname;

  String account;

  String intro;

  String token;

  int expireTime;

  int userRole;

  String avatar;

  UserInfo(this.userId, this.nickname, this.account, this.intro, this.token,
      this.expireTime, this.userRole, this.avatar);



  UserInfo.fromJsonMap(Map<String, dynamic> map)
      : userId = map["userId"],
        nickname = map["nickname"],
        account = map["account"],
        intro = map["intro"],
        token = map["token"],
        expireTime = map["expireTime"],
        userRole = map["userRole"],
         avatar = map["avatar"];


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userId'] = userId;
    data['nickname'] = nickname;
    data['account'] = account;
    data['intro'] = intro;
    data['token'] = token;
    data['expireTime'] = expireTime;
    data['userRole'] = userRole;
    data['avatar'] = avatar;
    return data;
  }



}