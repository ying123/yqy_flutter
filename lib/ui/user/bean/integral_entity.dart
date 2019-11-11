class IntegralEntity {
	String message;
	String status;
	IntegralInfo info;

	IntegralEntity({this.message, this.status, this.info});

	IntegralEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new IntegralInfo.fromJson(json['info']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['message'] = this.message;
		data['status'] = this.status;
		if (this.info != null) {
      data['info'] = this.info.toJson();
    }
		return data;
	}
}

class IntegralInfo {
	String userMoney;
	List<IntegralInfoList> xList;

	IntegralInfo({this.userMoney, this.xList});

	IntegralInfo.fromJson(Map<String, dynamic> json) {
		userMoney = json['userMoney'];
		if (json['list'] != null) {
			xList = new List<IntegralInfoList>();(json['list'] as List).forEach((v) { xList.add(new IntegralInfoList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userMoney'] = this.userMoney;
		if (this.xList != null) {
      data['list'] =  this.xList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class IntegralInfoList {
	String payType;
	String money;
	String createTime;
	String moneyType;
	String userMoney;
	String id;

	IntegralInfoList({this.payType, this.money, this.createTime, this.moneyType, this.userMoney, this.id});

	IntegralInfoList.fromJson(Map<String, dynamic> json) {
		payType = json['payType'];
		money = json['money'];
		createTime = json['createTime'];
		moneyType = json['moneyType'];
		userMoney = json['userMoney'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['payType'] = this.payType;
		data['money'] = this.money;
		data['createTime'] = this.createTime;
		data['moneyType'] = this.moneyType;
		data['userMoney'] = this.userMoney;
		data['id'] = this.id;
		return data;
	}
}
