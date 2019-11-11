class IntegralDetailsEntity {
	IntegralDetailsList xList;

	IntegralDetailsEntity({this.xList});

	IntegralDetailsEntity.fromJson(Map<String, dynamic> json) {
		xList = json['list'] != null ? new IntegralDetailsList.fromJson(json['list']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.xList != null) {
      data['list'] = this.xList.toJson();
    }
		return data;
	}
}

class IntegralDetailsList {
	String payType;
	String money;
	String tradeNo;
	String createTime;
	String moneyType;
	String userMoney;
	String remark;
	String id;

	IntegralDetailsList({this.payType, this.money, this.tradeNo, this.createTime, this.moneyType, this.userMoney, this.remark, this.id});

	IntegralDetailsList.fromJson(Map<String, dynamic> json) {
		payType = json['payType'];
		money = json['money'];
		tradeNo = json['tradeNo'];
		createTime = json['createTime'];
		moneyType = json['moneyType'];
		userMoney = json['userMoney'];
		remark = json['remark'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['payType'] = this.payType;
		data['money'] = this.money;
		data['tradeNo'] = this.tradeNo;
		data['createTime'] = this.createTime;
		data['moneyType'] = this.moneyType;
		data['userMoney'] = this.userMoney;
		data['remark'] = this.remark;
		data['id'] = this.id;
		return data;
	}
}
