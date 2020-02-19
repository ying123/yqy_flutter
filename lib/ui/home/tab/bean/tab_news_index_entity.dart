class TabNewsIndexEntity {
	String msg;
	int code;
	TabNewsIndexInfo info;

	TabNewsIndexEntity({this.msg, this.code, this.info});

	TabNewsIndexEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new TabNewsIndexInfo.fromJson(json['info']) : null;
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

class TabNewsIndexInfo {
	List<TabNewsIndexInfoAdList> adList;
	List<TabNewsIndexInfoCateList> cateList;
	List<TabNewsIndexInfoNewsList> newsLists;

	TabNewsIndexInfo({this.adList, this.cateList, this.newsLists});

	TabNewsIndexInfo.fromJson(Map<String, dynamic> json) {
		if (json['ad_list'] != null) {
			adList = new List<TabNewsIndexInfoAdList>();(json['ad_list'] as List).forEach((v) { adList.add(new TabNewsIndexInfoAdList.fromJson(v)); });
		}
		if (json['cate_list'] != null) {
			cateList = new List<TabNewsIndexInfoCateList>();(json['cate_list'] as List).forEach((v) { cateList.add(new TabNewsIndexInfoCateList.fromJson(v)); });
		}
		if (json['news_lists'] != null) {
			newsLists = new List<TabNewsIndexInfoNewsList>();(json['news_lists'] as List).forEach((v) { newsLists.add(new TabNewsIndexInfoNewsList.fromJson(v)); });
		}

		if (json['lists'] != null) {
			newsLists = new List<TabNewsIndexInfoNewsList>();(json['lists'] as List).forEach((v) { newsLists.add(new TabNewsIndexInfoNewsList.fromJson(v)); });
		}

	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.adList != null) {
      data['ad_list'] =  this.adList.map((v) => v.toJson()).toList();
    }
		if (this.cateList != null) {
      data['cate_list'] =  this.cateList.map((v) => v.toJson()).toList();
    }
		if (this.newsLists != null) {
      data['news_lists'] =  this.newsLists.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class TabNewsIndexInfoAdList {
	String img;
	int artId;
	String name;
	int advType;
	String mRoute;
	int id;
	String url;
	String pcRoute;

	TabNewsIndexInfoAdList({this.img, this.artId, this.name, this.advType, this.mRoute, this.id, this.url, this.pcRoute});

	TabNewsIndexInfoAdList.fromJson(Map<String, dynamic> json) {
		img = json['img'];
		artId = json['art_id'];
		name = json['name'];
		advType = json['adv_type'];
		mRoute = json['m_route'];
		id = json['id'];
		url = json['url'];
		pcRoute = json['pc_route'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['img'] = this.img;
		data['art_id'] = this.artId;
		data['name'] = this.name;
		data['adv_type'] = this.advType;
		data['m_route'] = this.mRoute;
		data['id'] = this.id;
		data['url'] = this.url;
		data['pc_route'] = this.pcRoute;
		return data;
	}
}

class TabNewsIndexInfoCateList {
	int fid;
	String image;
	String name;
	int id;

	TabNewsIndexInfoCateList({this.fid, this.image, this.name, this.id});

	TabNewsIndexInfoCateList.fromJson(Map<String, dynamic> json) {
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

class TabNewsIndexInfoNewsList {
	String image;
	String createTime;
	int pv;
	int id;
	String title;

	TabNewsIndexInfoNewsList({this.image, this.createTime, this.pv, this.id, this.title});

	TabNewsIndexInfoNewsList.fromJson(Map<String, dynamic> json) {
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
