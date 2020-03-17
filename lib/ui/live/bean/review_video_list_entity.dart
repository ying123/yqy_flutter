class ReviewVideoListEntity {
	String msg;
	int code;
	ReviewVideoListInfo info;

	ReviewVideoListEntity({this.msg, this.code, this.info});

	ReviewVideoListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new ReviewVideoListInfo.fromJson(json['info']) : null;
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

class ReviewVideoListInfo {
	List<ReviewVideoListInfoList> lists;

	ReviewVideoListInfo({this.lists});

	ReviewVideoListInfo.fromJson(Map<String, dynamic> json) {
		if (json['lists'] != null) {
			lists = new List<ReviewVideoListInfoList>();(json['lists'] as List).forEach((v) { lists.add(new ReviewVideoListInfoList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.lists != null) {
      data['lists'] =  this.lists.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ReviewVideoListInfoList {
	int uid;
	String playUrl;
	int id;
	String title;
	ReviewVideoListInfoListsUsers users;
	String videoId;

	ReviewVideoListInfoList({this.uid, this.playUrl, this.id, this.title, this.users, this.videoId});

	ReviewVideoListInfoList.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		playUrl = json['play_url'];
		id = json['id'];
		title = json['title'];
		users = json['users'] != null ? new ReviewVideoListInfoListsUsers.fromJson(json['users']) : null;
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

class ReviewVideoListInfoListsUsers {
	String realName;
	String userPhoto;
	int id;

	ReviewVideoListInfoListsUsers({this.realName, this.userPhoto, this.id});

	ReviewVideoListInfoListsUsers.fromJson(Map<String, dynamic> json) {
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
