class SpecialBannerEntity {
	String message;
	var status;
	List<SpecialBannerInfo> info;


	@override
	String toString() {
		return 'SpecialBannerEntity{message: $message, status: $status, info: $info}';
	}

	SpecialBannerEntity({this.message, this.status, this.info});

	SpecialBannerEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		if (json['info'] != null) {
			info = new List<SpecialBannerInfo>();(json['info'] as List).forEach((v) { info.add(new SpecialBannerInfo.fromJson(v)); });
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

class SpecialBannerInfo {
	String image;
	var typeId;
	var id;
	var title;
	var type;


	@override
	String toString() {
		return 'SpecialBannerInfo{image: $image, typeId: $typeId, id: $id, title: $title, type: $type}';
	}

	SpecialBannerInfo({this.image, this.typeId, this.id, this.title, this.type});

	SpecialBannerInfo.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		typeId = json['type_id'];
		id = json['id'];
		title = json['title'];
		type = json['type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['type_id'] = this.typeId;
		data['id'] = this.id;
		data['title'] = this.title;
		data['type'] = this.type;
		return data;
	}
}
