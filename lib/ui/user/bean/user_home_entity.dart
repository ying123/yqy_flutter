class UserHomeEntity {
	String msg;
	int code;
	UserHomeInfo info;

	UserHomeEntity({this.msg, this.code, this.info});

	UserHomeEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new UserHomeInfo.fromJson(json['info']) : null;
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

class UserHomeInfo {
	String realName;
	String userInfo;
	int fabu;
	String userPhoto;
	int userInfoStatus;
	int id;
	List<Null> watchNode;
	int follow;
	int collect;
	int fen;

	UserHomeInfo({this.realName, this.userInfo, this.fabu, this.userPhoto, this.userInfoStatus, this.id, this.watchNode, this.follow, this.collect, this.fen});

	UserHomeInfo.fromJson(Map<String, dynamic> json) {
		realName = json['realName'];
		userInfo = json['userInfo'];
		fabu = json['fabu'];
		userPhoto = json['userPhoto'];
		userInfoStatus = json['userInfoStatus'];
		id = json['id'];
		if (json['watch_node'] != null) {
			watchNode = new List<Null>();
		}
		follow = json['follow'];
		collect = json['collect'];
		fen = json['fen'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['realName'] = this.realName;
		data['userInfo'] = this.userInfo;
		data['fabu'] = this.fabu;
		data['userPhoto'] = this.userPhoto;
		data['userInfoStatus'] = this.userInfoStatus;
		data['id'] = this.id;
		if (this.watchNode != null) {
      data['watch_node'] =  [];
    }
		data['follow'] = this.follow;
		data['collect'] = this.collect;
		data['fen'] = this.fen;
		return data;
	}
}
