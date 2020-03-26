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
	String area;
	String image;
	List<Null> keywords;
	String createTime;
	List<LiveInfoRecommandMeeting> recommendMeeting;
	String introduce;
	int pv;
	String endImg;
	String endTime;
	int dataFlag;
	int cityId;
	String title;
	int provinceId;
	String content;
	int isShow;
	int points;
	LiveInfoPlayurl playUrl;
	String startTime;
	int isTop;
	List<LiveInfoMeetList> meetList;
	int isPlay;
	int id;
	List<LiveInfoAuthor> authors;

	LiveInfo({this.area, this.image, this.keywords, this.createTime, this.recommendMeeting, this.introduce, this.pv, this.endImg, this.endTime, this.dataFlag, this.cityId, this.title, this.provinceId, this.content, this.isShow, this.points, this.playUrl, this.startTime, this.isTop, this.meetList, this.isPlay, this.id, this.authors});

	LiveInfo.fromJson(Map<String, dynamic> json) {
		area = json['area'];
		image = json['image'];
		if (json['keywords'] != null) {
			keywords = new List<Null>();
		}
		createTime = json['create_time'];
		if (json['recommend_meeting'] != null) {
			recommendMeeting = new List<LiveInfoRecommandMeeting>();(json['recommend_meeting'] as List).forEach((v) { recommendMeeting.add(new LiveInfoRecommandMeeting.fromJson(v)); });
		}
		introduce = json['introduce'];
		pv = json['pv'];
		endImg = json['end_img'];
		endTime = json['end_time'];
		dataFlag = json['dataFlag'];
		cityId = json['cityId'];
		title = json['title'];
		provinceId = json['provinceId'];
		content = json['content'];
		isShow = json['isShow'];
		points = json['points'];
		playUrl = json['playUrl'] != null ? new LiveInfoPlayurl.fromJson(json['playUrl']) : null;
		startTime = json['start_time'];
		isTop = json['isTop'];
		if (json['meet_list'] != null) {
			meetList = new List<LiveInfoMeetList>();(json['meet_list'] as List).forEach((v) { meetList.add(new LiveInfoMeetList.fromJson(v)); });
		}
		isPlay = json['isPlay'];
		id = json['id'];
		if (json['authors'] != null) {
			authors = new List<LiveInfoAuthor>();(json['authors'] as List).forEach((v) { authors.add(new LiveInfoAuthor.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['area'] = this.area;
		data['image'] = this.image;
		if (this.keywords != null) {
      data['keywords'] =  [];
    }
		data['create_time'] = this.createTime;
		if (this.recommendMeeting != null) {
      data['recommend_meeting'] =  this.recommendMeeting.map((v) => v.toJson()).toList();
    }
		data['introduce'] = this.introduce;
		data['pv'] = this.pv;
		data['end_img'] = this.endImg;
		data['end_time'] = this.endTime;
		data['dataFlag'] = this.dataFlag;
		data['cityId'] = this.cityId;
		data['title'] = this.title;
		data['provinceId'] = this.provinceId;
		data['content'] = this.content;
		data['isShow'] = this.isShow;
		data['points'] = this.points;
		if (this.playUrl != null) {
      data['playUrl'] = this.playUrl.toJson();
    }
		data['start_time'] = this.startTime;
		data['isTop'] = this.isTop;
		if (this.meetList != null) {
      data['meet_list'] =  this.meetList.map((v) => v.toJson()).toList();
    }
		data['isPlay'] = this.isPlay;
		data['id'] = this.id;
		if (this.authors != null) {
      data['authors'] =  this.authors.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class LiveInfoRecommandMeeting {
	String image;
	var startTime;
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

class LiveInfoPlayurl {
	LiveInfoPlayurlRtmp rtmp;
	LiveInfoPlayurlOriginal original;
	LiveInfoPlayurlHls hls;

	LiveInfoPlayurl({this.rtmp, this.original, this.hls});

	LiveInfoPlayurl.fromJson(Map<String, dynamic> json) {
		rtmp = json['rtmp'] != null ? new LiveInfoPlayurlRtmp.fromJson(json['rtmp']) : null;
		original = json['original'] != null ? new LiveInfoPlayurlOriginal.fromJson(json['original']) : null;
		hls = json['hls'] != null ? new LiveInfoPlayurlHls.fromJson(json['hls']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.rtmp != null) {
      data['rtmp'] = this.rtmp.toJson();
    }
		if (this.original != null) {
      data['original'] = this.original.toJson();
    }
		if (this.hls != null) {
      data['hls'] = this.hls.toJson();
    }
		return data;
	}
}

class LiveInfoPlayurlRtmp {
	String sd;
	String ld;
	String hd;
	String ud;

	LiveInfoPlayurlRtmp({this.sd, this.ld, this.hd, this.ud});

	LiveInfoPlayurlRtmp.fromJson(Map<String, dynamic> json) {
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

class LiveInfoPlayurlOriginal {
	String rtmp;
	String flv;
	String hls;

	LiveInfoPlayurlOriginal({this.rtmp, this.flv, this.hls});

	LiveInfoPlayurlOriginal.fromJson(Map<String, dynamic> json) {
		rtmp = json['rtmp'];
		flv = json['flv'];
		hls = json['hls'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['rtmp'] = this.rtmp;
		data['flv'] = this.flv;
		data['hls'] = this.hls;
		return data;
	}
}

class LiveInfoPlayurlHls {
	String sd;
	String ld;
	String hd;
	String ud;

	LiveInfoPlayurlHls({this.sd, this.ld, this.hd, this.ud});

	LiveInfoPlayurlHls.fromJson(Map<String, dynamic> json) {
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

class LiveInfoMeetList {
	int isPlay;
	int id;
	String title;

	LiveInfoMeetList({this.isPlay, this.id, this.title});

	LiveInfoMeetList.fromJson(Map<String, dynamic> json) {
		isPlay = json['is_play'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['is_play'] = this.isPlay;
		data['id'] = this.id;
		data['title'] = this.title;
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
