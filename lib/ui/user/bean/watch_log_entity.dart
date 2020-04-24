class Watch_log_entity {
  int code;
  String msg;
  List<Info> info;

  Watch_log_entity({this.code, this.msg, this.info});

  Watch_log_entity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['info'] != null) {
      info = new List<Info>();
      json['info'].forEach((v) {
        info.add(new Info.fromJson(v));
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

class Info {
  int pageId;
  String aid;
  int startTime;
  Video video;

  Info({this.pageId, this.aid, this.startTime, this.video});

  Info.fromJson(Map<String, dynamic> json) {
    pageId = json['page_id'];
    aid = json['aid'];
    startTime = json['start_time'];
    video = json['video'] != null ? new Video.fromJson(json['video']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_id'] = this.pageId;
    data['aid'] = this.aid;
    data['start_time'] = this.startTime;
    if (this.video != null) {
      data['video'] = this.video.toJson();
    }
    return data;
  }
}

class Video {
  int id;
  String title;
  String image;
  int isHidden;
  int pv;

  Video({this.id, this.title, this.image, this.isHidden, this.pv});

  Video.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    isHidden = json['is_hidden'];
    pv = json['pv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['is_hidden'] = this.isHidden;
    data['pv'] = this.pv;
    return data;
  }
}