class IsCertificationEntity {
	String msg;
	int code;
	IsCertificationInfo info;

	IsCertificationEntity({this.msg, this.code, this.info});

	IsCertificationEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new IsCertificationInfo.fromJson(json['info']) : null;
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

class IsCertificationInfo {
	int isHaveto;
	int isCert;
	int regType;

	IsCertificationInfo({this.isHaveto, this.isCert, this.regType});

	IsCertificationInfo.fromJson(Map<String, dynamic> json) {
		isHaveto = json['is_haveto'];
		isCert = json['is_cert'];
		regType = json['regType'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['is_haveto'] = this.isHaveto;
		data['is_cert'] = this.isCert;
		data['regType'] = this.regType;
		return data;
	}
}
