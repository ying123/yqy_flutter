class SearchEntity {
	String msg;
	int code;
	List<SearchInfo> info;

	SearchEntity({this.msg, this.code, this.info});


	@override
	String toString() {
		return 'SearchEntity{msg: $msg, code: $code, info: $info}';
	}

	SearchEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		if (json['info'] != null) {
			info = new List<SearchInfo>();(json['info'] as List).forEach((v) { info.add(new SearchInfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SearchInfo {
	String userPhoto;
	String companyName;
	int userId;

	SearchInfo({this.userPhoto, this.companyName, this.userId});

	SearchInfo.fromJson(Map<String, dynamic> json) {
		userPhoto = json['userPhoto'];
		companyName = json['company_name'];
		userId = json['userId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['userPhoto'] = this.userPhoto;
		data['company_name'] = this.companyName;
		data['userId'] = this.userId;
		return data;
	}
}
