class WxInfoEntity {
	String accessToken;
	String refreshToken;
	String unionid;
	String openid;
	String scope;
	int expiresIn;

	WxInfoEntity({this.accessToken, this.refreshToken, this.unionid, this.openid, this.scope, this.expiresIn});

	WxInfoEntity.fromJson(Map<String, dynamic> json) {
		accessToken = json['access_token'];
		refreshToken = json['refresh_token'];
		unionid = json['unionid'];
		openid = json['openid'];
		scope = json['scope'];
		expiresIn = json['expires_in'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['access_token'] = this.accessToken;
		data['refresh_token'] = this.refreshToken;
		data['unionid'] = this.unionid;
		data['openid'] = this.openid;
		data['scope'] = this.scope;
		data['expires_in'] = this.expiresIn;
		return data;
	}
}
