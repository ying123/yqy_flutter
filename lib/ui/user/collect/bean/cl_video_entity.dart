class ClVideoEntity {
	String msg;
	int code;
	List<ClVideoInfo> info;

	ClVideoEntity({this.msg, this.code, this.info});

	ClVideoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['info'] != null) {
			info = new List<ClVideoInfo>();(json['info'] as List).forEach((v) { info.add(new ClVideoInfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ClVideoInfo {
	String createTime;
	int userId;
	int num;
	int dataFlag;
	int id;
	int otherId;
	ClVideoInfoVideo video;

	ClVideoInfo({this.createTime, this.userId, this.num, this.dataFlag, this.id, this.otherId, this.video});

	ClVideoInfo.fromJson(Map<String, dynamic> json) {
		createTime = json['create_time'];
		userId = json['user_id'];
		num = json['num'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		otherId = json['other_id'];
		video = json['video'] != null ? new ClVideoInfoVideo.fromJson(json['video']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['create_time'] = this.createTime;
		data['user_id'] = this.userId;
		data['num'] = this.num;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['other_id'] = this.otherId;
		if (this.video != null) {
      data['video'] = this.video.toJson();
    }
		return data;
	}
}

class ClVideoInfoVideo {
	String image;
	int pv;
	int id;
	String title;

	ClVideoInfoVideo({this.image, this.pv, this.id, this.title});

	ClVideoInfoVideo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		pv = json['pv'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['pv'] = this.pv;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
