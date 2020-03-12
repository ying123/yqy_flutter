class LiveEntity {
	String msg;
	int code;
	LiveInfo info;

	LiveEntity({this.msg, this.code, this.info});

	LiveEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new LiveInfo.fromJson(json['info']) : null;
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

class LiveInfo {
	List<Null> keywords;
	LiveInfoCity city;
	int pv;
	int cityId;
	String title;
	String content;
	int points;
	LiveInfoPlayurl playUrl;
	int isPlay;
	int id;
	List<LiveInfoMeeting> meeting;
	String image;
	String address;
	String createTime;
	List<LiveInfoRecommandMeeting> recommendMeeting;
	String introduce;
	String endTime;
	int nowPlay;
	int dataFlag;
	LiveInfoPro pro;
	int provinceId;
	int isShow;
	String startTime;
	int isTop;
	List<LiveInfoAuthor> authors;

	LiveInfo({this.keywords, this.city, this.pv, this.cityId, this.title, this.content, this.points, this.playUrl, this.isPlay, this.id, this.meeting, this.image, this.address, this.createTime, this.recommendMeeting, this.introduce, this.endTime, this.nowPlay, this.dataFlag, this.pro, this.provinceId, this.isShow, this.startTime, this.isTop, this.authors});

	LiveInfo.fromJson(Map<String, dynamic> json) {
		if (json['keywords'] != null) {
			keywords = new List<Null>();
		}
		city = json['city'] != null ? new LiveInfoCity.fromJson(json['city']) : null;
		pv = json['pv'];
		cityId = json['cityId'];
		title = json['title'];
		content = json['content'];
		points = json['points'];
		playUrl = json['playUrl'] != null ? new LiveInfoPlayurl.fromJson(json['playUrl']) : null;
		isPlay = json['isPlay'];
		id = json['id'];
		if (json['meeting'] != null) {
			meeting = new List<LiveInfoMeeting>();(json['meeting'] as List).forEach((v) { meeting.add(new LiveInfoMeeting.fromJson(v)); });
		}
		image = json['image'];
		address = json['address'];
		createTime = json['create_time'];
		if (json['recommend_meeting'] != null) {
			recommendMeeting = new List<LiveInfoRecommandMeeting>();(json['recommend_meeting'] as List).forEach((v) { recommendMeeting.add(new LiveInfoRecommandMeeting.fromJson(v)); });
		}
		introduce = json['introduce'];
		endTime = json['end_time'];
		nowPlay = json['now_play'];
		dataFlag = json['dataFlag'];
		pro = json['pro'] != null ? new LiveInfoPro.fromJson(json['pro']) : null;
		provinceId = json['provinceId'];
		isShow = json['isShow'];
		startTime = json['start_time'];
		isTop = json['isTop'];
		if (json['authors'] != null) {
			authors = new List<LiveInfoAuthor>();(json['authors'] as List).forEach((v) { authors.add(new LiveInfoAuthor.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.keywords != null) {
      data['keywords'] =  [];
    }
		if (this.city != null) {
      data['city'] = this.city.toJson();
    }
		data['pv'] = this.pv;
		data['cityId'] = this.cityId;
		data['title'] = this.title;
		data['content'] = this.content;
		data['points'] = this.points;
		if (this.playUrl != null) {
      data['playUrl'] = this.playUrl.toJson();
    }
		data['isPlay'] = this.isPlay;
		data['id'] = this.id;
		if (this.meeting != null) {
      data['meeting'] =  this.meeting.map((v) => v.toJson()).toList();
    }
		data['image'] = this.image;
		data['address'] = this.address;
		data['create_time'] = this.createTime;
		if (this.recommendMeeting != null) {
      data['recommend_meeting'] =  this.recommendMeeting.map((v) => v.toJson()).toList();
    }
		data['introduce'] = this.introduce;
		data['end_time'] = this.endTime;
		data['now_play'] = this.nowPlay;
		data['dataFlag'] = this.dataFlag;
		if (this.pro != null) {
      data['pro'] = this.pro.toJson();
    }
		data['provinceId'] = this.provinceId;
		data['isShow'] = this.isShow;
		data['start_time'] = this.startTime;
		data['isTop'] = this.isTop;
		if (this.authors != null) {
      data['authors'] =  this.authors.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class LiveInfoCity {
	String areaName;

	LiveInfoCity({this.areaName});

	LiveInfoCity.fromJson(Map<String, dynamic> json) {
		areaName = json['areaName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['areaName'] = this.areaName;
		return data;
	}
}

class LiveInfoPlayurl {
	String sd;
	String ld;
	String hd;
	String ud;

	LiveInfoPlayurl({this.sd, this.ld, this.hd, this.ud});

	LiveInfoPlayurl.fromJson(Map<String, dynamic> json) {
		sd = json['sd'];
		ld = json['ld'];
		hd = json['hd'];
		ud = json['ud'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sd'] = this.sd;
		data['ld'] = this.ld;
		data['hd'] = this.hd;
		data['ud'] = this.ud;
		return data;
	}
}

class LiveInfoMeeting {
	int isPlay;
	int id;
	String title;
	LiveInfoMeetingPlayurl playUrl;

	LiveInfoMeeting({this.isPlay, this.id, this.title, this.playUrl});

	LiveInfoMeeting.fromJson(Map<String, dynamic> json) {
		isPlay = json['is_play'];
		id = json['id'];
		title = json['title'];
	//	playUrl = json['playUrl'] != null ? new LiveInfoMeetingPlayurl.fromJson(json['playUrl']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['is_play'] = this.isPlay;
		data['id'] = this.id;
		data['title'] = this.title;
		if (this.playUrl != null) {
      data['playUrl'] = this.playUrl.toJson();
    }
		return data;
	}
}

class LiveInfoMeetingPlayurl {
	String rtmp;
	String hlsUd;
	String flv;
	String hlsHd;
	String rtmpUd;
	String rtmpSd;
	String hlsLd;
	String rtmpHd;
	String hls;
	String rtmpLd;
	String hlsSd;

	LiveInfoMeetingPlayurl({this.rtmp, this.hlsUd, this.flv, this.hlsHd, this.rtmpUd, this.rtmpSd, this.hlsLd, this.rtmpHd, this.hls, this.rtmpLd, this.hlsSd});

	LiveInfoMeetingPlayurl.fromJson(Map<String, dynamic> json) {
		rtmp = json['rtmp'];
		hlsUd = json['hls_ud'];
		flv = json['flv'];
		hlsHd = json['hls_hd'];
		rtmpUd = json['rtmp_ud'];
		rtmpSd = json['rtmp_sd'];
		hlsLd = json['hls_ld'];
		rtmpHd = json['rtmp_hd'];
		hls = json['hls'];
		rtmpLd = json['rtmp_ld'];
		hlsSd = json['hls_sd'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['rtmp'] = this.rtmp;
		data['hls_ud'] = this.hlsUd;
		data['flv'] = this.flv;
		data['hls_hd'] = this.hlsHd;
		data['rtmp_ud'] = this.rtmpUd;
		data['rtmp_sd'] = this.rtmpSd;
		data['hls_ld'] = this.hlsLd;
		data['rtmp_hd'] = this.rtmpHd;
		data['hls'] = this.hls;
		data['rtmp_ld'] = this.rtmpLd;
		data['hls_sd'] = this.hlsSd;
		return data;
	}
}

class LiveInfoRecommandMeeting {
	String image;
	int startTime;
	int id;
	String title;
	List<LiveInfoRecommandMeetingAuthors> authors;

	LiveInfoRecommandMeeting({this.image, this.startTime, this.id, this.title, this.authors});

	LiveInfoRecommandMeeting.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		startTime = json['start_time'];
		id = json['id'];
		title = json['title'];
		if (json['authors'] != null) {
			authors = new List<LiveInfoRecommandMeetingAuthors>();(json['authors'] as List).forEach((v) { authors.add(new LiveInfoRecommandMeetingAuthors.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['start_time'] = this.startTime;
		data['id'] = this.id;
		data['title'] = this.title;
		if (this.authors != null) {
      data['authors'] =  this.authors.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class LiveInfoRecommandMeetingAuthors {
	String realName;
	String userPhoto;
	int id;

	LiveInfoRecommandMeetingAuthors({this.realName, this.userPhoto, this.id});

	LiveInfoRecommandMeetingAuthors.fromJson(Map<String, dynamic> json) {
		realName = json['realName'];
		userPhoto = json['userPhoto'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['realName'] = this.realName;
		data['userPhoto'] = this.userPhoto;
		data['id'] = this.id;
		return data;
	}
}

class LiveInfoPro {
	String areaName;

	LiveInfoPro({this.areaName});

	LiveInfoPro.fromJson(Map<String, dynamic> json) {
		areaName = json['areaName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['areaName'] = this.areaName;
		return data;
	}
}

class LiveInfoAuthor {
	String realName;
	String userPhoto;
	int id;

	LiveInfoAuthor({this.realName, this.userPhoto, this.id});

	LiveInfoAuthor.fromJson(Map<String, dynamic> json) {
		realName = json['realName'];
		userPhoto = json['userPhoto'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['realName'] = this.realName;
		data['userPhoto'] = this.userPhoto;
		data['id'] = this.id;
		return data;
	}
}
