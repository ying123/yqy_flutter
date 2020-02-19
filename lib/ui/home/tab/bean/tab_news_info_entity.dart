class TabNewsInfoEntity {
	String msg;
	int code;
	TabNewsInfoInfo info;

	TabNewsInfoEntity({this.msg, this.code, this.info});

	TabNewsInfoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new TabNewsInfoInfo.fromJson(json['info']) : null;
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

class TabNewsInfoInfo {
	String image;
	String createTime;
	int cateId;
	String author;
	int pv;
	int id;
	String source;
	String title;
	String content;

	TabNewsInfoInfo({this.image, this.createTime, this.cateId, this.author, this.pv, this.id, this.source, this.title, this.content});

	TabNewsInfoInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		createTime = json['create_time'];
		cateId = json['cateId'];
		author = json['author'];
		pv = json['pv'];
		id = json['id'];
		source = json['source'];
		title = json['title'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['create_time'] = this.createTime;
		data['cateId'] = this.cateId;
		data['author'] = this.author;
		data['pv'] = this.pv;
		data['id'] = this.id;
		data['source'] = this.source;
		data['title'] = this.title;
		data['content'] = this.content;
		return data;
	}
}
