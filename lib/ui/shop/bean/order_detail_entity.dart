class OrderDetailEntity {
	String msg;
	int code;
	OrderDetailInfo info;

	OrderDetailEntity({this.msg, this.code, this.info});

	OrderDetailEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new OrderDetailInfo.fromJson(json['info']) : null;
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

class OrderDetailInfo {
	int orderStatus;
	int gid;
	OrderDetailInfoAddress address;
	OrderDetailInfoGoods goods;
	int id;
	int nums;
	String points;

	OrderDetailInfo({this.orderStatus, this.gid, this.address, this.goods, this.id, this.nums, this.points});

	OrderDetailInfo.fromJson(Map<String, dynamic> json) {
		orderStatus = json['order_status'];
		gid = json['gid'];
		address = json['address'] != null ? new OrderDetailInfoAddress.fromJson(json['address']) : null;
		goods = json['goods'] != null ? new OrderDetailInfoGoods.fromJson(json['goods']) : null;
		id = json['id'];
		nums = json['nums'];
		points = json['points'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['order_status'] = this.orderStatus;
		data['gid'] = this.gid;
		if (this.address != null) {
      data['address'] = this.address.toJson();
    }
		if (this.goods != null) {
      data['goods'] = this.goods.toJson();
    }
		data['id'] = this.id;
		data['nums'] = this.nums;
		data['points'] = this.points;
		return data;
	}
}

class OrderDetailInfoAddress {
	String address;
	String name;
	String tel;

	OrderDetailInfoAddress({this.address, this.name, this.tel});

	OrderDetailInfoAddress.fromJson(Map<String, dynamic> json) {
		address = json['address'];
		name = json['name'];
		tel = json['tel'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['address'] = this.address;
		data['name'] = this.name;
		data['tel'] = this.tel;
		return data;
	}
}

class OrderDetailInfoGoods {
	String image;
	int id;
	String title;

	OrderDetailInfoGoods({this.image, this.id, this.title});

	OrderDetailInfoGoods.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
