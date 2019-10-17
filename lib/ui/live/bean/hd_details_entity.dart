class HdDetailsEntity {
	String message;
	String status;
	HdDetailsInfo info;

	HdDetailsEntity({this.message, this.status, this.info});

	HdDetailsEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new HdDetailsInfo.fromJson(json['info']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['message'] = this.message;
		data['status'] = this.status;
		if (this.info != null) {
      data['info'] = this.info.toJson();
    }
		return data;
	}
}

class HdDetailsInfo {
	String courseId;
	String image;
	String isPay;
	String introduces;
	String introduce;
	String author;
	HdDetailsInfoYouinsh youinsh;
	HdDetailsInfoInteract interact;
	String title;
	String content;
	String startTime;
	String whiteList;
	String ifCollect;
	String contents;
	String isPlay;
	String isWhite;
	String id;

	HdDetailsInfo({this.courseId, this.image, this.isPay, this.introduces, this.introduce, this.author, this.youinsh, this.interact, this.title, this.content, this.startTime, this.whiteList, this.ifCollect, this.contents, this.isPlay, this.isWhite, this.id});

	HdDetailsInfo.fromJson(Map<String, dynamic> json) {
		courseId = json['course_id'];
		image = json['image'];
		isPay = json['isPay'];
		introduces = json['introduces'];
		introduce = json['introduce'];
		author = json['author'];
		youinsh = json['youinsh'] != null ? new HdDetailsInfoYouinsh.fromJson(json['youinsh']) : null;
		interact = json['interact'] != null ? new HdDetailsInfoInteract.fromJson(json['interact']) : null;
		title = json['title'];
		content = json['content'];
		startTime = json['start_time'];
		whiteList = json['white_list'];
		ifCollect = json['ifCollect'];
		contents = json['contents'];
		isPlay = json['isPlay'];
		isWhite = json['isWhite'];
		id = json['id'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['course_id'] = this.courseId;
		data['image'] = this.image;
		data['isPay'] = this.isPay;
		data['introduces'] = this.introduces;
		data['introduce'] = this.introduce;
		data['author'] = this.author;
		if (this.youinsh != null) {
      data['youinsh'] = this.youinsh.toJson();
    }
		if (this.interact != null) {
      data['interact'] = this.interact.toJson();
    }
		data['title'] = this.title;
		data['content'] = this.content;
		data['start_time'] = this.startTime;
		data['white_list'] = this.whiteList;
		data['ifCollect'] = this.ifCollect;
		data['contents'] = this.contents;
		data['isPlay'] = this.isPlay;
		data['isWhite'] = this.isWhite;
		data['id'] = this.id;
		return data;
	}
}

class HdDetailsInfoYouinsh {
	String userId;
	String authToken;
	String token;

	HdDetailsInfoYouinsh({this.userId, this.authToken, this.token});

	HdDetailsInfoYouinsh.fromJson(Map<String, dynamic> json) {
		userId = json['user_id'];
		authToken = json['auth_token'];
		token = json['token'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['user_id'] = this.userId;
		data['auth_token'] = this.authToken;
		data['token'] = this.token;
		return data;
	}
}

class HdDetailsInfoInteract {
	String msg;
	String status;
	HdDetailsInfoInteractInfo info;

	HdDetailsInfoInteract({this.msg, this.status, this.info});

	HdDetailsInfoInteract.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		status = json['status'];
		info = json['info'] != null ? new HdDetailsInfoInteractInfo.fromJson(json['info']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['msg'] = this.msg;
		data['status'] = this.status;
		if (this.info != null) {
      data['info'] = this.info.toJson();
    }
		return data;
	}
}

class HdDetailsInfoInteractInfo {
	HdDetailsInfoInteractInfoAliyunChannel aliyunChannel;
	HdDetailsInfoInteractInfoChannelUrl channelUrl;

	HdDetailsInfoInteractInfo({this.aliyunChannel, this.channelUrl});

	HdDetailsInfoInteractInfo.fromJson(Map<String, dynamic> json) {
		aliyunChannel = json['aliyun_channel'] != null ? new HdDetailsInfoInteractInfoAliyunChannel.fromJson(json['aliyun_channel']) : null;
		channelUrl = json['channel_url'] != null ? new HdDetailsInfoInteractInfoChannelUrl.fromJson(json['channel_url']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.aliyunChannel != null) {
      data['aliyun_channel'] = this.aliyunChannel.toJson();
    }
		if (this.channelUrl != null) {
      data['channel_url'] = this.channelUrl.toJson();
    }
		return data;
	}
}

class HdDetailsInfoInteractInfoAliyunChannel {
	String appName;
	String cdnDomain;
	String streamName;
	String publishUrl;

	HdDetailsInfoInteractInfoAliyunChannel({this.appName, this.cdnDomain, this.streamName, this.publishUrl});

	HdDetailsInfoInteractInfoAliyunChannel.fromJson(Map<String, dynamic> json) {
		appName = json['app_name'];
		cdnDomain = json['cdn_domain'];
		streamName = json['stream_name'];
		publishUrl = json['publish_url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['app_name'] = this.appName;
		data['cdn_domain'] = this.cdnDomain;
		data['stream_name'] = this.streamName;
		data['publish_url'] = this.publishUrl;
		return data;
	}
}

class HdDetailsInfoInteractInfoChannelUrl {
	String urlFlv;
	String liveChannelId;
	String publishUrl;
	String urlRtmp;
	String pulishUrl;
	String status;
	String urlHls;

	HdDetailsInfoInteractInfoChannelUrl({this.urlFlv, this.liveChannelId, this.publishUrl, this.urlRtmp, this.pulishUrl, this.status, this.urlHls});

	HdDetailsInfoInteractInfoChannelUrl.fromJson(Map<String, dynamic> json) {
		urlFlv = json['url_flv'];
		liveChannelId = json['live_channel_id'];
		publishUrl = json['publish_url'];
		urlRtmp = json['url_rtmp'];
		pulishUrl = json['pulish_url'];
		status = json['status'];
		urlHls = json['url_hls'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['url_flv'] = this.urlFlv;
		data['live_channel_id'] = this.liveChannelId;
		data['publish_url'] = this.publishUrl;
		data['url_rtmp'] = this.urlRtmp;
		data['pulish_url'] = this.pulishUrl;
		data['status'] = this.status;
		data['url_hls'] = this.urlHls;
		return data;
	}
}
