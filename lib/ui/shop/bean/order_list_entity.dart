class OrderListEntity {
	String msg;
	int code;
	OrderListInfo info;

	OrderListEntity({this.msg, this.code, this.info});

	OrderListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new OrderListInfo.fromJson(json['info']) : null;
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

class OrderListInfo {
	List<OrderListInfoList> lists;

	OrderListInfo({this.lists});

	OrderListInfo.fromJson(Map<String, dynamic> json) {
		if (json['lists'] != null) {
			lists = new List<OrderListInfoList>();(json['lists'] as List).forEach((v) { lists.add(new OrderListInfoList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.lists != null) {
      data['lists'] =  this.lists.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class OrderListInfoList {
	int orderStatus;
	int gid;
	OrderListInfoListsGoods goods;
	int id;
	int nums;
	String points;

	OrderListInfoList({this.orderStatus, this.gid, this.goods, this.id, this.nums, this.points});

	OrderListInfoList.fromJson(Map<String, dynamic> json) {
		orderStatus = json['order_status'];
		gid = json['gid'];
		goods = json['goods'] != null ? new OrderListInfoListsGoods.fromJson(json['goods']) : null;
		id = json['id'];
		nums = json['nums'];
		points = json['points'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['order_status'] = this.orderStatus;
		data['gid'] = this.gid;
		if (this.goods != null) {
      data['goods'] = this.goods.toJson();
    }
		data['id'] = this.id;
		data['nums'] = this.nums;
		data['points'] = this.points;
		return data;
	}
}

class OrderListInfoListsGoods {
	String image;
	int id;
	String title;

	OrderListInfoListsGoods({this.image, this.id, this.title});

	OrderListInfoListsGoods.fromJson(Map<String, dynamic> json) {
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
