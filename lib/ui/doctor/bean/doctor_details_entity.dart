class DoctorDetailsEntity {
	String msg;
	int code;
	DoctorDetailsInfo info;

	DoctorDetailsEntity({this.msg, this.code, this.info});

	DoctorDetailsEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new DoctorDetailsInfo.fromJson(json['info']) : null;
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

class DoctorDetailsInfo {
	dynamic jId;
	String userInfo;
	int hId;
	dynamic tIds;
	String recomImage;
	List<Null> medicalList;
	int fenNum;
	var count;
	int fens;
	List<DoctorDetailsInfoVideoList> videoList;
	String realName;
	List<Null> shareList;
	int clickNum;
	int id;
	String hospital;
	dynamic depart;
	dynamic job;
	DoctorDetailsInfoUserinfos userinfos;

	DoctorDetailsInfo({this.jId, this.userInfo, this.hId, this.tIds, this.recomImage, this.medicalList, this.fenNum, this.count, this.fens, this.videoList, this.realName, this.shareList, this.clickNum, this.id, this.hospital, this.depart, this.job, this.userinfos});

	DoctorDetailsInfo.fromJson(Map<String, dynamic> json) {
		jId = json['j_id'];
		userInfo = json['userInfo'];
		hId = json['h_id'];
		tIds = json['t_ids'];
		recomImage = json['recom_image'];
		if (json['medical_list'] != null) {
			medicalList = new List<Null>();
		}
		fenNum = json['fenNum'];
		count = json['count'];
		fens = json['fens'];
		if (json['video_list'] != null) {
			videoList = new List<DoctorDetailsInfoVideoList>();(json['video_list'] as List).forEach((v) { videoList.add(new DoctorDetailsInfoVideoList.fromJson(v)); });
		}
		realName = json['realName'];
		if (json['share_list'] != null) {
			shareList = new List<Null>();
		}
		clickNum = json['clickNum'];
		id = json['id'];
		hospital = json['hospital'];
		depart = json['depart'];
		job = json['job'];
		userinfos = json['userinfos'] != null ? new DoctorDetailsInfoUserinfos.fromJson(json['userinfos']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['j_id'] = this.jId;
		data['userInfo'] = this.userInfo;
		data['h_id'] = this.hId;
		data['t_ids'] = this.tIds;
		data['recom_image'] = this.recomImage;
		if (this.medicalList != null) {
      data['medical_list'] =  [];
    }
		data['fenNum'] = this.fenNum;
		data['count'] = this.count;
		data['fens'] = this.fens;
		if (this.videoList != null) {
      data['video_list'] =  this.videoList.map((v) => v.toJson()).toList();
    }
		data['realName'] = this.realName;
		if (this.shareList != null) {
      data['share_list'] =  [];
    }
		data['clickNum'] = this.clickNum;
		data['id'] = this.id;
		data['hospital'] = this.hospital;
		data['depart'] = this.depart;
		data['job'] = this.job;
		if (this.userinfos != null) {
      data['userinfos'] = this.userinfos.toJson();
    }
		return data;
	}
}

class DoctorDetailsInfoVideoList {
	int uid;
	String image;
	int times;
	String playUrl;
	String createTime;
	int lid;
	int pv;
	int mid;
	int id;
	String title;
	String desc;
	String videoId;

	DoctorDetailsInfoVideoList({this.uid, this.image, this.times, this.playUrl, this.createTime, this.lid, this.pv, this.mid, this.id, this.title, this.desc, this.videoId});

	DoctorDetailsInfoVideoList.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		image = json['image'];
		times = json['times'];
		playUrl = json['play_url'];
		createTime = json['create_time'];
		lid = json['lid'];
		pv = json['pv'];
		mid = json['mid'];
		id = json['id'];
		title = json['title'];
		desc = json['desc'];
		videoId = json['video_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['image'] = this.image;
		data['times'] = this.times;
		data['play_url'] = this.playUrl;
		data['create_time'] = this.createTime;
		data['lid'] = this.lid;
		data['pv'] = this.pv;
		data['mid'] = this.mid;
		data['id'] = this.id;
		data['title'] = this.title;
		data['desc'] = this.desc;
		data['video_id'] = this.videoId;
		return data;
	}
}

class DoctorDetailsInfoUserinfos {
	int perPage;
	int total;
	DoctorDetailsInfoUserinfosData data;
	int lastPage;
	int currentPage;

	DoctorDetailsInfoUserinfos({this.perPage, this.total, this.data, this.lastPage, this.currentPage});

	DoctorDetailsInfoUserinfos.fromJson(Map<String, dynamic> json) {
		perPage = json['per_page'];
		total = json['total'];
		data = json['data'] != null ? new DoctorDetailsInfoUserinfosData.fromJson(json['data']) : null;
		lastPage = json['last_page'];
		currentPage = json['current_page'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['per_page'] = this.perPage;
		data['total'] = this.total;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		data['last_page'] = this.lastPage;
		data['current_page'] = this.currentPage;
		return data;
	}
}

class DoctorDetailsInfoUserinfosData {
	int num;

	DoctorDetailsInfoUserinfosData({this.num});

	DoctorDetailsInfoUserinfosData.fromJson(Map<String, dynamic> json) {
		num = json['num'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['num'] = this.num;
		return data;
	}
}
