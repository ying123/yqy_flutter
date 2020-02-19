class TabNewsListsEntity {
	String msg;
	int code;
	TabNewsListsInfo info;

	TabNewsListsEntity({this.msg, this.code, this.info});

	TabNewsListsEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new TabNewsListsInfo.fromJson(json['info']) : null;
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

class TabNewsListsInfo {
	List<TabNewsListsInfoList> lists;

	TabNewsListsInfo({this.lists});

	TabNewsListsInfo.fromJson(Map<String, dynamic> json) {
		if (json['lists'] != null) {
			lists = new List<TabNewsListsInfoList>();(json['lists'] as List).forEach((v) { lists.add(new TabNewsListsInfoList.fromJson(v)); });
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

class TabNewsListsInfoList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	TabNewsListsInfoList({this.image, this.createTime, this.pv, this.id, this.title});

	TabNewsListsInfoList.fromJson(Map<String, dynamic> json) {
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
