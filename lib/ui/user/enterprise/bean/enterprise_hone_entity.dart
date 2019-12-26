class EnterpriseHoneEntity {
	String msg;
	int code;
	EnterpriseHoneInfo info;

	EnterpriseHoneEntity({this.msg, this.code, this.info});

	EnterpriseHoneEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new EnterpriseHoneInfo.fromJson(json['info']) : null;
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

class EnterpriseHoneInfo {
	List<EnterpriseHoneInfoStaffList> staffLists;
	String userPhoto;
	String companyName;
	List<EnterpriseHoneInfoBranchList> branchLists;
	EnterpriseHoneInfoMy my;

	EnterpriseHoneInfo({this.staffLists, this.userPhoto, this.companyName, this.branchLists, this.my});

	EnterpriseHoneInfo.fromJson(Map<String, dynamic> json) {
		if (json['staff_lists'] != null) {
			staffLists = new List<EnterpriseHoneInfoStaffList>();(json['staff_lists'] as List).forEach((v) { staffLists.add(new EnterpriseHoneInfoStaffList.fromJson(v)); });
		}
		userPhoto = json['userPhoto'];
		companyName = json['company_name'];
		if (json['branch_lists'] != null) {
			branchLists = new List<EnterpriseHoneInfoBranchList>();(json['branch_lists'] as List).forEach((v) { branchLists.add(new EnterpriseHoneInfoBranchList.fromJson(v)); });
		}
		my = json['my'] != null ? new EnterpriseHoneInfoMy.fromJson(json['my']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.staffLists != null) {
      data['staff_lists'] =  this.staffLists.map((v) => v.toJson()).toList();
    }
		data['userPhoto'] = this.userPhoto;
		data['company_name'] = this.companyName;
		if (this.branchLists != null) {
      data['branch_lists'] =  this.branchLists.map((v) => v.toJson()).toList();
    }
		if (this.my != null) {
      data['my'] = this.my.toJson();
    }
		return data;
	}
}

class EnterpriseHoneInfoStaffList {
	int uid;
	String realName;
	int gid;
	String userPhoto;
	int id;
	int bid;
	int cid;

	EnterpriseHoneInfoStaffList({this.uid, this.realName, this.gid, this.userPhoto, this.id, this.bid, this.cid});

	EnterpriseHoneInfoStaffList.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		realName = json['realName'];
		gid = json['gid'];
		userPhoto = json['userPhoto'];
		id = json['id'];
		bid = json['bid'];
		cid = json['cid'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['realName'] = this.realName;
		data['gid'] = this.gid;
		data['userPhoto'] = this.userPhoto;
		data['id'] = this.id;
		data['bid'] = this.bid;
		data['cid'] = this.cid;
		return data;
	}
}

class EnterpriseHoneInfoBranchList {
	int companyId;
	String createTime;
	int staffNums;
	String name;
	int pid;
	int dataFlag;
	int id;
	int sorts;

	EnterpriseHoneInfoBranchList({this.companyId, this.createTime, this.staffNums, this.name, this.pid, this.dataFlag, this.id, this.sorts});

	EnterpriseHoneInfoBranchList.fromJson(Map<String, dynamic> json) {
		companyId = json['company_id'];
		createTime = json['createTime'];
		staffNums = json['staff_nums'];
		name = json['name'];
		pid = json['pid'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		sorts = json['sorts'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['company_id'] = this.companyId;
		data['createTime'] = this.createTime;
		data['staff_nums'] = this.staffNums;
		data['name'] = this.name;
		data['pid'] = this.pid;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['sorts'] = this.sorts;
		return data;
	}
}

class EnterpriseHoneInfoMy {
	int uid;
	int gid;
	String createTime;
	dynamic groupName;
	String userPhone;
	dynamic branchName;
	int dataFlag;
	int id;
	int bid;
	dynamic branch;
	int cid;
	dynamic group;

	EnterpriseHoneInfoMy({this.uid, this.gid, this.createTime, this.groupName, this.userPhone, this.branchName, this.dataFlag, this.id, this.bid, this.branch, this.cid, this.group});

	EnterpriseHoneInfoMy.fromJson(Map<String, dynamic> json) {
		uid = json['uid'];
		gid = json['gid'];
		createTime = json['createTime'];
		groupName = json['group_name'];
		userPhone = json['userPhone'];
		branchName = json['branch_name'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		bid = json['bid'];
		branch = json['branch'];
		cid = json['cid'];
		group = json['group'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['uid'] = this.uid;
		data['gid'] = this.gid;
		data['createTime'] = this.createTime;
		data['group_name'] = this.groupName;
		data['userPhone'] = this.userPhone;
		data['branch_name'] = this.branchName;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['bid'] = this.bid;
		data['branch'] = this.branch;
		data['cid'] = this.cid;
		data['group'] = this.group;
		return data;
	}
}
