class MyEnterpriseEntity {
	String msg;
	int code;
	MyEnterpriseInfo info;

	MyEnterpriseEntity({this.msg, this.code, this.info});

	MyEnterpriseEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new MyEnterpriseInfo.fromJson(json['info']) : null;
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

class MyEnterpriseInfo {
	List<MyEnterpriseInfoMyApply> myApply;
	List<MyEnterpriseInfoCompanyList> companyList;
	List<MyEnterpriseInfoInvite> invite;

	MyEnterpriseInfo({this.myApply, this.companyList, this.invite});

	MyEnterpriseInfo.fromJson(Map<String, dynamic> json) {
		if (json['my_apply'] != null) {
			myApply = new List<MyEnterpriseInfoMyApply>();(json['my_apply'] as List).forEach((v) { myApply.add(new MyEnterpriseInfoMyApply.fromJson(v)); });
		}
		if (json['company_list'] != null) {
			companyList = new List<MyEnterpriseInfoCompanyList>();(json['company_list'] as List).forEach((v) { companyList.add(new MyEnterpriseInfoCompanyList.fromJson(v)); });
		}
		if (json['invite'] != null) {
			invite = new List<MyEnterpriseInfoInvite>();(json['invite'] as List).forEach((v) { invite.add(new MyEnterpriseInfoInvite.fromJson(v)); });
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

class MyEnterpriseInfoMyApply {
	String image;
	String name;
	int id;
	int cid;

	MyEnterpriseInfoMyApply({this.image, this.name, this.id, this.cid});

	MyEnterpriseInfoMyApply.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		name = json['name'];
		id = json['id'];
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['name'] = this.name;
		data['id'] = this.id;
		data['cid'] = this.cid;
		return data;
	}
}

class MyEnterpriseInfoCompanyList {
	String image;
	String name;
	int id;
	int cid;

	MyEnterpriseInfoCompanyList({this.image, this.name, this.id, this.cid});

	MyEnterpriseInfoCompanyList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		name = json['name'];
		id = json['id'];
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['name'] = this.name;
		data['id'] = this.id;
		data['cid'] = this.cid;
		return data;
	}
}

class MyEnterpriseInfoInvite {
	String image;
	String name;
	int id;
	int cid;

	MyEnterpriseInfoInvite({this.image, this.name, this.id, this.cid});

	MyEnterpriseInfoInvite.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		name = json['name'];
		id = json['id'];
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['name'] = this.name;
		data['id'] = this.id;
		data['cid'] = this.cid;
		return data;
	}
}
