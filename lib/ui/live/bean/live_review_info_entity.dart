import 'package:yqy_flutter/ui/live/bean/live_entity.dart';

class LiveReviewInfoEntity {
	String msg;
	int code;
	LiveReviewInfoInfo info;

	LiveReviewInfoEntity({this.msg, this.code, this.info});

	LiveReviewInfoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new LiveReviewInfoInfo.fromJson(json['info']) : null;
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

class LiveReviewInfoInfo {
	String area;
	String image;
	List<Null> keywords;
	String createTime;
	List<LiveReviewInfoInfoRecommandMeeting> recommendMeeting;
	String introduce;
	int pv;
	String endTime;
	int dataFlag;
	dynamic cityId;
	String title;
	dynamic provinceId;
	String content;
	int isShow;
	int points;
	List<LiveReviewInfoInfoVideoList> videoList;
	String startTime;
	int isTop;
	List<LiveReviewInfoInfoMeetList> meetList;
	int isPlay;
	int id;
	List<LiveReviewInfoInfoAuthor> authors;

	LiveReviewInfoInfo({this.area, this.image, this.keywords, this.createTime, this.recommendMeeting, this.introduce, this.pv, this.endTime, this.dataFlag, this.cityId, this.title, this.provinceId, this.content, this.isShow, this.points, this.videoList, this.startTime, this.isTop, this.meetList, this.isPlay, this.id, this.authors});

	LiveReviewInfoInfo.fromJson(Map<String, dynamic> json) {
		area = json['area'];
		image = json['image'];
		if (json['keywords'] != null) {
			keywords = new List<Null>();
		}
		createTime = json['create_time'];
		if (json['recommend_meeting'] != null) {
			recommendMeeting = new List<LiveReviewInfoInfoRecommandMeeting>();(json['recommend_meeting'] as List).forEach((v) { recommendMeeting.add(new LiveReviewInfoInfoRecommandMeeting.fromJson(v)); });
		}
		introduce = json['introduce'];
		pv = json['pv'];
		endTime = json['end_time'];
		dataFlag = json['dataFlag'];
		cityId = json['cityId'];
		title = json['title'];
		provinceId = json['provinceId'];
		content = json['content'];
		isShow = json['isShow'];
		points = json['points'];
		if (json['video_list'] != null) {
			videoList = new List<LiveReviewInfoInfoVideoList>();(json['video_list'] as List).forEach((v) { videoList.add(new LiveReviewInfoInfoVideoList.fromJson(v)); });
		}
		startTime = json['start_time'];
		isTop = json['isTop'];
		if (json['meet_list'] != null) {
			meetList = new List<LiveReviewInfoInfoMeetList>();(json['meet_list'] as List).forEach((v) { meetList.add(new LiveReviewInfoInfoMeetList.fromJson(v)); });
		}
		isPlay = json['isPlay'];
		id = json['id'];
		if (json['authors'] != null) {
			authors = new List<LiveReviewInfoInfoAuthor>();(json['authors'] as List).forEach((v) { authors.add(new LiveReviewInfoInfoAuthor.fromJson(v)); });
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
		data['end_time'] = this.endTime;
		data['dataFlag'] = this.dataFlag;
		data['cityId'] = this.cityId;
		data['title'] = this.title;
		data['provinceId'] = this.provinceId;
		data['content'] = this.content;
		data['isShow'] = this.isShow;
		data['points'] = this.points;
		if (this.videoList != null) {
      data['video_list'] =  this.videoList.map((v) => v.toJson()).toList();
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

class LiveReviewInfoInfoRecommandMeeting {
	String image;
	int startTime;
	int id;
	String title;
	List<LiveInfoRecommandMeetingAuthors> authors;

	LiveReviewInfoInfoRecommandMeeting({this.image, this.startTime, this.id, this.title, this.authors});

	LiveReviewInfoInfoRecommandMeeting.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		startTime = json['start_time'];
		id = json['id'];
		title = json['title'];
		if (json['authors'] != null) {
			authors = new List<Null>();
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['start_time'] = this.startTime;
		data['id'] = this.id;
		data['title'] = this.title;
		if (this.authors != null) {
      data['authors'] =  [];
    }
		return data;
	}
}

class LiveReviewInfoInfoVideoList {
	int uid;
	String playUrl;
	int id;
	String title;
	LiveReviewInfoInfoVideoListUsers users;
	String videoId;

	LiveReviewInfoInfoVideoList({this.uid, this.playUrl, this.id, this.title, this.users, this.videoId});

	LiveReviewInfoInfoVideoList.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		playUrl = json['play_url'];
		id = json['id'];
		title = json['title'];
		users = json['users'] != null ? new LiveReviewInfoInfoVideoListUsers.fromJson(json['users']) : null;
		videoId = json['video_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['play_url'] = this.playUrl;
		data['id'] = this.id;
		data['title'] = this.title;
		if (this.users != null) {
      data['users'] = this.users.toJson();
    }
		data['video_id'] = this.videoId;
		return data;
	}
}

class LiveReviewInfoInfoVideoListUsers {
	String realName;
	String userPhoto;
	int id;

	LiveReviewInfoInfoVideoListUsers({this.realName, this.userPhoto, this.id});

	LiveReviewInfoInfoVideoListUsers.fromJson(Map<String, dynamic> json) {
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

class LiveReviewInfoInfoMeetList {
	int id;
	String title;

	LiveReviewInfoInfoMeetList({this.id, this.title});

	LiveReviewInfoInfoMeetList.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}

class LiveReviewInfoInfoAuthor {
	String realName;
	String userPhoto;
	int id;

	LiveReviewInfoInfoAuthor({this.realName, this.userPhoto, this.id});

	LiveReviewInfoInfoAuthor.fromJson(Map<String, dynamic> json) {
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
