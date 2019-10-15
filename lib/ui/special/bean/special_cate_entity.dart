class SpecialCateEntity {
	String message;
	var status;
	List<SpecialCateInfo> info;


	@override
	String toString() {
		return 'SpecialCateEntity{message: $message, status: $status, info: $info}';
	}

	SpecialCateEntity({this.message, this.status, this.info});

	SpecialCateEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		if (json['info'] != null) {
			info = new List<SpecialCateInfo>();(json['info'] as List).forEach((v) { info.add(new SpecialCateInfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['message'] = this.message;
		data['status'] = this.status;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class SpecialCateInfo {
	var id;
	String title;


	@override
	String toString() {
		return 'SpecialCateInfo{id: $id, title: $title}';
	}

	SpecialCateInfo({this.id, this.title});

	SpecialCateInfo.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		return data;
	}
}
