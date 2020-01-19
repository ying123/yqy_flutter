class UploadImageEntity {
	String msg;
	int code;
	UploadImageInfo info;

	UploadImageEntity({this.msg, this.code, this.info});

	UploadImageEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new UploadImageInfo.fromJson(json['info']) : null;
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

class UploadImageInfo {
	String src;
	String cdn;

	UploadImageInfo({this.src, this.cdn});

	UploadImageInfo.fromJson(Map<String, dynamic> json) {
		src = json['src'];
		cdn = json['cdn'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['src'] = this.src;
		data['cdn'] = this.cdn;
		return data;
	}
}
