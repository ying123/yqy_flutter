class UserInfoEntity {
	int code;
	String msg;
	UserInfoInfo info;

	UserInfoEntity({this.code, this.msg, this.info});

	UserInfoEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		msg = json['msg'];
		info = json['info'] != null ? new UserInfoInfo.fromJson(json['info']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		data['msg'] = this.msg;
		if (this.info != null) {
			data['info'] = this.info.toJson();
		}
		return data;
	}
}

class UserInfoInfo {
	int id;
	String realName;
	int userInfoStatus;
	String userPhoto;
	String userInfo;
	String idCard;
	int provinceId;
	int cityId;
	int areaId;
	int hId;
	int tId;
	int tIds;
	int jId;
	String jobCode;
	Null jobImg1;
	Null jobImg2;
	int regType;
	String hospitalName;
	Null proName;
	Null cityName;
	Null areaName;
	String departName;
	String departsName;
	String jobName;
	Hospital hospital;
	Pro pro;
	Pro city;
	Pro area;
	Depart depart;
	Depart departs;
	Depart job;

	UserInfoInfo(
			{this.id,
				this.realName,
				this.userInfoStatus,
				this.userPhoto,
				this.userInfo,
				this.idCard,
				this.provinceId,
				this.cityId,
				this.areaId,
				this.hId,
				this.tId,
				this.tIds,
				this.jId,
				this.jobCode,
				this.jobImg1,
				this.jobImg2,
				this.regType,
				this.hospitalName,
				this.proName,
				this.cityName,
				this.areaName,
				this.departName,
				this.departsName,
				this.jobName,
				this.hospital,
				this.pro,
				this.city,
				this.area,
				this.depart,
				this.departs,
				this.job});

	UserInfoInfo.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		realName = json['realName'];
		userInfoStatus = json['userInfoStatus'];
		userPhoto = json['userPhoto'];
		userInfo = json['userInfo'];
		idCard = json['idCard'];
		provinceId = json['provinceId'];
		cityId = json['cityId'];
		areaId = json['areaId'];
		hId = json['h_id'];
		tId = json['t_id'];
		tIds = json['t_ids'];
		jId = json['j_id'];
		jobCode = json['job_code'];
		jobImg1 = json['job_img1'];
		jobImg2 = json['job_img2'];
		regType = json['regType'];
		hospitalName = json['hospital_name'];
		proName = json['pro_name'];
		cityName = json['city_name'];
		areaName = json['area_name'];
		departName = json['depart_name'];
		departsName = json['departs_name'];
		jobName = json['job_name'];
		hospital = json['hospital'] != null
				? new Hospital.fromJson(json['hospital'])
				: null;
		pro = json['pro'] != null ? new Pro.fromJson(json['pro']) : null;
		city = json['city'] != null ? new Pro.fromJson(json['city']) : null;
		area = json['area'] != null ? new Pro.fromJson(json['area']) : null;
		depart =
		json['depart'] != null ? new Depart.fromJson(json['depart']) : null;
		departs =
		json['departs'] != null ? new Depart.fromJson(json['departs']) : null;
		job = json['job'] != null ? new Depart.fromJson(json['job']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['realName'] = this.realName;
		data['userInfoStatus'] = this.userInfoStatus;
		data['userPhoto'] = this.userPhoto;
		data['userInfo'] = this.userInfo;
		data['idCard'] = this.idCard;
		data['provinceId'] = this.provinceId;
		data['cityId'] = this.cityId;
		data['areaId'] = this.areaId;
		data['h_id'] = this.hId;
		data['t_id'] = this.tId;
		data['t_ids'] = this.tIds;
		data['j_id'] = this.jId;
		data['job_code'] = this.jobCode;
		data['job_img1'] = this.jobImg1;
		data['job_img2'] = this.jobImg2;
		data['regType'] = this.regType;
		data['hospital_name'] = this.hospitalName;
		data['pro_name'] = this.proName;
		data['city_name'] = this.cityName;
		data['area_name'] = this.areaName;
		data['depart_name'] = this.departName;
		data['departs_name'] = this.departsName;
		data['job_name'] = this.jobName;
		if (this.hospital != null) {
			data['hospital'] = this.hospital.toJson();
		}
		if (this.pro != null) {
			data['pro'] = this.pro.toJson();
		}
		if (this.city != null) {
			data['city'] = this.city.toJson();
		}
		if (this.area != null) {
			data['area'] = this.area.toJson();
		}
		if (this.depart != null) {
			data['depart'] = this.depart.toJson();
		}
		if (this.departs != null) {
			data['departs'] = this.departs.toJson();
		}
		if (this.job != null) {
			data['job'] = this.job.toJson();
		}
		return data;
	}
}

