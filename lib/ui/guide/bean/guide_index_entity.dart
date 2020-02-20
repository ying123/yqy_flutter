class GuideIndexEntity {
	String msg;
	int code;
	GuideIndexInfo info;

	GuideIndexEntity({this.msg, this.code, this.info});

	GuideIndexEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new GuideIndexInfo.fromJson(json['info']) : null;
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

class GuideIndexInfo {
	List<GuideIndexInfoArticleList> articleList;
	List<GuideIndexInfoCateList> cateList;

	GuideIndexInfo({this.articleList, this.cateList});

	GuideIndexInfo.fromJson(Map<String, dynamic> json) {
		if (json['article_list'] != null) {
			articleList = new List<GuideIndexInfoArticleList>();(json['article_list'] as List).forEach((v) { articleList.add(new GuideIndexInfoArticleList.fromJson(v)); });
		}
		if (json['cate_list'] != null) {
			cateList = new List<GuideIndexInfoCateList>();(json['cate_list'] as List).forEach((v) { cateList.add(new GuideIndexInfoCateList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.articleList != null) {
      data['article_list'] =  this.articleList.map((v) => v.toJson()).toList();
    }
		if (this.cateList != null) {
      data['cate_list'] =  this.cateList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class GuideIndexInfoArticleList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	GuideIndexInfoArticleList({this.image, this.createTime, this.pv, this.id, this.title});

	GuideIndexInfoArticleList.fromJson(Map<String, dynamic> json) {
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

class GuideIndexInfoCateList {
	int fid;
	String image;
	String name;
	int id;

	GuideIndexInfoCateList({this.fid, this.image, this.name, this.id});

	GuideIndexInfoCateList.fromJson(Map<String, dynamic> json) {
		fid = json['fid'];
		image = json['image'];
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['fid'] = this.fid;
		data['image'] = this.image;
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
