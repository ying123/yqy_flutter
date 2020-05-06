class Mesage_entity {
  int code;
  String msg;
  Info info;

  Mesage_entity({this.code, this.msg, this.info});

  Mesage_entity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class Info {
  int code;
  String msg;
  List<InfoX> info;

  Info({this.code, this.msg, this.info});

  Info.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['info'] != null) {
      info = new List<InfoX>();
      json['info'].forEach((v) {
        info.add(new InfoX.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.info != null) {
      data['info'] = this.info.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InfoX {
  int id;
  String title;
  String msgContent;
  int msgStatus;
  String createTime;

  InfoX({this.id, this.title, this.msgContent, this.msgStatus, this.createTime});

  InfoX.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    msgContent = json['msgContent'];
    msgStatus = json['msgStatus'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['msgContent'] = this.msgContent;
    data['msgStatus'] = this.msgStatus;
    data['createTime'] = this.createTime;
    return data;
  }
}