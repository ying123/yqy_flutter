class MyGoodsEntity {
	String msg;
	int code;
	List<MyGoodsInfo> info;

	MyGoodsEntity({this.msg, this.code, this.info});

	MyGoodsEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['info'] != null) {
			info = new List<MyGoodsInfo>();(json['info'] as List).forEach((v) { info.add(new MyGoodsInfo.fromJson(v)); });
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

class MyGoodsInfo {
	String createTime;
	int userId;
	int dataFlag;
	int id;
	int otherId;
	MyGoodsInfoVideo video;

	MyGoodsInfo({this.createTime, this.userId, this.dataFlag, this.id, this.otherId, this.video});

	MyGoodsInfo.fromJson(Map<String, dynamic> json) {
		createTime = json['create_time'];
		userId = json['user_id'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		otherId = json['other_id'];
		video = json['video'] != null ? new MyGoodsInfoVideo.fromJson(json['video']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['create_time'] = this.createTime;
		data['user_id'] = this.userId;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['other_id'] = this.otherId;
		if (this.video != null) {
      data['video'] = this.video.toJson();
    }
		return data;
	}
}

class MyGoodsInfoVideo {
	String image;
	int pv;
	int id;
	String title;

	MyGoodsInfoVideo({this.image, this.pv, this.id, this.title});

	MyGoodsInfoVideo.fromJson(Map<String, dynamic> json) {
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
