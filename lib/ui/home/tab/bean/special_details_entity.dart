class SpecialDetailsEntity {
	String msg;
	int code;
	SpecialDetailsInfo info;

	SpecialDetailsEntity({this.msg, this.code, this.info});

	SpecialDetailsEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new SpecialDetailsInfo.fromJson(json['info']) : null;
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

class SpecialDetailsInfo {
	String image;
	String createTime;
	int mid;
	String title;
	int type;
	String content;
	int isShow;
	int isTop;
	List<SpecialDetailsInfoVideoList> videoList;
	dynamic descs;
	int id;
	List<SpecialDetailsInfoArticleList> articleList;
	int status;

	SpecialDetailsInfo({this.image, this.createTime, this.mid, this.title, this.type, this.content, this.isShow, this.isTop, this.videoList, this.descs, this.id, this.articleList, this.status});

	SpecialDetailsInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		createTime = json['create_time'];
		mid = json['mid'];
		title = json['title'];
		type = json['type'];
		content = json['content'];
		isShow = json['is_show'];
		isTop = json['is_top'];
		if (json['video_list'] != null) {
			videoList = new List<SpecialDetailsInfoVideoList>();(json['video_list'] as List).forEach((v) { videoList.add(new SpecialDetailsInfoVideoList.fromJson(v)); });
		}
		descs = json['descs'];
		id = json['id'];
		if (json['article_list'] != null) {
			articleList = new List<SpecialDetailsInfoArticleList>();(json['article_list'] as List).forEach((v) { articleList.add(new SpecialDetailsInfoArticleList.fromJson(v)); });
		}
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['create_time'] = this.createTime;
		data['mid'] = this.mid;
		data['title'] = this.title;
		data['type'] = this.type;
		data['content'] = this.content;
		data['is_show'] = this.isShow;
		data['is_top'] = this.isTop;
		if (this.videoList != null) {
      data['video_list'] =  this.videoList.map((v) => v.toJson()).toList();
    }
		data['descs'] = this.descs;
		data['id'] = this.id;
		if (this.articleList != null) {
      data['article_list'] =  this.articleList.map((v) => v.toJson()).toList();
    }
		data['status'] = this.status;
		return data;
	}
}

class SpecialDetailsInfoVideoList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	SpecialDetailsInfoVideoList({this.image, this.createTime, this.pv, this.id, this.title});

	SpecialDetailsInfoVideoList.fromJson(Map<String, dynamic> json) {
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

class SpecialDetailsInfoArticleList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	SpecialDetailsInfoArticleList({this.image, this.createTime, this.pv, this.id, this.title});

	SpecialDetailsInfoArticleList.fromJson(Map<String, dynamic> json) {
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
