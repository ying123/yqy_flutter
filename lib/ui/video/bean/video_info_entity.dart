class VideoInfoEntity {
	String msg;
	int code;
	VideoInfoInfo info;

	VideoInfoEntity({this.msg, this.code, this.info});

	VideoInfoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new VideoInfoInfo.fromJson(json['info']) : null;
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

class VideoInfoInfo {
	String image;
	int uid;
	String createTime;
	List<String> keywords;
	String playUrl;
	int pv;
	int id;
	String title;
	VideoInfoInfoUsers users;
	String desc;
	String videoId;
	List<VideoInfoInfoVideoList> videoList;

	VideoInfoInfo({this.image, this.uid, this.createTime, this.keywords, this.playUrl, this.pv, this.id, this.title, this.users, this.desc, this.videoId, this.videoList});

	VideoInfoInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		uid = json['uid'];
		createTime = json['create_time'];
		keywords = json['keywords']?.cast<String>();
		playUrl = json['play_url'];
		pv = json['pv'];
		id = json['id'];
		title = json['title'];
		users = json['users'] != null ? new VideoInfoInfoUsers.fromJson(json['users']) : null;
		desc = json['desc'];
		videoId = json['video_id'];
		if (json['video_list'] != null) {
			videoList = new List<VideoInfoInfoVideoList>();(json['video_list'] as List).forEach((v) { videoList.add(new VideoInfoInfoVideoList.fromJson(v)); });
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

class VideoInfoInfoUsers {
	String realName;
	String userPhoto;
	int id;
	VideoInfoInfoUsersHospital hospital;
	VideoInfoInfoUsersJob job;
	VideoInfoInfoUsersDeparts departs;

	VideoInfoInfoUsers({this.realName, this.userPhoto, this.id, this.hospital, this.job, this.departs});

	VideoInfoInfoUsers.fromJson(Map<String, dynamic> json) {
		realName = json['realName'];
		userPhoto = json['userPhoto'];
		id = json['id'];
		hospital = json['hospital'] != null ? new VideoInfoInfoUsersHospital.fromJson(json['hospital']) : null;
		job = json['job'] != null ? new VideoInfoInfoUsersJob.fromJson(json['job']) : null;
		departs = json['departs'] != null ? new VideoInfoInfoUsersDeparts.fromJson(json['departs']) : null;
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

class VideoInfoInfoUsersHospital {
	String name;

	VideoInfoInfoUsersHospital({this.name});

	VideoInfoInfoUsersHospital.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}

class VideoInfoInfoUsersJob {
	String name;

	VideoInfoInfoUsersJob({this.name});

	VideoInfoInfoUsersJob.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}

class VideoInfoInfoUsersDeparts {
	String name;

	VideoInfoInfoUsersDeparts({this.name});

	VideoInfoInfoUsersDeparts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}

class VideoInfoInfoVideoList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	VideoInfoInfoVideoList({this.image, this.createTime, this.pv, this.id, this.title});

	VideoInfoInfoVideoList.fromJson(Map<String, dynamic> json) {
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
