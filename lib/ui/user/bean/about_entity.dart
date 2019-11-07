class AboutEntity {
	String message;
	String status;
	AboutInfo info;

	AboutEntity({this.message, this.status, this.info});

	AboutEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new AboutInfo.fromJson(json['info']) : null;
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

class AboutInfo {
	String appWopenid;
	String serviceTel3;
	String copyright;
	String appQopenid;
	String userPhone;
	String versionCode;
	String logo;
	String webName;

	AboutInfo({this.appWopenid, this.serviceTel3, this.copyright, this.appQopenid, this.userPhone, this.versionCode, this.logo, this.webName});

	AboutInfo.fromJson(Map<String, dynamic> json) {
		appWopenid = json['AppWopenid'];
		serviceTel3 = json['serviceTel3'];
		copyright = json['copyright'];
		appQopenid = json['AppQopenid'];
		userPhone = json['userPhone'];
		versionCode = json['version_code'];
		logo = json['logo'];
		webName = json['WebName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['AppWopenid'] = this.appWopenid;
		data['serviceTel3'] = this.serviceTel3;
		data['copyright'] = this.copyright;
		data['AppQopenid'] = this.appQopenid;
		data['userPhone'] = this.userPhone;
		data['version_code'] = this.versionCode;
		data['logo'] = this.logo;
		data['WebName'] = this.webName;
		return data;
	}
}
