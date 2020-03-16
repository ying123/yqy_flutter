class HcStatusEntity {
	String msg;
	int code;
	HcStatusInfo info;

	HcStatusEntity({this.msg, this.code, this.info});

	HcStatusEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new HcStatusInfo.fromJson(json['info']) : null;
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

class HcStatusInfo {
	String endImage;
	String image;
	int isPlay;
	int allowVod;
	int id;
	int nowVideo;
	List<Null> videoLists;
	int cid;
	HcStatusInfoPlayurl playUrl;

	HcStatusInfo({this.endImage, this.image, this.isPlay, this.allowVod, this.id, this.nowVideo, this.videoLists, this.cid, this.playUrl});

	HcStatusInfo.fromJson(Map<String, dynamic> json) {
		endImage = json['end_image'];
		image = json['image'];
		isPlay = json['is_play'];
		allowVod = json['allow_vod'];
		id = json['id'];
		nowVideo = json['now_video'];
		if (json['video_lists'] != null) {
			videoLists = new List<Null>();
		}
		cid = json['cid'];
		playUrl = json['playUrl'] != null ? new HcStatusInfoPlayurl.fromJson(json['playUrl']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['end_image'] = this.endImage;
		data['image'] = this.image;
		data['is_play'] = this.isPlay;
		data['allow_vod'] = this.allowVod;
		data['id'] = this.id;
		data['now_video'] = this.nowVideo;
		if (this.videoLists != null) {
      data['video_lists'] =  [];
    }
		data['cid'] = this.cid;
		if (this.playUrl != null) {
      data['playUrl'] = this.playUrl.toJson();
    }
		return data;
	}
}

class HcStatusInfoPlayurl {
	HcStatusInfoPlayurlRtmp rtmp;
	HcStatusInfoPlayurlOriginal original;
	HcStatusInfoPlayurlHls hls;

	HcStatusInfoPlayurl({this.rtmp, this.original, this.hls});

	HcStatusInfoPlayurl.fromJson(Map<String, dynamic> json) {
		rtmp = json['rtmp'] != null ? new HcStatusInfoPlayurlRtmp.fromJson(json['rtmp']) : null;
		original = json['original'] != null ? new HcStatusInfoPlayurlOriginal.fromJson(json['original']) : null;
		hls = json['hls'] != null ? new HcStatusInfoPlayurlHls.fromJson(json['hls']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.rtmp != null) {
      data['rtmp'] = this.rtmp.toJson();
    }
		if (this.original != null) {
      data['original'] = this.original.toJson();
    }
		if (this.hls != null) {
      data['hls'] = this.hls.toJson();
    }
		return data;
	}
}

class HcStatusInfoPlayurlRtmp {
	String sd;
	String ld;
	String hd;
	String ud;

	HcStatusInfoPlayurlRtmp({this.sd, this.ld, this.hd, this.ud});

	HcStatusInfoPlayurlRtmp.fromJson(Map<String, dynamic> json) {
		sd = json['sd'];
		ld = json['ld'];
		hd = json['hd'];
		ud = json['ud'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sd'] = this.sd;
		data['ld'] = this.ld;
		data['hd'] = this.hd;
		data['ud'] = this.ud;
		return data;
	}
}

class HcStatusInfoPlayurlOriginal {
	String rtmp;
	String flv;
	String hls;

	HcStatusInfoPlayurlOriginal({this.rtmp, this.flv, this.hls});

	HcStatusInfoPlayurlOriginal.fromJson(Map<String, dynamic> json) {
		rtmp = json['rtmp'];
		flv = json['flv'];
		hls = json['hls'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['rtmp'] = this.rtmp;
		data['flv'] = this.flv;
		data['hls'] = this.hls;
		return data;
	}
}

class HcStatusInfoPlayurlHls {
	String sd;
	String ld;
	String hd;
	String ud;

	HcStatusInfoPlayurlHls({this.sd, this.ld, this.hd, this.ud});

	HcStatusInfoPlayurlHls.fromJson(Map<String, dynamic> json) {
		sd = json['sd'];
		ld = json['ld'];
		hd = json['hd'];
		ud = json['ud'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['sd'] = this.sd;
		data['ld'] = this.ld;
		data['hd'] = this.hd;
		data['ud'] = this.ud;
		return data;
	}
}
