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
	List<VideoPageInfoAd> ad;
	List<VideoPageInfoBannerList> bannerList;
	List<VideoPageInfoVideoList> videoList;

	VideoPageInfo({this.ad, this.bannerList, this.videoList});

	VideoPageInfo.fromJson(Map<String, dynamic> json) {
		if (json['ad'] != null) {
			ad = new List<VideoPageInfoAd>();(json['ad'] as List).forEach((v) { ad.add(new VideoPageInfoAd.fromJson(v)); });
		}
		if (json['banner_list'] != null) {
			bannerList = new List<VideoPageInfoBannerList>();(json['banner_list'] as List).forEach((v) { bannerList.add(new VideoPageInfoBannerList.fromJson(v)); });
		}
		if (json['video_list'] != null) {
			videoList = new List<VideoPageInfoVideoList>();(json['video_list'] as List).forEach((v) { videoList.add(new VideoPageInfoVideoList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.ad != null) {
      data['ad'] =  this.ad.map((v) => v.toJson()).toList();
    }
		if (this.bannerList != null) {
      data['banner_list'] =  this.bannerList.map((v) => v.toJson()).toList();
    }
		if (this.videoList != null) {
      data['video_list'] =  this.videoList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class VideoPageInfoAd {
	String img;
	dynamic route;
	int artId;
	String name;
	int advType;
	dynamic mRoute;
	int id;
	String url;
	dynamic pcRoute;

	VideoPageInfoAd({this.img, this.route, this.artId, this.name, this.advType, this.mRoute, this.id, this.url, this.pcRoute});

	VideoPageInfoAd.fromJson(Map<String, dynamic> json) {
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

class VideoPageInfoBannerList {
	String img;
	dynamic route;
	int artId;
	String name;
	int advType;
	dynamic mRoute;
	int id;
	String url;
	dynamic pcRoute;

	VideoPageInfoBannerList({this.img, this.route, this.artId, this.name, this.advType, this.mRoute, this.id, this.url, this.pcRoute});

	VideoPageInfoBannerList.fromJson(Map<String, dynamic> json) {
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

class VideoPageInfoVideoList {
	String image;
	String createTime;
	int id;
	String title;

	VideoPageInfoVideoList({this.image, this.createTime, this.id, this.title});

	VideoPageInfoVideoList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		createTime = json['create_time'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['create_time'] = this.createTime;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
