class VideoPageEntity {
	String msg;
	int code;
	VideoPageInfo info;

	VideoPageEntity({this.msg, this.code, this.info});

	VideoPageEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new VideoPageInfo.fromJson(json['info']) : null;
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

class VideoPageInfo {
	String image;
	int uid;
	String createTime;
	List<String> keywords;
	String playUrl;
	int pv;
	int id;
	String title;
	VideoPageInfoUsers users;
	String desc;
	String videoId;
	List<VideoPageInfoVideoList> videoList;

	VideoPageInfo({this.image, this.uid, this.createTime, this.keywords, this.playUrl, this.pv, this.id, this.title, this.users, this.desc, this.videoId, this.videoList});

	VideoPageInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		uid = json['uid'];
		createTime = json['create_time'];
		keywords = json['keywords']?.cast<String>();
		playUrl = json['play_url'];
		pv = json['pv'];
		id = json['id'];
		title = json['title'];
		users = json['users'] != null ? new VideoPageInfoUsers.fromJson(json['users']) : null;
		desc = json['desc'];
		videoId = json['video_id'];
		if (json['video_list'] != null) {
			videoList = new List<VideoPageInfoVideoList>();(json['video_list'] as List).forEach((v) { videoList.add(new VideoPageInfoVideoList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['uid'] = this.uid;
		data['create_time'] = this.createTime;
		data['keywords'] = this.keywords;
		data['play_url'] = this.playUrl;
		data['pv'] = this.pv;
		data['id'] = this.id;
		data['title'] = this.title;
		if (this.users != null) {
      data['users'] = this.users.toJson();
    }
		data['desc'] = this.desc;
		data['video_id'] = this.videoId;
		if (this.videoList != null) {
      data['video_list'] =  this.videoList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class VideoPageInfoUsers {
	String realName;
	String userPhoto;
	int id;
	VideoPageInfoUsersHospital hospital;
	VideoPageInfoUsersJob job;
	VideoPageInfoUsersDeparts departs;

	VideoPageInfoUsers({this.realName, this.userPhoto, this.id, this.hospital, this.job, this.departs});

	VideoPageInfoUsers.fromJson(Map<String, dynamic> json) {
		realName = json['realName'];
		userPhoto = json['userPhoto'];
		id = json['id'];
		hospital = json['hospital'] != null ? new VideoPageInfoUsersHospital.fromJson(json['hospital']) : null;
		job = json['job'] != null ? new VideoPageInfoUsersJob.fromJson(json['job']) : null;
		departs = json['departs'] != null ? new VideoPageInfoUsersDeparts.fromJson(json['departs']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['realName'] = this.realName;
		data['userPhoto'] = this.userPhoto;
		data['id'] = this.id;
		if (this.hospital != null) {
      data['hospital'] = this.hospital.toJson();
    }
		if (this.job != null) {
      data['job'] = this.job.toJson();
    }
		if (this.departs != null) {
      data['departs'] = this.departs.toJson();
    }
		return data;
	}
}

class VideoPageInfoUsersHospital {
	String name;

	VideoPageInfoUsersHospital({this.name});

	VideoPageInfoUsersHospital.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}

class VideoPageInfoUsersJob {
	String name;

	VideoPageInfoUsersJob({this.name});

	VideoPageInfoUsersJob.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}

class VideoPageInfoUsersDeparts {
	String name;

	VideoPageInfoUsersDeparts({this.name});

	VideoPageInfoUsersDeparts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}

class VideoPageInfoVideoList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	VideoPageInfoVideoList({this.image, this.createTime, this.pv, this.id, this.title});

	VideoPageInfoVideoList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		createTime = json['create_time'];
		pv = json['pv'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['create_time'] = this.createTime;
		data['pv'] = this.pv;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
