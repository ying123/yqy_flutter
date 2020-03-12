class TabLiveEntity {
	String msg;
	int code;
	TabLiveInfo info;

	TabLiveEntity({this.msg, this.code, this.info});

	TabLiveEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new TabLiveInfo.fromJson(json['info']) : null;
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

class TabLiveInfo {
	List<TabLiveInfoHistoryList> historyList;
	List<TabLiveInfoBannerList> bannerList;
	List<TabLiveInfoMyOrder> myOrder;
	List<TabLiveInfoOrderList> orderList;

	TabLiveInfo({this.historyList, this.bannerList, this.myOrder, this.orderList});

	TabLiveInfo.fromJson(Map<String, dynamic> json) {
		if (json['history_list'] != null) {
			historyList = new List<TabLiveInfoHistoryList>();(json['history_list'] as List).forEach((v) { historyList.add(new TabLiveInfoHistoryList.fromJson(v)); });
		}
		if (json['banner_list'] != null) {
			bannerList = new List<TabLiveInfoBannerList>();(json['banner_list'] as List).forEach((v) { bannerList.add(new TabLiveInfoBannerList.fromJson(v)); });
		}
		if (json['my_order'] != null) {
			myOrder = new List<TabLiveInfoMyOrder>();(json['my_order'] as List).forEach((v) { myOrder.add(new TabLiveInfoMyOrder.fromJson(v)); });
		}
		if (json['order_list'] != null) {
			orderList = new List<TabLiveInfoOrderList>();(json['order_list'] as List).forEach((v) { orderList.add(new TabLiveInfoOrderList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.historyList != null) {
      data['history_list'] =  this.historyList.map((v) => v.toJson()).toList();
    }
		if (this.bannerList != null) {
      data['banner_list'] =  this.bannerList.map((v) => v.toJson()).toList();
    }
		if (this.myOrder != null) {
      data['my_order'] =  this.myOrder.map((v) => v.toJson()).toList();
    }
		if (this.orderList != null) {
      data['order_list'] =  this.orderList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class TabLiveInfoHistoryList {
	String image;
	String startTime;
	int id;
	String title;
	List<Null> authors;

	TabLiveInfoHistoryList({this.image, this.startTime, this.id, this.title, this.authors});

	TabLiveInfoHistoryList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		startTime = json['start_time'];
		id = json['id'];
		title = json['title'];
		if (json['authors'] != null) {
			authors = new List<Null>();
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['start_time'] = this.startTime;
		data['id'] = this.id;
		data['title'] = this.title;
		if (this.authors != null) {
      data['authors'] =  [];
    }
		return data;
	}
}

class TabLiveInfoBannerList {
	String image;
	int startTime;
	int id;
	String title;

	TabLiveInfoBannerList({this.image, this.startTime, this.id, this.title});

	TabLiveInfoBannerList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		startTime = json['start_time'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['start_time'] = this.startTime;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}

class TabLiveInfoMyOrder {
	String image;
	int startTime;
	int id;
	String title;

	TabLiveInfoMyOrder({this.image, this.startTime, this.id, this.title});

	TabLiveInfoMyOrder.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		startTime = json['start_time'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['start_time'] = this.startTime;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}

class TabLiveInfoOrderList {
	String image;
	String startTime;
	int id;
	String title;

	TabLiveInfoOrderList({this.image, this.startTime, this.id, this.title});

	TabLiveInfoOrderList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		startTime = json['start_time'];
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['start_time'] = this.startTime;
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
