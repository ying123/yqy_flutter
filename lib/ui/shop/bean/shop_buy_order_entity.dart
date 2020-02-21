class ShopBuyOrderEntity {
	String msg;
	int code;
	ShopBuyOrderInfo info;

	ShopBuyOrderEntity({this.msg, this.code, this.info});

	ShopBuyOrderEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new ShopBuyOrderInfo.fromJson(json['info']) : null;
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

class ShopBuyOrderInfo {
	String image;
	ShopBuyOrderInfoAddress address;
	String createTime;
	dynamic sendWay;
	String closeTime;
	String title;
	String content;
	int isShow;
	String points;
	int id;
	String nums;
	dynamic remarks;
	int cid;
	int status;

	ShopBuyOrderInfo({this.image, this.address, this.createTime, this.sendWay, this.closeTime, this.title, this.content, this.isShow, this.points, this.id, this.nums, this.remarks, this.cid, this.status});

	ShopBuyOrderInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		address = json['address'] != null ? new ShopBuyOrderInfoAddress.fromJson(json['address']) : null;
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
		if (this.address != null) {
      data['address'] = this.address.toJson();
    }
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

class ShopBuyOrderInfoAddress {
	String area;
	String address;
	var proId;
	String city;
	String name;
	String tel;
	var id;
	String pro;
	var areaId;
	var cityId;

	ShopBuyOrderInfoAddress({this.area, this.address, this.proId, this.city, this.name, this.tel, this.id, this.pro, this.areaId, this.cityId});

	ShopBuyOrderInfoAddress.fromJson(Map<String, dynamic> json) {
		area = json['area'];
		address = json['address'];
		proId = json['pro_id'];
		city = json['city'];
		name = json['name'];
		tel = json['tel'];
		id = json['id'];
		pro = json['pro'];
		areaId = json['area_id'];
		cityId = json['city_id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['area'] = this.area;
		data['address'] = this.address;
		data['pro_id'] = this.proId;
		data['city'] = this.city;
		data['name'] = this.name;
		data['tel'] = this.tel;
		data['id'] = this.id;
		data['pro'] = this.pro;
		data['area_id'] = this.areaId;
		data['city_id'] = this.cityId;
		return data;
	}
}
