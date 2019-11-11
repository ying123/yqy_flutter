class ShopHomeEntity {
	String message;
	int status;
	List<ShopHomeInfo> info;

	ShopHomeEntity({this.message, this.status, this.info});

	ShopHomeEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		if (json['info'] != null) {
			info = new List<ShopHomeInfo>();(json['info'] as List).forEach((v) { info.add(new ShopHomeInfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['message'] = this.message;
		data['status'] = this.status;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class ShopHomeInfo {
	String image;
	String createTime;
	int id;
	String closeTime;
	String title;
	String content;
	String nums;
	int isShow;
	int cid;
	String points;
	int status;

	ShopHomeInfo({this.image, this.createTime, this.id, this.closeTime, this.title, this.content, this.nums, this.isShow, this.cid, this.points, this.status});

	ShopHomeInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		createTime = json['create_time'];
		id = json['id'];
		closeTime = json['close_time'];
		title = json['title'];
		content = json['content'];
		nums = json['nums'];
		isShow = json['is_show'];
		cid = json['cid'];
		points = json['points'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['create_time'] = this.createTime;
		data['id'] = this.id;
		data['close_time'] = this.closeTime;
		data['title'] = this.title;
		data['content'] = this.content;
		data['nums'] = this.nums;
		data['is_show'] = this.isShow;
		data['cid'] = this.cid;
		data['points'] = this.points;
		data['status'] = this.status;
		return data;
	}
}
