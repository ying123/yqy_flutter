class SearchCompanyEntity {
	String msg;
	int code;
	int nums;
	List<SearchCompanyInfo> info;


	@override
	String toString() {
		return 'SearchCompanyEntity{msg: $msg, code: $code, nums: $nums, info: $info}';
	}

	SearchCompanyEntity({this.msg, this.code, this.nums, this.info});

	SearchCompanyEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		nums = json['nums'];
		if (json['info'] != null) {
			info = new List<SearchCompanyInfo>();(json['info'] as List).forEach((v) { info.add(new SearchCompanyInfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['code'] = this.code;
		data['nums'] = this.nums;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SearchCompanyInfo {
	String userPhoto;
	String companyName;
	int userId;

	@override
	String toString() {
		return 'SearchCompanyInfo{userPhoto: $userPhoto, companyName: $companyName, userId: $userId}';
	}

	SearchCompanyInfo({this.userPhoto, this.companyName, this.userId});

	SearchCompanyInfo.fromJson(Map<String, dynamic> json) {
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
