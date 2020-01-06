class SendSmsEntity {
	String msg;
	int code;
	SendSmsInfo info;


  @override
  String toString() {
    return 'SendSmsEntity{msg: $msg, code: $code, info: $info}';
  }

  SendSmsEntity({this.msg, this.code, this.info});

	SendSmsEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new SendSmsInfo.fromJson(json['info']) : null;
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

class SendSmsInfo {
	int status;
	dynamic token;
	SendSmsInfo({this.status});


  @override
  String toString() {
    return 'SendSmsInfo{status: $status, token: $token}';
  }

  SendSmsInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
		token = json['token'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['status'] = this.status;
		data['token'] = this.token;
		return data;
	}
}
