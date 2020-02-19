class CommentListEntity {
	String msg;
	int code;
	CommentListInfo info;

	CommentListEntity({this.msg, this.code, this.info});

	CommentListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new CommentListInfo.fromJson(json['info']) : null;
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

class CommentListInfo {
	List<CommantListInfoLists> lists;

	CommentListInfo({this.lists});

	CommentListInfo.fromJson(Map<String, dynamic> json) {
		if (json['lists'] != null) {
			lists = new List<CommantListInfoLists>();(json['lists'] as List).forEach((v) { lists.add(new CommantListInfoLists.fromJson(v)); });
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

class CommantListInfoLists {
	String createTime;
	int userId;
	String userName;
	int id;
	String userPhoto;
	String content;
	List<CommantListInfoListsChild> child;

	CommantListInfoLists({this.createTime, this.userId, this.userName, this.id, this.userPhoto, this.content, this.child});

	CommantListInfoLists.fromJson(Map<String, dynamic> json) {
		createTime = json['create_time'];
		userId = json['user_id'];
		userName = json['user_name'];
		id = json['id'];
		userPhoto = json['user_photo'];
		content = json['content'];
		if (json['child'] != null) {
			child = new List<CommantListInfoListsChild>();(json['child'] as List).forEach((v) { child.add(new CommantListInfoListsChild.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['create_time'] = this.createTime;
		data['user_id'] = this.userId;
		data['user_name'] = this.userName;
		data['id'] = this.id;
		data['user_photo'] = this.userPhoto;
		data['content'] = this.content;
		if (this.child != null) {
      data['child'] =  this.child.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CommantListInfoListsChild {
	String createTime;
	int userId;
	int id;
	String content;

	CommantListInfoListsChild({this.createTime, this.userId, this.id, this.content});

	CommantListInfoListsChild.fromJson(Map<String, dynamic> json) {
		createTime = json['create_time'];
		userId = json['user_id'];
		id = json['id'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['create_time'] = this.createTime;
		data['user_id'] = this.userId;
		data['id'] = this.id;
		data['content'] = this.content;
		return data;
	}
}
