class GuideInfoEntity {
	String msg;
	int code;
	GuideInfoInfo info;

	GuideInfoEntity({this.msg, this.code, this.info});

	GuideInfoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new GuideInfoInfo.fromJson(json['info']) : null;
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

class GuideInfoInfo {
	String image;
	String createTime;
	dynamic filepath;
	int pv;
	dynamic author;
	int id;
	dynamic source;
	String title;
	int type;
	String content;

	GuideInfoInfo({this.image, this.createTime, this.filepath, this.pv, this.author, this.id, this.source, this.title, this.type, this.content});

	GuideInfoInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		createTime = json['create_time'];
		filepath = json['filepath'];
		pv = json['pv'];
		author = json['author'];
		id = json['id'];
		source = json['source'];
		title = json['title'];
		type = json['type'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['create_time'] = this.createTime;
		data['filepath'] = this.filepath;
		data['pv'] = this.pv;
		data['author'] = this.author;
		data['id'] = this.id;
		data['source'] = this.source;
		data['title'] = this.title;
		data['type'] = this.type;
		data['content'] = this.content;
		return data;
	}
}
