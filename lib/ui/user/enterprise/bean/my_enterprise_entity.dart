class MyEnterpriseEntity {
	int code;
	MyEnterpriseData data;

	MyEnterpriseEntity({this.code, this.data});

	MyEnterpriseEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		data = json['data'] != null ? new MyEnterpriseData.fromJson(json['data']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] = this.data.toJson();
    }
		return data;
	}
}

class MyEnterpriseData {
	List<MyEnterpriseDataMyApply> myApply;
	List<MyEnterpriseDataCompanyList> companyList;
	List<MyEnterpriseDataInvite> invite;

	MyEnterpriseData({this.myApply, this.companyList, this.invite});

	MyEnterpriseData.fromJson(Map<String, dynamic> json) {
		if (json['my_apply'] != null) {
			myApply = new List<MyEnterpriseDataMyApply>();(json['my_apply'] as List).forEach((v) { myApply.add(new MyEnterpriseDataMyApply.fromJson(v)); });
		}
		if (json['company_list'] != null) {
			companyList = new List<MyEnterpriseDataCompanyList>();(json['company_list'] as List).forEach((v) { companyList.add(new MyEnterpriseDataCompanyList.fromJson(v)); });
		}
		if (json['invite'] != null) {
			invite = new List<MyEnterpriseDataInvite>();(json['invite'] as List).forEach((v) { invite.add(new MyEnterpriseDataInvite.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.myApply != null) {
      data['my_apply'] =  this.myApply.map((v) => v.toJson()).toList();
    }
		if (this.companyList != null) {
      data['company_list'] =  this.companyList.map((v) => v.toJson()).toList();
    }
		if (this.invite != null) {
      data['invite'] =  this.invite.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class MyEnterpriseDataMyApply {
	int uid;
	int gid;
	String userPhoto;
	String createTime;
	String userPhone;
	String companyName;
	int dataFlag;
	int id;
	int bid;
	int cid;

	MyEnterpriseDataMyApply({this.uid, this.gid, this.userPhoto, this.createTime, this.userPhone, this.companyName, this.dataFlag, this.id, this.bid, this.cid});

	MyEnterpriseDataMyApply.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		gid = json['gid'];
		userPhoto = json['userPhoto'];
		createTime = json['createTime'];
		userPhone = json['userPhone'];
		companyName = json['company_name'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		bid = json['bid'];
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['gid'] = this.gid;
		data['userPhoto'] = this.userPhoto;
		data['createTime'] = this.createTime;
		data['userPhone'] = this.userPhone;
		data['company_name'] = this.companyName;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['bid'] = this.bid;
		data['cid'] = this.cid;
		return data;
	}
}

class MyEnterpriseDataCompanyList {
	int uid;
	int gid;
	String userPhoto;
	String createTime;
	String groupName;
	String userPhone;
	String branchName;
	String companyName;
	int dataFlag;
	int id;
	int bid;
	int cid;

	MyEnterpriseDataCompanyList({this.uid, this.gid, this.userPhoto, this.createTime, this.groupName, this.userPhone, this.branchName, this.companyName, this.dataFlag, this.id, this.bid, this.cid});

	MyEnterpriseDataCompanyList.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		gid = json['gid'];
		userPhoto = json['userPhoto'];
		createTime = json['createTime'];
		groupName = json['group_name'];
		userPhone = json['userPhone'];
		branchName = json['branch_name'];
		companyName = json['company_name'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		bid = json['bid'];
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['gid'] = this.gid;
		data['userPhoto'] = this.userPhoto;
		data['createTime'] = this.createTime;
		data['group_name'] = this.groupName;
		data['userPhone'] = this.userPhone;
		data['branch_name'] = this.branchName;
		data['company_name'] = this.companyName;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['bid'] = this.bid;
		data['cid'] = this.cid;
		return data;
	}
}

class MyEnterpriseDataInvite {
	int uid;
	int gid;
	String userPhoto;
	String createTime;
	String userPhone;
	String companyName;
	int dataFlag;
	int id;
	int bid;
	int cid;

	MyEnterpriseDataInvite({this.uid, this.gid, this.userPhoto, this.createTime, this.userPhone, this.companyName, this.dataFlag, this.id, this.bid, this.cid});

	MyEnterpriseDataInvite.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		gid = json['gid'];
		userPhoto = json['userPhoto'];
		createTime = json['createTime'];
		userPhone = json['userPhone'];
		companyName = json['company_name'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		bid = json['bid'];
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['gid'] = this.gid;
		data['userPhoto'] = this.userPhoto;
		data['createTime'] = this.createTime;
		data['userPhone'] = this.userPhone;
		data['company_name'] = this.companyName;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['bid'] = this.bid;
		data['cid'] = this.cid;
		return data;
	}
}
