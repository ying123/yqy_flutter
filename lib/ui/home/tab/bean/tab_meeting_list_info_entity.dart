class TabMeetingListInfoEntity {
	String msg;
	int code;
	TabMeetingListInfoInfo info;

	TabMeetingListInfoEntity({this.msg, this.code, this.info});

	TabMeetingListInfoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new TabMeetingListInfoInfo.fromJson(json['info']) : null;
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

class TabMeetingListInfoInfo {
	int isPlay;
	int allowVod;
	int id;
	int nowVideo;
	List<TabMeetingListInfoInfoVideoList> videoLists;

	TabMeetingListInfoInfo({this.isPlay, this.allowVod, this.id, this.nowVideo, this.videoLists});

	TabMeetingListInfoInfo.fromJson(Map<String, dynamic> json) {
		isPlay = json['is_play'];
		allowVod = json['allow_vod'];
		id = json['id'];
		nowVideo = json['now_video'];
		if (json['video_lists'] != null) {
			videoLists = new List<TabMeetingListInfoInfoVideoList>();(json['video_lists'] as List).forEach((v) { videoLists.add(new TabMeetingListInfoInfoVideoList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['is_play'] = this.isPlay;
		data['allow_vod'] = this.allowVod;
		data['id'] = this.id;
		data['now_video'] = this.nowVideo;
		if (this.videoLists != null) {
      data['video_lists'] =  this.videoLists.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class TabMeetingListInfoInfoVideoList {
	int uid;
	String realName;
	String userPhoto;
	int id;
	String title;
	TabMeetingListInfoInfoVideoListsUsers users;

	TabMeetingListInfoInfoVideoList({this.uid, this.realName, this.userPhoto, this.id, this.title, this.users});

	TabMeetingListInfoInfoVideoList.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		realName = json['realName'];
		userPhoto = json['userPhoto'];
		id = json['id'];
		title = json['title'];
		users = json['users'] != null ? new TabMeetingListInfoInfoVideoListsUsers.fromJson(json['users']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['realName'] = this.realName;
		data['userPhoto'] = this.userPhoto;
		data['id'] = this.id;
		data['title'] = this.title;
		if (this.users != null) {
      data['users'] = this.users.toJson();
    }
		return data;
	}
}

class TabMeetingListInfoInfoVideoListsUsers {
	String realName;

	TabMeetingListInfoInfoVideoListsUsers({this.realName});

	TabMeetingListInfoInfoVideoListsUsers.fromJson(Map<String, dynamic> json) {
		realName = json['realName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['realName'] = this.realName;
		return data;
	}
}
