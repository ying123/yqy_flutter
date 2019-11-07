class PersonalEntity {
	String message;
	String status;
	PersonalInfo info;

	PersonalEntity({this.message, this.status, this.info});

	PersonalEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new PersonalInfo.fromJson(json['info']) : null;
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

class PersonalInfo {
	String appWopenid;
	String userInfo;
	String userPhoto;
	String userStatus;
	String loginPwd;
	String areaidName;
	String idCard;
	String userPhone;
	String provinceidName;
	String collectNum;
	String cityId;
	String footNum;
	String jName;
	String userInfoStatus;
	String companyImage;
	String tName;
	String tNames;
	String clickNum;
	String userLoginName;
	String companyCode;
	String isFriend;
	String jobCode;
	String regType;
	String userSex;
	String jId;
	String hId;
	String tIds;
	String appQopenid;
	String hName;
	String nickName;
	String jobImg2;
	String fenNum;
	String jobImg1;
	String userId;
	String provinceId;
	String tId;
	String realName;
	String followNum;
	String areaId;
	String createTime;
	String background;
	String companyName;
	String cityidName;
	String authenticeImage;

	PersonalInfo({this.appWopenid, this.userInfo, this.userPhoto, this.userStatus, this.loginPwd, this.areaidName, this.idCard, this.userPhone, this.provinceidName, this.collectNum, this.cityId, this.footNum, this.jName, this.userInfoStatus, this.companyImage, this.tName, this.tNames, this.clickNum, this.userLoginName, this.companyCode, this.isFriend, this.jobCode, this.regType, this.userSex, this.jId, this.hId, this.tIds, this.appQopenid, this.hName, this.nickName, this.jobImg2, this.fenNum, this.jobImg1, this.userId, this.provinceId, this.tId, this.realName, this.followNum, this.areaId, this.createTime, this.background, this.companyName, this.cityidName, this.authenticeImage});

	PersonalInfo.fromJson(Map<String, dynamic> json) {
		appWopenid = json['AppWopenid'];
		userInfo = json['userInfo'];
		userPhoto = json['userPhoto'];
		userStatus = json['userStatus'];
		loginPwd = json['loginPwd'];
		areaidName = json['areaId_name'];
		idCard = json['idCard'];
		userPhone = json['userPhone'];
		provinceidName = json['provinceId_name'];
		collectNum = json['collectNum'];
		cityId = json['cityId'];
		footNum = json['footNum'];
		jName = json['j_name'];
		userInfoStatus = json['userInfoStatus'];
		companyImage = json['company_image'];
		tName = json['t_name'];
		tNames = json['t_names'];
		clickNum = json['clickNum'];
		userLoginName = json['userLoginName'];
		companyCode = json['company_code'];
		isFriend = json['isFriend'];
		jobCode = json['job_code'];
		regType = json['regType'];
		userSex = json['userSex'];
		jId = json['j_id'];
		hId = json['h_id'];
		tIds = json['t_ids'];
		appQopenid = json['AppQopenid'];
		hName = json['h_name'];
		nickName = json['nickName'];
		jobImg2 = json['job_img2'];
		fenNum = json['fenNum'];
		jobImg1 = json['job_img1'];
		userId = json['userId'];
		provinceId = json['provinceId'];
		tId = json['t_id'];
		realName = json['realName'];
		followNum = json['followNum'];
		areaId = json['areaId'];
		createTime = json['createTime'];
		background = json['background'];
		companyName = json['company_name'];
		cityidName = json['cityId_name'];
		authenticeImage = json['authentice_image'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['AppWopenid'] = this.appWopenid;
		data['userInfo'] = this.userInfo;
		data['userPhoto'] = this.userPhoto;
		data['userStatus'] = this.userStatus;
		data['loginPwd'] = this.loginPwd;
		data['areaId_name'] = this.areaidName;
		data['idCard'] = this.idCard;
		data['userPhone'] = this.userPhone;
		data['provinceId_name'] = this.provinceidName;
		data['collectNum'] = this.collectNum;
		data['cityId'] = this.cityId;
		data['footNum'] = this.footNum;
		data['j_name'] = this.jName;
		data['userInfoStatus'] = this.userInfoStatus;
		data['company_image'] = this.companyImage;
		data['t_name'] = this.tName;
		data['t_names'] = this.tNames;
		data['clickNum'] = this.clickNum;
		data['userLoginName'] = this.userLoginName;
		data['company_code'] = this.companyCode;
		data['isFriend'] = this.isFriend;
		data['job_code'] = this.jobCode;
		data['regType'] = this.regType;
		data['userSex'] = this.userSex;
		data['j_id'] = this.jId;
		data['h_id'] = this.hId;
		data['t_ids'] = this.tIds;
		data['AppQopenid'] = this.appQopenid;
		data['h_name'] = this.hName;
		data['nickName'] = this.nickName;
		data['job_img2'] = this.jobImg2;
		data['fenNum'] = this.fenNum;
		data['job_img1'] = this.jobImg1;
		data['userId'] = this.userId;
		data['provinceId'] = this.provinceId;
		data['t_id'] = this.tId;
		data['realName'] = this.realName;
		data['followNum'] = this.followNum;
		data['areaId'] = this.areaId;
		data['createTime'] = this.createTime;
		data['background'] = this.background;
		data['company_name'] = this.companyName;
		data['cityId_name'] = this.cityidName;
		data['authentice_image'] = this.authenticeImage;
		return data;
	}
}
