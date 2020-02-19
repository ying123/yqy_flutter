class StatusEntity {
	String msg;
	int code;
	StatusInfo info;

	StatusEntity({this.msg, this.code, this.info});

	StatusEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new StatusInfo.fromJson(json['info']) : null;
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

class StatusInfo {
	int id;
	int status;

	StatusInfo({this.id, this.status});

	StatusInfo.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['status'] = this.status;
		return data;
	}
}
