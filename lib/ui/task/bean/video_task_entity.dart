class VideoTaskEntity {
	String msg;
	int code;
	VideoTaskInfo info;

	VideoTaskEntity({this.msg, this.code, this.info});

	VideoTaskEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new VideoTaskInfo.fromJson(json['info']) : null;
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

class VideoTaskInfo {
	int uid;
	String image;
	int times;
	VideoTaskInfoTask task;
	String playUrl;
	VideoTaskInfoCompany company;
	int id;
	String title;
	int cid;
	String desc;
	String videoId;

	VideoTaskInfo({this.uid, this.image, this.times, this.task, this.playUrl, this.company, this.id, this.title, this.cid, this.desc, this.videoId});

	VideoTaskInfo.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		image = json['image'];
		times = json['times'];
		task = json['task'] != null ? new VideoTaskInfoTask.fromJson(json['task']) : null;
		playUrl = json['play_url'];
		company = json['company'] != null ? new VideoTaskInfoCompany.fromJson(json['company']) : null;
		id = json['id'];
		title = json['title'];
		cid = json['cid'];
		desc = json['desc'];
		videoId = json['video_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['image'] = this.image;
		data['times'] = this.times;
		if (this.task != null) {
      data['task'] = this.task.toJson();
    }
		data['play_url'] = this.playUrl;
		if (this.company != null) {
      data['company'] = this.company.toJson();
    }
		data['id'] = this.id;
		data['title'] = this.title;
		data['cid'] = this.cid;
		data['desc'] = this.desc;
		data['video_id'] = this.videoId;
		return data;
	}
}

class VideoTaskInfoTask {
	int id;
	int points;

	VideoTaskInfoTask({this.id, this.points});

	VideoTaskInfoTask.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		points = json['points'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['points'] = this.points;
		return data;
	}
}

class VideoTaskInfoCompany {
	String image;
	String name;
	int id;

	VideoTaskInfoCompany({this.image, this.name, this.id});

	VideoTaskInfoCompany.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
