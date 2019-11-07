class BannerEntity {
	String message;
	String status;
	List<BannerInfo> info;

	BannerEntity({this.message, this.status, this.info});

	BannerEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		if (json['info'] != null) {
			info = new List<BannerInfo>();(json['info'] as List).forEach((v) { info.add(new BannerInfo.fromJson(v)); });
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

class BannerInfo {
	String adName;
	String adId;
	String adFile;
	String advType;
	String adURL;

	BannerInfo({this.adName, this.adId, this.adFile, this.advType, this.adURL});

	BannerInfo.fromJson(Map<String, dynamic> json) {
		adName = json['adName'];
		adId = json['adId'];
		adFile = json['adFile'];
		advType = json['adv_type'];
		adURL = json['adURL'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['adName'] = this.adName;
		data['adId'] = this.adId;
		data['adFile'] = this.adFile;
		data['adv_type'] = this.advType;
		data['adURL'] = this.adURL;
		return data;
	}
}
