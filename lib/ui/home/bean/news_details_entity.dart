class NewsDetailsEntity {
	var ifCollect;
	String createTime;
  var cateId;
  var isTop;
	String author;
  var dataFlag;
  var id;
	String source;
	String title;
	String content;
  var isShow;

	NewsDetailsEntity({this.ifCollect, this.createTime, this.cateId, this.isTop, this.author, this.dataFlag, this.id, this.source, this.title, this.content, this.isShow});

	NewsDetailsEntity.fromJson(Map<String, dynamic> json) {
		ifCollect = json['ifCollect'];
		createTime = json['createTime'];
		cateId = json['cateId'];
		isTop = json['isTop'];
		author = json['author'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		source = json['source'];
		title = json['title'];
		content = json['content'];
		isShow = json['isShow'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['ifCollect'] = this.ifCollect;
		data['createTime'] = this.createTime;
		data['cateId'] = this.cateId;
		data['isTop'] = this.isTop;
		data['author'] = this.author;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['source'] = this.source;
		data['title'] = this.title;
		data['content'] = this.content;
		data['isShow'] = this.isShow;
		return data;
	}
}
