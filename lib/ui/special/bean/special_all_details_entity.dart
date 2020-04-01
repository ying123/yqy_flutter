class SpecialAllDetailsEntity {
	String msg;
	int code;
	SpecialDetailsInfo info;

	SpecialAllDetailsEntity({this.msg, this.code, this.info});

	SpecialAllDetailsEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new SpecialDetailsInfo.fromJson(json['info']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.info != null) {
      data['info'] = this.info.toJson();
    }
		return data;
	}
}

class SpecialDetailsInfo {
	String image;
	String playUrl;
	String createTime;
	int pv;
	int type;
	String title;
	String content;
	int isTop;
	int isShow;
	int sid;
	int id;
	int cid;
	String videoId;
	int status;

	SpecialDetailsInfo({this.image, this.playUrl, this.createTime, this.pv, this.type, this.title, this.content, this.isTop, this.isShow, this.sid, this.id, this.cid, this.videoId, this.status});

	SpecialDetailsInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		playUrl = json['play_url'];
		createTime = json['create_time'];
		pv = json['pv'];
		type = json['type'];
		title = json['title'];
		content = json['content'];
		isTop = json['is_top'];
		isShow = json['is_show'];
		sid = json['sid'];
		id = json['id'];
		cid = json['cid'];
		videoId = json['video_id'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['play_url'] = this.playUrl;
		data['create_time'] = this.createTime;
		data['pv'] = this.pv;
		data['type'] = this.type;
		data['title'] = this.title;
		data['content'] = this.content;
		data['is_top'] = this.isTop;
		data['is_show'] = this.isShow;
		data['sid'] = this.sid;
		data['id'] = this.id;
		data['cid'] = this.cid;
		data['video_id'] = this.videoId;
		data['status'] = this.status;
		return data;
	}
}
