class HomeIndexEntity {
	String msg;
	int code;
	HomeIndexInfo info;

	HomeIndexEntity({this.msg, this.code, this.info});

	HomeIndexEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new HomeIndexInfo.fromJson(json['info']) : null;
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

class HomeIndexInfo {
	List<HomeIndexInfoNewsList> newsList;
	List<HomeIndexInfoBannerList> bannerList;
	List<HomeIndexInfoHotVideo> hotVideo;
	List<HomeIndexInfoRecomDoctor> recomDoctor;

	HomeIndexInfo({this.newsList, this.bannerList, this.hotVideo, this.recomDoctor});

	HomeIndexInfo.fromJson(Map<String, dynamic> json) {
		if (json['news_list'] != null) {
			newsList = new List<HomeIndexInfoNewsList>();(json['news_list'] as List).forEach((v) { newsList.add(new HomeIndexInfoNewsList.fromJson(v)); });
		}
		if (json['banner_list'] != null) {
			bannerList = new List<HomeIndexInfoBannerList>();(json['banner_list'] as List).forEach((v) { bannerList.add(new HomeIndexInfoBannerList.fromJson(v)); });
		}
		if (json['hot_video'] != null) {
			hotVideo = new List<HomeIndexInfoHotVideo>();(json['hot_video'] as List).forEach((v) { hotVideo.add(new HomeIndexInfoHotVideo.fromJson(v)); });
		}
		if (json['recom_doctor'] != null) {
			recomDoctor = new List<HomeIndexInfoRecomDoctor>();(json['recom_doctor'] as List).forEach((v) { recomDoctor.add(new HomeIndexInfoRecomDoctor.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.newsList != null) {
      data['news_list'] =  this.newsList.map((v) => v.toJson()).toList();
    }
		if (this.bannerList != null) {
      data['banner_list'] =  this.bannerList.map((v) => v.toJson()).toList();
    }
		if (this.hotVideo != null) {
      data['hot_video'] =  this.hotVideo.map((v) => v.toJson()).toList();
    }
		if (this.recomDoctor != null) {
      data['recom_doctor'] =  this.recomDoctor.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class HomeIndexInfoNewsList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	HomeIndexInfoNewsList({this.image, this.createTime, this.pv, this.id, this.title});

	HomeIndexInfoNewsList.fromJson(Map<String, dynamic> json) {
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

class HomeIndexInfoBannerList {
	String img;
	String route;
	int artId;
	String name;
	int advType;
	String mRoute;
	int id;
	String url;
	String pcRoute;

	HomeIndexInfoBannerList({this.img, this.route, this.artId, this.name, this.advType, this.mRoute, this.id, this.url, this.pcRoute});

	HomeIndexInfoBannerList.fromJson(Map<String, dynamic> json) {
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

class HomeIndexInfoHotVideo {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	HomeIndexInfoHotVideo({this.image, this.createTime, this.pv, this.id, this.title});

	HomeIndexInfoHotVideo.fromJson(Map<String, dynamic> json) {
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

class HomeIndexInfoRecomDoctor {
	String realName;
	int jId;
	int tIds;
	String recomImage;
	int id;
	HomeIndexInfoRecomDoctorJob job;
	HomeIndexInfoRecomDoctorDeparts departs;

	HomeIndexInfoRecomDoctor({this.realName, this.jId, this.tIds, this.recomImage, this.id, this.job, this.departs});

	HomeIndexInfoRecomDoctor.fromJson(Map<String, dynamic> json) {
		realName = json['realName'];
		jId = json['j_id'];
		tIds = json['t_ids'];
		recomImage = json['recom_image'];
		id = json['id'];
		job = json['job'] != null ? new HomeIndexInfoRecomDoctorJob.fromJson(json['job']) : null;
		departs = json['departs'] != null ? new HomeIndexInfoRecomDoctorDeparts.fromJson(json['departs']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['realName'] = this.realName;
		data['j_id'] = this.jId;
		data['t_ids'] = this.tIds;
		data['recom_image'] = this.recomImage;
		data['id'] = this.id;
		if (this.job != null) {
      data['job'] = this.job.toJson();
    }
		if (this.departs != null) {
      data['departs'] = this.departs.toJson();
    }
		return data;
	}
}

class HomeIndexInfoRecomDoctorJob {
	String name;

	HomeIndexInfoRecomDoctorJob({this.name});

	HomeIndexInfoRecomDoctorJob.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}

class HomeIndexInfoRecomDoctorDeparts {
	String name;

	HomeIndexInfoRecomDoctorDeparts({this.name});

	HomeIndexInfoRecomDoctorDeparts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}
