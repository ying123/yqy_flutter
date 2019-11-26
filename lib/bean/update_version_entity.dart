class UpdateVersionEntity {
	String message;
	String status;
	UpdateVersionInfo info;

	UpdateVersionEntity({this.message, this.status, this.info});

	UpdateVersionEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new UpdateVersionInfo.fromJson(json['info']) : null;
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

class UpdateVersionInfo {
	String size;
	String createTime;
	String remark;
	String dataFlag;
	String id;
	String downdress;
	String versioncode;
	String qid;
	String versionname;
	String staffId;
	String status;

	UpdateVersionInfo({this.size, this.createTime, this.remark, this.dataFlag, this.id, this.downdress, this.versioncode, this.qid, this.versionname, this.staffId, this.status});

	UpdateVersionInfo.fromJson(Map<String, dynamic> json) {
		size = json['size'];
		createTime = json['createTime'];
		remark = json['remark'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		downdress = json['downdress'];
		versioncode = json['versioncode'];
		qid = json['qid'];
		versionname = json['versionname'];
		staffId = json['staffId'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['size'] = this.size;
		data['createTime'] = this.createTime;
		data['remark'] = this.remark;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['downdress'] = this.downdress;
		data['versioncode'] = this.versioncode;
		data['qid'] = this.qid;
		data['versionname'] = this.versionname;
		data['staffId'] = this.staffId;
		data['status'] = this.status;
		return data;
	}
}
