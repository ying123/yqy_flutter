class BaseResult {
	String msg;
	int code;
	var info;

	bool get tokenCancel => 4001 == code;

	var status;
	var message;
	BaseResult({this.msg, this.code, this.info});


	@override
	String toString() {
		return 'BaseResult{msg: $msg, code: $code, info: $info, status: $status, message: $message}';
	}

	BaseResult.fromJson(Map<String, dynamic> json) {
		msg = json['msg'].toString();
		code = json['code'];
		info = json['info'] ;
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

