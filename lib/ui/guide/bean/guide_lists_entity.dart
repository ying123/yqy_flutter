class GuideListsEntity {
	String msg;
	int code;
	GuideListsInfo info;

	GuideListsEntity({this.msg, this.code, this.info});

	GuideListsEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new GuideListsInfo.fromJson(json['info']) : null;
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

class GuideListsInfo {
	List<GuideListsInfoList> lists;

	GuideListsInfo({this.lists});

	GuideListsInfo.fromJson(Map<String, dynamic> json) {
		if (json['lists'] != null) {
			lists = new List<GuideListsInfoList>();(json['lists'] as List).forEach((v) { lists.add(new GuideListsInfoList.fromJson(v)); });
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

class GuideListsInfoList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	GuideListsInfoList({this.image, this.createTime, this.pv, this.id, this.title});

	GuideListsInfoList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		createTime = json['create_time'];
		pv = json['pv'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['create_time'] = this.createTime;
		data['pv'] = this.pv;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
