class IntegralListEntity {
	String message;
	String status;
	IntegralListInfo info;

	IntegralListEntity({this.message, this.status, this.info});

	IntegralListEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new IntegralListInfo.fromJson(json['info']) : null;
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

class IntegralListInfo {
	IntegralListInfoList xList;

	IntegralListInfo({this.xList});

	IntegralListInfo.fromJson(Map<String, dynamic> json) {
		xList = json['list'] != null ? new IntegralListInfoList.fromJson(json['list']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.xList != null) {
      data['list'] = this.xList.toJson();
    }
		return data;
	}
}

class IntegralListInfoList {
	String perPage;
	String totalPage;
	String currentPage;
	String total;
	List<IntegralListInfoListRow> rows;

	IntegralListInfoList({this.perPage, this.totalPage, this.currentPage, this.total, this.rows});

	IntegralListInfoList.fromJson(Map<String, dynamic> json) {
		perPage = json['PerPage'];
		totalPage = json['TotalPage'];
		currentPage = json['CurrentPage'];
		total = json['Total'];
		if (json['Rows'] != null) {
			rows = new List<IntegralListInfoListRow>();(json['Rows'] as List).forEach((v) { rows.add(new IntegralListInfoListRow.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['PerPage'] = this.perPage;
		data['TotalPage'] = this.totalPage;
		data['CurrentPage'] = this.currentPage;
		data['Total'] = this.total;
		if (this.rows != null) {
      data['Rows'] =  this.rows.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class IntegralListInfoListRow {
	String payType;
	String money;
	String createTime;
	String moneyType;
	String userMoney;
	String id;

	IntegralListInfoListRow({this.payType, this.money, this.createTime, this.moneyType, this.userMoney, this.id});

	IntegralListInfoListRow.fromJson(Map<String, dynamic> json) {
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
