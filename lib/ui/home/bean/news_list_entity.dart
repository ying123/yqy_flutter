class NewsListEntity {
	var page;
	List<NewListList> xList;

	NewsListEntity({this.page, this.xList});

	NewsListEntity.fromJson(Map<String, dynamic> json) {
		page = json['page'];
		if (json['list'] != null) {
			xList = new List<NewListList>();(json['list'] as List).forEach((v) { xList.add(new NewListList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['page'] = this.page;
		if (this.xList != null) {
      data['list'] =  this.xList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class NewListList {
	List<Null> image;
	String createTime;
	String isTop;
	String author;
	String id;
	String source;
	String time;
	String title;
	String content;
	String lawsId;
	String type;
	 String click_id;

	NewListList({this.image, this.createTime, this.isTop, this.author, this.id, this.source, this.time, this.title, this.content,this.lawsId,this.type,this.click_id});

	NewListList.fromJson(Map<String, dynamic> json) {
		if (json['image'] != null) {
			image = new List<Null>();
		}
		createTime = json['createTime'];
		isTop = json['isTop'];
		author = json['author'];
		id = json['id'];
		source = json['source'];
		time = json['time'];
		title = json['title'];
		content = json['content'];
		lawsId = json['lawsId'];
		type = json['type'];
		click_id = json['click_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.image != null) {
      data['image'] =  [];
    }
		data['createTime'] = this.createTime;
		data['isTop'] = this.isTop;
		data['author'] = this.author;
		data['id'] = this.id;
		data['source'] = this.source;
		data['time'] = this.time;
		data['title'] = this.title;
		data['content'] = this.content;
		data['lawsId'] = this.lawsId;
		data['type'] = this.type;
		data['click_id'] = this.click_id;
		return data;
	}
}
