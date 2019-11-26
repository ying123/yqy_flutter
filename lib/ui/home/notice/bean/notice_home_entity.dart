class NoticeHomeEntity {
	List<NoticeHomeList> list ;
	var page;

	NoticeHomeEntity({this.list , this.page});

	NoticeHomeEntity.fromJson(Map<String, dynamic> json) {
		if (json['list '] != null) {
			list  = new List<NoticeHomeList>();(json['list '] as List).forEach((v) { list .add(new NoticeHomeList.fromJson(v)); });
		}
		page = json['page'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.list  != null) {
      data['list '] =  this.list .map((v) => v.toJson()).toList();
    }
		data['page'] = this.page;
		return data;
	}
}

class NoticeHomeList {
	String msgContent;
	String createTime;
	String id;
	String title;
	String msgStatus;

	NoticeHomeList({this.msgContent, this.createTime, this.id, this.title, this.msgStatus});

	NoticeHomeList.fromJson(Map<String, dynamic> json) {
		msgContent = json['msgContent'];
		createTime = json['createTime'];
		id = json['id'];
		title = json['title'];
		msgStatus = json['msgStatus'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msgContent'] = this.msgContent;
		data['createTime'] = this.createTime;
		data['id'] = this.id;
		data['title'] = this.title;
		data['msgStatus'] = this.msgStatus;
		return data;
	}
}
