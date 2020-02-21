class ShopDetailsEntity {
	String msg;
	int code;
	ShopDetailsInfo info;

	ShopDetailsEntity({this.msg, this.code, this.info});

	ShopDetailsEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new ShopDetailsInfo.fromJson(json['info']) : null;
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

class ShopDetailsInfo {
	String image;
	String createTime;
	String sendWay;
	String closeTime;
	String title;
	String content;
	int isShow;
	String points;
	int id;
	String nums;
	String remarks;
	int cid;
	int status;

	ShopDetailsInfo({this.image, this.createTime, this.sendWay, this.closeTime, this.title, this.content, this.isShow, this.points, this.id, this.nums, this.remarks, this.cid, this.status});

	ShopDetailsInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		createTime = json['create_time'];
		sendWay = json['send_way'];
		closeTime = json['close_time'];
		title = json['title'];
		content = json['content'];
		isShow = json['is_show'];
		points = json['points'];
		id = json['id'];
		nums = json['nums'];
		remarks = json['remarks'];
		cid = json['cid'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['create_time'] = this.createTime;
		data['send_way'] = this.sendWay;
		data['close_time'] = this.closeTime;
		data['title'] = this.title;
		data['content'] = this.content;
		data['is_show'] = this.isShow;
		data['points'] = this.points;
		data['id'] = this.id;
		data['nums'] = this.nums;
		data['remarks'] = this.remarks;
		data['cid'] = this.cid;
		data['status'] = this.status;
		return data;
	}
}
