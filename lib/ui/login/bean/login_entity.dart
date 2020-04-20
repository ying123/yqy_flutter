class LoginEntity {
	String  loginSecret;
	String  userPhone;
	String nickName;
	String userId;
	var regType;
	String token;

	LoginEntity({this. loginSecret, this. userPhone, this.nickName, this.userId, this.regType, this.token});

	LoginEntity.fromJson(Map<String, dynamic> json) {
		 loginSecret = json['loginSecret'];
		 userPhone = json['userPhone'];
		nickName = json['nickName'];
		userId = json['userId'];
		regType = json['regType'];
		token = json['token'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['loginSecret'] = this. loginSecret;
		data['userPhone'] = this. userPhone;
		data['nickName'] = this.nickName;
		data['userId'] = this.userId;
		data['regType'] = this.regType;
		data['token'] = this.token;
		return data;
	}
}
