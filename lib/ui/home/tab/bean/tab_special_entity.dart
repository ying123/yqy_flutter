class TabSpecialEntity {
	String msg;
	int code;
	TabSpecialInfo info;

	TabSpecialEntity({this.msg, this.code, this.info});

	TabSpecialEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new TabSpecialInfo.fromJson(json['info']) : null;
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

class TabSpecialInfo {
	List<TabSpecialInfoTypeList> typeList;

	TabSpecialInfo({this.typeList});

	TabSpecialInfo.fromJson(Map<String, dynamic> json) {
		if (json['type_list'] != null) {
			typeList = new List<TabSpecialInfoTypeList>();(json['type_list'] as List).forEach((v) { typeList.add(new TabSpecialInfoTypeList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.typeList != null) {
      data['type_list'] =  this.typeList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class TabSpecialInfoTypeList {
	List<TabSpecialInfoTypeListList> lists;
	int id;
	String title;

	TabSpecialInfoTypeList({this.lists, this.id, this.title});

	TabSpecialInfoTypeList.fromJson(Map<String, dynamic> json) {
		if (json['lists'] != null) {
			lists = new List<TabSpecialInfoTypeListList>();(json['lists'] as List).forEach((v) { lists.add(new TabSpecialInfoTypeListList.fromJson(v)); });
		}
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.lists != null) {
      data['lists'] =  this.lists.map((v) => v.toJson()).toList();
    }
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}

class TabSpecialInfoTypeListList {
	String image;
	dynamic descs;
	int id;
	String title;

	TabSpecialInfoTypeListList({this.image, this.descs, this.id, this.title});

	TabSpecialInfoTypeListList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		descs = json['descs'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['descs'] = this.descs;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
