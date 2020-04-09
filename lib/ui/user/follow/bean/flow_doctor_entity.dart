class FlowDoctorEntity {
	String msg;
	int code;
	List<FlowDoctorInfo> info;

	FlowDoctorEntity({this.msg, this.code, this.info});

	FlowDoctorEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['info'] != null) {
			info = new List<FlowDoctorInfo>();(json['info'] as List).forEach((v) { info.add(new FlowDoctorInfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class FlowDoctorInfo {
	int activeId;
	int createTime;
	int id;
	int passiveId;
	FlowDoctorInfoInfo info;

	FlowDoctorInfo({this.activeId, this.createTime, this.id, this.passiveId, this.info});

	FlowDoctorInfo.fromJson(Map<String, dynamic> json) {
		activeId = json['active_id'];
		createTime = json['createTime'];
		id = json['id'];
		passiveId = json['passive_id'];
		info = json['info'] != null ? new FlowDoctorInfoInfo.fromJson(json['info']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['active_id'] = this.activeId;
		data['createTime'] = this.createTime;
		data['id'] = this.id;
		data['passive_id'] = this.passiveId;
		if (this.info != null) {
      data['info'] = this.info.toJson();
    }
		return data;
	}
}

class FlowDoctorInfoInfo {
	int tId;
	String realName;
	dynamic jId;
	int hId;
	int tIds;
	String img;
	String userPhoto;
	int id;
	FlowDoctorInfoInfoHospital hospital;
	FlowDoctorInfoInfoDeparts departs;

	FlowDoctorInfoInfo({this.tId, this.realName, this.jId, this.hId, this.tIds, this.img, this.userPhoto, this.id, this.hospital, this.departs});

	FlowDoctorInfoInfo.fromJson(Map<String, dynamic> json) {
		tId = json['t_id'];
		realName = json['realName'];
		jId = json['j_id'];
		hId = json['h_id'];
		tIds = json['t_ids'];
		img = json['img'];
		userPhoto = json['userPhoto'];
		id = json['id'];
		hospital = json['hospital'] != null ? new FlowDoctorInfoInfoHospital.fromJson(json['hospital']) : null;
		departs = json['departs'] != null ? new FlowDoctorInfoInfoDeparts.fromJson(json['departs']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['t_id'] = this.tId;
		data['realName'] = this.realName;
		data['j_id'] = this.jId;
		data['h_id'] = this.hId;
		data['t_ids'] = this.tIds;
		data['img'] = this.img;
		data['userPhoto'] = this.userPhoto;
		data['id'] = this.id;
		if (this.hospital != null) {
      data['hospital'] = this.hospital.toJson();
    }
		if (this.departs != null) {
      data['departs'] = this.departs.toJson();
    }
		return data;
	}
}

class FlowDoctorInfoInfoHospital {
	String name;
	int id;

	FlowDoctorInfoInfoHospital({this.name, this.id});

	FlowDoctorInfoInfoHospital.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}

class FlowDoctorInfoInfoDeparts {
	String name;
	int id;

	FlowDoctorInfoInfoDeparts({this.name, this.id});

	FlowDoctorInfoInfoDeparts.fromJson(Map<String, dynamic> json) {
		name = json['name'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['name'] = this.name;
		data['id'] = this.id;
		return data;
	}
}
