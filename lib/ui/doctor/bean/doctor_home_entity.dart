class DoctorHomeEntity {
	String msg;
	int code;
	DoctorHomeInfo info;

	DoctorHomeEntity({this.msg, this.code, this.info});

	DoctorHomeEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new DoctorHomeInfo.fromJson(json['info']) : null;
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

class DoctorHomeInfo {
	List<DoctorHomeInfoRecomVideo> recomVideo;
	List<DoctorHomeInfoRecomDoctor> recomDoctor;
	List<DoctorHomeInfoTopBanner> topBanner;
	List<DoctorHomeInfoVideoList> videoList;

	DoctorHomeInfo({this.recomVideo, this.recomDoctor, this.topBanner, this.videoList});

	DoctorHomeInfo.fromJson(Map<String, dynamic> json) {
		if (json['recom_video'] != null) {
			recomVideo = new List<DoctorHomeInfoRecomVideo>();(json['recom_video'] as List).forEach((v) { recomVideo.add(new DoctorHomeInfoRecomVideo.fromJson(v)); });
		}
		if (json['recom_doctor'] != null) {
			recomDoctor = new List<DoctorHomeInfoRecomDoctor>();(json['recom_doctor'] as List).forEach((v) { recomDoctor.add(new DoctorHomeInfoRecomDoctor.fromJson(v)); });
		}
		if (json['top_banner'] != null) {
			topBanner = new List<DoctorHomeInfoTopBanner>();(json['top_banner'] as List).forEach((v) { topBanner.add(new DoctorHomeInfoTopBanner.fromJson(v)); });
		}
		if (json['video_list'] != null) {
			videoList = new List<DoctorHomeInfoVideoList>();(json['video_list'] as List).forEach((v) { videoList.add(new DoctorHomeInfoVideoList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.recomVideo != null) {
      data['recom_video'] =  this.recomVideo.map((v) => v.toJson()).toList();
    }
		if (this.recomDoctor != null) {
      data['recom_doctor'] =  this.recomDoctor.map((v) => v.toJson()).toList();
    }
		if (this.topBanner != null) {
      data['top_banner'] =  this.topBanner.map((v) => v.toJson()).toList();
    }
		if (this.videoList != null) {
      data['video_list'] =  this.videoList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class DoctorHomeInfoRecomVideo {
	String img;
	dynamic route;
	int artId;
	String name;
	int advType;
	dynamic mRoute;
	int id;
	String url;
	dynamic pcRoute;

	DoctorHomeInfoRecomVideo({this.img, this.route, this.artId, this.name, this.advType, this.mRoute, this.id, this.url, this.pcRoute});

	DoctorHomeInfoRecomVideo.fromJson(Map<String, dynamic> json) {
		img = json['img'];
		route = json['route'];
		artId = json['art_id'];
		name = json['name'];
		advType = json['adv_type'];
		mRoute = json['m_route'];
		id = json['id'];
		url = json['url'];
		pcRoute = json['pc_route'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['img'] = this.img;
		data['route'] = this.route;
		data['art_id'] = this.artId;
		data['name'] = this.name;
		data['adv_type'] = this.advType;
		data['m_route'] = this.mRoute;
		data['id'] = this.id;
		data['url'] = this.url;
		data['pc_route'] = this.pcRoute;
		return data;
	}
}

class DoctorHomeInfoRecomDoctor {
	String realName;
	dynamic jId;
	String recomImage;
	int tIds;
	int id;
	String department;
	dynamic job;

	DoctorHomeInfoRecomDoctor({this.realName, this.jId, this.recomImage, this.tIds, this.id, this.department, this.job});

	DoctorHomeInfoRecomDoctor.fromJson(Map<String, dynamic> json) {
		realName = json['realName'];
		jId = json['j_id'];
		recomImage = json['recom_image'];
		tIds = json['t_ids'];
		id = json['id'];
		department = json['department'];
		job = json['job'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['realName'] = this.realName;
		data['j_id'] = this.jId;
		data['recom_image'] = this.recomImage;
		data['t_ids'] = this.tIds;
		data['id'] = this.id;
		data['department'] = this.department;
		data['job'] = this.job;
		return data;
	}
}

class DoctorHomeInfoTopBanner {
	String img;
	dynamic route;
	int artId;
	String name;
	int advType;
	dynamic mRoute;
	int id;
	String url;
	dynamic pcRoute;

	DoctorHomeInfoTopBanner({this.img, this.route, this.artId, this.name, this.advType, this.mRoute, this.id, this.url, this.pcRoute});

	DoctorHomeInfoTopBanner.fromJson(Map<String, dynamic> json) {
		img = json['img'];
		route = json['route'];
		artId = json['art_id'];
		name = json['name'];
		advType = json['adv_type'];
		mRoute = json['m_route'];
		id = json['id'];
		url = json['url'];
		pcRoute = json['pc_route'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['img'] = this.img;
		data['route'] = this.route;
		data['art_id'] = this.artId;
		data['name'] = this.name;
		data['adv_type'] = this.advType;
		data['m_route'] = this.mRoute;
		data['id'] = this.id;
		data['url'] = this.url;
		data['pc_route'] = this.pcRoute;
		return data;
	}
}

class DoctorHomeInfoVideoList {
	String image;
	int pv;
	int id;
	String title;

	DoctorHomeInfoVideoList({this.image, this.pv, this.id, this.title});

	DoctorHomeInfoVideoList.fromJson(Map<String, dynamic> json) {
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
