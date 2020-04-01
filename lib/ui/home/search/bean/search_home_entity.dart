class SearchHomeEntity {
	String msg;
	int code;
	SearchHomeInfo info;

	SearchHomeEntity({this.msg, this.code, this.info});

	SearchHomeEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new SearchHomeInfo.fromJson(json['info']) : null;
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


class SearchHomeInfo {
	List<SearchHomeInfoNewsList> newsList;
	String kwd;
	List<SearchHomeInfoDocumantList> documentList;
	List<SearchHomeInfoVideoList> videoList;

	SearchHomeInfo({this.newsList, this.kwd, this.documentList, this.videoList});

	SearchHomeInfo.fromJson(Map<String, dynamic> json) {
		if (json['news_list'] != null) {
			newsList = new List<SearchHomeInfoNewsList>();(json['news_list'] as List).forEach((v) { newsList.add(new SearchHomeInfoNewsList.fromJson(v)); });
		}
		kwd = json['kwd'];
		if (json['document_list'] != null) {
			documentList = new List<SearchHomeInfoDocumantList>();(json['document_list'] as List).forEach((v) { documentList.add(new SearchHomeInfoDocumantList.fromJson(v)); });
		}
		if (json['video_list'] != null) {
			videoList = new List<SearchHomeInfoVideoList>();(json['video_list'] as List).forEach((v) { videoList.add(new SearchHomeInfoVideoList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.newsList != null) {
      data['news_list'] =  this.newsList.map((v) => v.toJson()).toList();
    }
		data['kwd'] = this.kwd;
		if (this.documentList != null) {
      data['document_list'] =  this.documentList.map((v) => v.toJson()).toList();
    }
		if (this.videoList != null) {
      data['video_list'] =  this.videoList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SearchHomeInfoNewsList {
	String image;
	String createTime;
	var pv;
	int id;
	String title;

	SearchHomeInfoNewsList({this.image, this.createTime, this.pv, this.id, this.title});

	SearchHomeInfoNewsList.fromJson(Map<String, dynamic> json) {
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

class SearchHomeInfoDocumantList {
	dynamic createTime;
	var pv;
	int id;
	String title;

	SearchHomeInfoDocumantList({this.createTime, this.pv, this.id, this.title});

	SearchHomeInfoDocumantList.fromJson(Map<String, dynamic> json) {
		createTime = json['create_time'];
		pv = json['pv'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['create_time'] = this.createTime;
		data['pv'] = this.pv;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}

class SearchHomeInfoVideoList {
	String image;
	String createTime;
	var pv;
	int id;
	String title;

	SearchHomeInfoVideoList({this.image, this.createTime, this.pv, this.id, this.title});

	SearchHomeInfoVideoList.fromJson(Map<String, dynamic> json) {
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
