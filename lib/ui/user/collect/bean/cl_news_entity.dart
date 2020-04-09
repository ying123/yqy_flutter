class ClNewsEntity {
	String msg;
	int code;
	List<ClNewsInfo> info;

	ClNewsEntity({this.msg, this.code, this.info});

	ClNewsEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['info'] != null) {
			info = new List<ClNewsInfo>();(json['info'] as List).forEach((v) { info.add(new ClNewsInfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ClNewsInfo {
	String image;
	ClNewsInfoMedical medical;
	String createTime;
	int userId;
	int num;
	int dataFlag;
	int id;
	int otherId;

	ClNewsInfo({this.image, this.medical, this.createTime, this.userId, this.num, this.dataFlag, this.id, this.otherId});

	ClNewsInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		medical = json['medical'] != null ? new ClNewsInfoMedical.fromJson(json['medical']) : null;
		createTime = json['create_time'];
		userId = json['user_id'];
		num = json['num'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		otherId = json['other_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		if (this.medical != null) {
      data['medical'] = this.medical.toJson();
    }
		data['create_time'] = this.createTime;
		data['user_id'] = this.userId;
		data['num'] = this.num;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['other_id'] = this.otherId;
		return data;
	}
}

class ClNewsInfoMedical {
	String image;
	int pv;
	dynamic author;
	int id;
	String title;

	ClNewsInfoMedical({this.image, this.pv, this.author, this.id, this.title});

	ClNewsInfoMedical.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		pv = json['pv'];
		author = json['author'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['pv'] = this.pv;
		data['author'] = this.author;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
