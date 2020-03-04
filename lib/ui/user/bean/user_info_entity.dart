class UserInfoEntity {
	String msg;
	int code;
	UserInfoInfo info;

	UserInfoEntity({this.msg, this.code, this.info});

	UserInfoEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new UserInfoInfo.fromJson(json['info']) : null;
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

class UserInfoInfo {
	dynamic areaName;
	String userInfo;
	String userPhoto;
	String idCard;
	int cityId;
	dynamic departName;
	dynamic cityName;
	int userInfoStatus;
	int id;
	String jobCode;
	dynamic hospital;
	dynamic depart;
	int regType;
	dynamic hospitalName;
	dynamic departs;
	int jId;
	int hId;
	int tIds;
	String jobImg2;
	String jobImg1;
	int provinceId;
	int tId;
	String realName;
	int areaId;
	dynamic jobName;
	dynamic departsName;
	dynamic job;
	dynamic proName;

	UserInfoInfo({this.areaName, this.userInfo, this.userPhoto, this.idCard, this.cityId, this.departName, this.cityName, this.userInfoStatus, this.id, this.jobCode, this.hospital, this.depart, this.regType, this.hospitalName, this.departs, this.jId, this.hId, this.tIds, this.jobImg2, this.jobImg1, this.provinceId, this.tId, this.realName, this.areaId, this.jobName, this.departsName, this.job, this.proName});

	UserInfoInfo.fromJson(Map<String, dynamic> json) {
		areaName = json['area_name'];
		userInfo = json['userInfo'];
		userPhoto = json['userPhoto'];
		idCard = json['idCard'];
		cityId = json['cityId'];
		departName = json['depart_name'];
		cityName = json['city_name'];
		userInfoStatus = json['userInfoStatus'];
		id = json['id'];
		jobCode = json['job_code'];
		hospital = json['hospital'];
		depart = json['depart'];
		regType = json['regType'];
		hospitalName = json['hospital_name'];
		departs = json['departs'];
		jId = json['j_id'];
		hId = json['h_id'];
		tIds = json['t_ids'];
		jobImg2 = json['job_img2'];
		jobImg1 = json['job_img1'];
		provinceId = json['provinceId'];
		tId = json['t_id'];
		realName = json['realName'];
		areaId = json['areaId'];
		jobName = json['job_name'];
		departsName = json['departs_name'];
		job = json['job'];
		proName = json['pro_name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['area_name'] = this.areaName;
		data['userInfo'] = this.userInfo;
		data['userPhoto'] = this.userPhoto;
		data['idCard'] = this.idCard;
		data['cityId'] = this.cityId;
		data['depart_name'] = this.departName;
		data['city_name'] = this.cityName;
		data['userInfoStatus'] = this.userInfoStatus;
		data['id'] = this.id;
		data['job_code'] = this.jobCode;
		data['hospital'] = this.hospital;
		data['depart'] = this.depart;
		data['regType'] = this.regType;
		data['hospital_name'] = this.hospitalName;
		data['departs'] = this.departs;
		data['j_id'] = this.jId;
		data['h_id'] = this.hId;
		data['t_ids'] = this.tIds;
		data['job_img2'] = this.jobImg2;
		data['job_img1'] = this.jobImg1;
		data['provinceId'] = this.provinceId;
		data['t_id'] = this.tId;
		data['realName'] = this.realName;
		data['areaId'] = this.areaId;
		data['job_name'] = this.jobName;
		data['departs_name'] = this.departsName;
		data['job'] = this.job;
		data['pro_name'] = this.proName;
		return data;
	}
}
