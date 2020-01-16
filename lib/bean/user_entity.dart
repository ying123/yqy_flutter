class UserEntity {
	String msg;
	int code;
	UserInfo info;

	UserEntity({this.msg, this.code, this.info});

	UserEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new UserInfo.fromJson(json['info']) : null;
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

class UserInfo {
	String userInfo;
	int jId;
	int hId;
	int tIds;
	String userPhoto;
	String idCard;
	dynamic jobImg2;
	dynamic jobImg1;
	int cityId;
	int provinceId;
	int tId;
	String realName;
	int areaId;
	int userInfoStatus;
	int id;
	String jobCode;
	int regType;
	String hospitalName;

	UserInfo({this.userInfo, this.jId, this.hId, this.tIds, this.userPhoto, this.idCard, this.jobImg2, this.jobImg1, this.cityId, this.provinceId, this.tId, this.realName, this.areaId, this.userInfoStatus, this.id, this.jobCode, this.regType, this.hospitalName});

	UserInfo.fromJson(Map<String, dynamic> json) {
		userInfo = json['userInfo'];
		jId = json['j_id'];
		hId = json['h_id'];
		tIds = json['t_ids'];
		userPhoto = json['userPhoto'];
		idCard = json['idCard'];
		jobImg2 = json['job_img2'];
		jobImg1 = json['job_img1'];
		cityId = json['cityId'];
		provinceId = json['provinceId'];
		tId = json['t_id'];
		realName = json['realName'];
		areaId = json['areaId'];
		userInfoStatus = json['userInfoStatus'];
		id = json['id'];
		jobCode = json['job_code'];
		regType = json['regType'];
		hospitalName = json['hospital_name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userInfo'] = this.userInfo;
		data['j_id'] = this.jId;
		data['h_id'] = this.hId;
		data['t_ids'] = this.tIds;
		data['userPhoto'] = this.userPhoto;
		data['idCard'] = this.idCard;
		data['job_img2'] = this.jobImg2;
		data['job_img1'] = this.jobImg1;
		data['cityId'] = this.cityId;
		data['provinceId'] = this.provinceId;
		data['t_id'] = this.tId;
		data['realName'] = this.realName;
		data['areaId'] = this.areaId;
		data['userInfoStatus'] = this.userInfoStatus;
		data['id'] = this.id;
		data['job_code'] = this.jobCode;
		data['regType'] = this.regType;
		data['hospital_name'] = this.hospitalName;
		return data;
	}
}
