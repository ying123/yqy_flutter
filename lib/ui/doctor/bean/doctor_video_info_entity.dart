class DoctorVideoInfoEntity {
	String msg;
	int code;
	DoctorVideoInfoInfo info;

	DoctorVideoInfoEntity({this.msg, this.code, this.info});

	DoctorVideoInfoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new DoctorVideoInfoInfo.fromJson(json['info']) : null;
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

class DoctorVideoInfoInfo {
	String image;
	int uid;
	String createTime;
	List<String> keywords;
	String playUrl;
	int pv;
	int id;
	String title;
	DoctorVideoInfoInfoUsers users;
	String desc;
	String videoId;
	List<DoctorVideoInfoInfoVideoList> videoList;

	DoctorVideoInfoInfo({this.image, this.uid, this.createTime, this.keywords, this.playUrl, this.pv, this.id, this.title, this.users, this.desc, this.videoId, this.videoList});

	DoctorVideoInfoInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		uid = json['uid'];
		createTime = json['create_time'];
		keywords = json['keywords']?.cast<String>();
		playUrl = json['play_url'];
		pv = json['pv'];
		id = json['id'];
		title = json['title'];
		users = json['users'] != null ? new DoctorVideoInfoInfoUsers.fromJson(json['users']) : null;
		desc = json['desc'];
		videoId = json['video_id'];
		if (json['video_list'] != null) {
			videoList = new List<DoctorVideoInfoInfoVideoList>();(json['video_list'] as List).forEach((v) { videoList.add(new DoctorVideoInfoInfoVideoList.fromJson(v)); });
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

class DoctorVideoInfoInfoUsers {
	String realName;
	String userPhoto;
	int id;
	DoctorVideoInfoInfoUsersHospital hospital;
	DoctorVideoInfoInfoUsersJob job;
	DoctorVideoInfoInfoUsersDeparts departs;

	DoctorVideoInfoInfoUsers({this.realName, this.userPhoto, this.id, this.hospital, this.job, this.departs});

	DoctorVideoInfoInfoUsers.fromJson(Map<String, dynamic> json) {
		realName = json['realName'];
		userPhoto = json['userPhoto'];
		id = json['id'];
		hospital = json['hospital'] != null ? new DoctorVideoInfoInfoUsersHospital.fromJson(json['hospital']) : null;
		job = json['job'] != null ? new DoctorVideoInfoInfoUsersJob.fromJson(json['job']) : null;
		departs = json['departs'] != null ? new DoctorVideoInfoInfoUsersDeparts.fromJson(json['departs']) : null;
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

class DoctorVideoInfoInfoUsersHospital {
	String name;

	DoctorVideoInfoInfoUsersHospital({this.name});

	DoctorVideoInfoInfoUsersHospital.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}

class DoctorVideoInfoInfoUsersJob {
	String name;

	DoctorVideoInfoInfoUsersJob({this.name});

	DoctorVideoInfoInfoUsersJob.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}

class DoctorVideoInfoInfoUsersDeparts {
	String name;

	DoctorVideoInfoInfoUsersDeparts({this.name});

	DoctorVideoInfoInfoUsersDeparts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}

class DoctorVideoInfoInfoVideoList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	DoctorVideoInfoInfoVideoList({this.image, this.createTime, this.pv, this.id, this.title});

	DoctorVideoInfoInfoVideoList.fromJson(Map<String, dynamic> json) {
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
