class TabHomeEntity {
	String msg;
	int code;
	TabHomeInfo info;

	TabHomeEntity({this.msg, this.code, this.info});

	TabHomeEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new TabHomeInfo.fromJson(json['info']) : null;
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

class TabHomeInfo {
	List<TabHomeInfoNewsList> newsList;
	List<TabHomeInfoBannerList> bannerList;
	List<TabHomeInfoHotVideo> hotVideo;
	List<TabHomeInfoRecomDoctor> recomDoctor;

	TabHomeInfo({this.newsList, this.bannerList, this.hotVideo, this.recomDoctor});

	TabHomeInfo.fromJson(Map<String, dynamic> json) {
		if (json['news_list'] != null) {
			newsList = new List<TabHomeInfoNewsList>();(json['news_list'] as List).forEach((v) { newsList.add(new TabHomeInfoNewsList.fromJson(v)); });
		}
		if (json['banner_list'] != null) {
			bannerList = new List<TabHomeInfoBannerList>();(json['banner_list'] as List).forEach((v) { bannerList.add(new TabHomeInfoBannerList.fromJson(v)); });
		}
		if (json['hot_video'] != null) {
			hotVideo = new List<TabHomeInfoHotVideo>();(json['hot_video'] as List).forEach((v) { hotVideo.add(new TabHomeInfoHotVideo.fromJson(v)); });
		}
		if (json['recom_doctor'] != null) {
			recomDoctor = new List<TabHomeInfoRecomDoctor>();(json['recom_doctor'] as List).forEach((v) { recomDoctor.add(new TabHomeInfoRecomDoctor.fromJson(v)); });
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

class TabHomeInfoNewsList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	TabHomeInfoNewsList({this.image, this.createTime, this.pv, this.id, this.title});

	TabHomeInfoNewsList.fromJson(Map<String, dynamic> json) {
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

class TabHomeInfoBannerList {
	String img;
	var route;
	int artId;
	String name;
	int advType;
	String mRoute;
	int id;
	String url;
	String pcRoute;

	TabHomeInfoBannerList({this.img, this.route, this.artId, this.name, this.advType, this.mRoute, this.id, this.url, this.pcRoute});

	TabHomeInfoBannerList.fromJson(Map<String, dynamic> json) {
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

class TabHomeInfoHotVideo {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	TabHomeInfoHotVideo({this.image, this.createTime, this.pv, this.id, this.title});

	TabHomeInfoHotVideo.fromJson(Map<String, dynamic> json) {
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

class TabHomeInfoRecomDoctor {
	String realName;
	int jId;
	int tIds;
	String recomImage;
	int id;
	TabHomeInfoRecomDoctorJob job;
	TabHomeInfoRecomDoctorDeparts departs;

	TabHomeInfoRecomDoctor({this.realName, this.jId, this.tIds, this.recomImage, this.id, this.job, this.departs});

	TabHomeInfoRecomDoctor.fromJson(Map<String, dynamic> json) {
		realName = json['realName'];
		jId = json['j_id'];
		tIds = json['t_ids'];
		recomImage = json['recom_image'];
		id = json['id'];
		job = json['job'] != null ?  json['job'].runtimeType == String?null:new TabHomeInfoRecomDoctorJob.fromJson(json['job']) : null;
		departs = json['departs'] != null ? new TabHomeInfoRecomDoctorDeparts.fromJson(json['departs']) : null;
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

class TabHomeInfoRecomDoctorJob {
	int fid;
	dynamic image;
	String createTime;
	int dataFlag;
	int sort;
	int cityId;
	int type;
	int provinceId;
	int isShow;
	int areaId;
	String createTimeX;
	String name;
	int id;

	TabHomeInfoRecomDoctorJob({this.fid, this.image, this.createTime, this.dataFlag, this.sort, this.cityId, this.type, this.provinceId, this.isShow, this.areaId, this.createTimeX, this.name, this.id});

	TabHomeInfoRecomDoctorJob.fromJson(Map<String, dynamic> json) {



		fid = json['fid'] != null ?json['fid'] : null;
		image = json['image'] != null ?json['image'] : null;
		createTime = json['create_time'] != null ?json['create_time'] : null;
		dataFlag = json['dataFlag'] != null ?json['dataFlag'] : null;
		sort = json['sort'] != null ?json['sort'] : null;
		cityId = json['cityId'] != null ?json['cityId'] : null;
		type = json['type'] != null ?json['type'] : null;
		provinceId = json['provinceId'] != null ?json['provinceId'] : null;
		isShow = json['isShow'] != null ?json['isShow'] : null;
		areaId = json['areaId'] != null ?json['areaId'] : null;
		createTimeX = json['createTime'] != null ?json['createTime'] : null;
		name = json['name'] != null ?json['name'] : null;
		id = json['id'] != null ?json['id'] : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['fid'] = this.fid;
		data['image'] = this.image;
		data['create_time'] = this.createTime;
		data['dataFlag'] = this.dataFlag;
		data['sort'] = this.sort;
		data['cityId'] = this.cityId;
		data['type'] = this.type;
		data['provinceId'] = this.provinceId;
		data['isShow'] = this.isShow;
		data['areaId'] = this.areaId;
		data['createTime'] = this.createTimeX;
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}

class TabHomeInfoRecomDoctorDeparts {
	String name;

	TabHomeInfoRecomDoctorDeparts({this.name});

	TabHomeInfoRecomDoctorDeparts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		return data;
	}
}
