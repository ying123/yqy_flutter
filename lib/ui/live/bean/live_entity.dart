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
	List<String> keywords;
	LiveInfoCity city;
	int pv;
	int cityId;
	String title;
	String content;
	String playUrl;
	int points;
	int youinshCateId;
	int isPlay;
	String startTime;
	int id;
	List<LiveInfoMeeting> meeting;
	String image;
	int courseId;
	String address;
	List<LiveInfoRecommandMeeting> recommendMeeting;
	String introduce;
	String author;
	String endTime;
	int dataFlag;
	LiveInfoPro pro;
	int provinceId;
	int isShow;
	String startTimeX;
	String createTime;
	int isTop;
	String endTimeX;
	List<LiveInfoAuthor> authors;

	LiveInfo({this.keywords, this.city, this.pv, this.cityId, this.title, this.content, this.playUrl, this.points, this.youinshCateId, this.isPlay, this.startTime, this.id, this.meeting, this.image, this.courseId, this.address, this.recommendMeeting, this.introduce, this.author, this.endTime, this.dataFlag, this.pro, this.provinceId, this.isShow, this.startTimeX, this.createTime, this.isTop, this.endTimeX, this.authors});

	LiveInfo.fromJson(Map<String, dynamic> json) {
		keywords = json['keywords']?.cast<String>();
		city = json['city'] != null ? new LiveInfoCity.fromJson(json['city']) : null;
		pv = json['pv'];
		cityId = json['cityId'];
		title = json['title'];
		content = json['content'];
		playUrl = json['playUrl'];
		points = json['points'];
		youinshCateId = json['youinshCateId'];
		isPlay = json['isPlay'];
		startTime = json['startTime'];
		id = json['id'];
		if (json['meeting'] != null) {
			meeting = new List<LiveInfoMeeting>();(json['meeting'] as List).forEach((v) { meeting.add(new LiveInfoMeeting.fromJson(v)); });
		}
		image = json['image'];
		courseId = json['course_id'];
		address = json['address'];
		if (json['recommend_meeting'] != null) {
			recommendMeeting = new List<LiveInfoRecommandMeeting>();(json['recommend_meeting'] as List).forEach((v) { recommendMeeting.add(new LiveInfoRecommandMeeting.fromJson(v)); });
		}
		introduce = json['introduce'];
		author = json['author'];
		endTime = json['end_time'];
		dataFlag = json['dataFlag'];
		pro = json['pro'] != null ? new LiveInfoPro.fromJson(json['pro']) : null;
		provinceId = json['provinceId'];
		isShow = json['isShow'];
		startTimeX = json['start_time'];
		createTime = json['createTime'];
		isTop = json['isTop'];
		endTimeX = json['endTime'];
		if (json['authors'] != null) {
			authors = new List<LiveInfoAuthor>();(json['authors'] as List).forEach((v) { authors.add(new LiveInfoAuthor.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['keywords'] = this.keywords;
		if (this.city != null) {
      data['city'] = this.city.toJson();
    }
		data['pv'] = this.pv;
		data['cityId'] = this.cityId;
		data['title'] = this.title;
		data['content'] = this.content;
		data['playUrl'] = this.playUrl;
		data['points'] = this.points;
		data['youinshCateId'] = this.youinshCateId;
		data['isPlay'] = this.isPlay;
		data['startTime'] = this.startTime;
		data['id'] = this.id;
		if (this.meeting != null) {
      data['meeting'] =  this.meeting.map((v) => v.toJson()).toList();
    }
		data['image'] = this.image;
		data['course_id'] = this.courseId;
		data['address'] = this.address;
		if (this.recommendMeeting != null) {
      data['recommend_meeting'] =  this.recommendMeeting.map((v) => v.toJson()).toList();
    }
		data['introduce'] = this.introduce;
		data['author'] = this.author;
		data['end_time'] = this.endTime;
		data['dataFlag'] = this.dataFlag;
		if (this.pro != null) {
      data['pro'] = this.pro.toJson();
    }
		data['provinceId'] = this.provinceId;
		data['isShow'] = this.isShow;
		data['start_time'] = this.startTime;
		data['createTime'] = this.createTime;
		data['isTop'] = this.isTop;
		data['endTime'] = this.endTime;
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

class LiveInfoMeeting {
	int isPlay;
	int id;
	String title;
	var playUrl;

	LiveInfoMeeting({this.isPlay, this.id, this.title, this.playUrl});

	LiveInfoMeeting.fromJson(Map<String, dynamic> json) {
		isPlay = json['is_play'];
		id = json['id'];
		title = json['title'];
		playUrl = json['playUrl'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['is_play'] = this.isPlay;
		data['id'] = this.id;
		data['title'] = this.title;
		data['playUrl'] = this.playUrl;
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