class Hospital {
	int id;
	String name;
	int provinceId;
	int cityId;
	int areaId;
	int dataFlag;
	String createTime;

	Hospital(
			{this.id,
				this.name,
				this.provinceId,
				this.cityId,
				this.areaId,
				this.dataFlag,
				this.createTime});

	Hospital.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		provinceId = json['provinceId'];
		cityId = json['cityId'];
		areaId = json['areaId'];
		dataFlag = json['dataFlag'];
		createTime = json['create_time'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['provinceId'] = this.provinceId;
		data['cityId'] = this.cityId;
		data['areaId'] = this.areaId;
		data['dataFlag'] = this.dataFlag;
		data['create_time'] = this.createTime;
		return data;
	}
}

class Pro {
	int areaId;
	int parentId;
	String areaName;
	int isShow;
	int areaSort;
	String areaKey;
	int areaType;
	int dataFlag;
	Null createTime;

	Pro(
			{this.areaId,
				this.parentId,
				this.areaName,
				this.isShow,
				this.areaSort,
				this.areaKey,
				this.areaType,
				this.dataFlag,
				this.createTime});

	Pro.fromJson(Map<String, dynamic> json) {
		areaId = json['areaId'];
		parentId = json['parentId'];
		areaName = json['areaName'];
		isShow = json['isShow'];
		areaSort = json['areaSort'];
		areaKey = json['areaKey'];
		areaType = json['areaType'];
		dataFlag = json['dataFlag'];
		createTime = json['createTime'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['areaId'] = this.areaId;
		data['parentId'] = this.parentId;
		data['areaName'] = this.areaName;
		data['isShow'] = this.isShow;
		data['areaSort'] = this.areaSort;
		data['areaKey'] = this.areaKey;
		data['areaType'] = this.areaType;
		data['dataFlag'] = this.dataFlag;
		data['createTime'] = this.createTime;
		return data;
	}
}

class Depart {
	int id;
	String name;
	int fid;
	int type;
	String createTime;
	int dataFlag;
	int sort;
	int isShow;
	Null image;
	int provinceId;
	int cityId;
	int areaId;
	String createTimeX;

	Depart(
			{this.id,
				this.name,
				this.fid,
				this.type,
				this.createTime,
				this.dataFlag,
				this.sort,
				this.isShow,
				this.image,
				this.provinceId,
				this.cityId,
				this.areaId,
				this.createTimeX});

	Depart.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		name = json['name'];
		fid = json['fid'];
		type = json['type'];
		createTime = json['createTime'];
		dataFlag = json['dataFlag'];
		sort = json['sort'];
		isShow = json['isShow'];
		image = json['image'];
		provinceId = json['provinceId'];
		cityId = json['cityId'];
		areaId = json['areaId'];
		createTime = json['create_time'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['name'] = this.name;
		data['fid'] = this.fid;
		data['type'] = this.type;
		data['createTime'] = this.createTime;
		data['dataFlag'] = this.dataFlag;
		data['sort'] = this.sort;
		data['isShow'] = this.isShow;
		data['image'] = this.image;
		data['provinceId'] = this.provinceId;
		data['cityId'] = this.cityId;
		data['areaId'] = this.areaId;
		data['create_time'] = this.createTimeX;
		return data;
	}
}
