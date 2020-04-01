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
	String image;
	var logId;
	String playUrl;
	String title;
	int playTime;
	int uid;
	int times;
	VideoTaskInfoTask task;
	VideoTaskInfoCompany company;
	int id;
	int cid;
	String desc;
	String videoId;

	VideoTaskInfo({this.image, this.logId, this.playUrl, this.title, this.playTime, this.uid, this.times, this.task, this.company, this.id, this.cid, this.desc, this.videoId});

	VideoTaskInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		logId = json['log_id'];
		playUrl = json['play_url'];
		title = json['title'];
		playTime = json['play_time'];
		uid = json['uid'];
		times = json['times'];
		task = json['task'] != null ? new VideoTaskInfoTask.fromJson(json['task']) : null;
		company = json['company'] != null ? new VideoTaskInfoCompany.fromJson(json['company']) : null;
		id = json['id'];
		cid = json['cid'];
		desc = json['desc'];
		videoId = json['video_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['log_id'] = this.logId;
		data['play_url'] = this.playUrl;
		data['title'] = this.title;
		data['play_time'] = this.playTime;
		data['uid'] = this.uid;
		data['times'] = this.times;
		if (this.task != null) {
      data['task'] = this.task.toJson();
    }
		if (this.company != null) {
      data['company'] = this.company.toJson();
    }
		data['id'] = this.id;
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
