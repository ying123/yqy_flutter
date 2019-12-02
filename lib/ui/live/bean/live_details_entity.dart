class LiveDetailsEntity {
	String message;
	String status;
	LiveDetailsInfo info;

	LiveDetailsEntity({this.message, this.status, this.info});

	LiveDetailsEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new LiveDetailsInfo.fromJson(json['info']) : null;
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

class LiveDetailsInfo {
	LiveDetailsInfoBroadcast broadcast;
	String introduces;
	String pv;
	String title;
	String content;
	String playUrl;
	String points;
	String youinshCateId;
	String ifCollect;
	var isPlay;
	String startTime;
	String id;
	String image;
	String courseId;
	String address;
	String isPay;
	String introduce;
	String author;
	String dataFlag;
	String isShow;
	List<LiveDetailsInfoLiveList> liveList;
	String createTime;
	String contents;
	String isTop;
	String endTime;

	LiveDetailsInfo({this.broadcast, this.introduces, this.pv, this.title, this.content, this.playUrl, this.points, this.youinshCateId, this.ifCollect, this.isPlay, this.startTime, this.id, this.image, this.courseId, this.address, this.isPay, this.introduce, this.author, this.dataFlag, this.isShow, this.liveList, this.createTime, this.contents, this.isTop, this.endTime});

	LiveDetailsInfo.fromJson(Map<String, dynamic> json) {
		broadcast = json['broadcast'] != null ? new LiveDetailsInfoBroadcast.fromJson(json['broadcast']) : null;
		introduces = json['introduces'];
		pv = json['pv'];
		title = json['title'];
		content = json['content'];
		playUrl = json['playUrl'];
		points = json['points'];
		youinshCateId = json['youinshCateId'];
		ifCollect = json['ifCollect'];
		isPlay = json['isPlay'];
		startTime = json['startTime'];
		id = json['id'];
		image = json['image'];
		courseId = json['course_id'];
		address = json['address'];
		isPay = json['isPay'];
		introduce = json['introduce'];
		author = json['author'];
		dataFlag = json['dataFlag'];
		isShow = json['isShow'];
		if (json['live_list'] != null) {
			liveList = new List<LiveDetailsInfoLiveList>();(json['live_list'] as List).forEach((v) { liveList.add(new LiveDetailsInfoLiveList.fromJson(v)); });
		}
		createTime = json['createTime'];
		contents = json['contents'];
		isTop = json['isTop'];
		endTime = json['endTime'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.broadcast != null) {
      data['broadcast'] = this.broadcast.toJson();
    }
		data['introduces'] = this.introduces;
		data['pv'] = this.pv;
		data['title'] = this.title;
		data['content'] = this.content;
		data['playUrl'] = this.playUrl;
		data['points'] = this.points;
		data['youinshCateId'] = this.youinshCateId;
		data['ifCollect'] = this.ifCollect;
		data['isPlay'] = this.isPlay;
		data['startTime'] = this.startTime;
		data['id'] = this.id;
		data['image'] = this.image;
		data['course_id'] = this.courseId;
		data['address'] = this.address;
		data['isPay'] = this.isPay;
		data['introduce'] = this.introduce;
		data['author'] = this.author;
		data['dataFlag'] = this.dataFlag;
		data['isShow'] = this.isShow;
		if (this.liveList != null) {
      data['live_list'] =  this.liveList.map((v) => v.toJson()).toList();
    }
		data['createTime'] = this.createTime;
		data['contents'] = this.contents;
		data['isTop'] = this.isTop;
		data['endTime'] = this.endTime;
		return data;
	}
}

class LiveDetailsInfoBroadcast {
	String msg;
	String status;
	LiveDetailsInfoBroadcastInfo info;

	LiveDetailsInfoBroadcast({this.msg, this.status, this.info});

	LiveDetailsInfoBroadcast.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		status = json['status'];
		info = json['info'] != null ? new LiveDetailsInfoBroadcastInfo.fromJson(json['info']) : null;
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
class LiveDetailsInfoBroadcastInfo {
	LiveDetailsInfoBroadcastInfoAliyunChannel aliyunChannel;
	LiveDetailsInfoBroadcastInfoChannelUrl channelUrl;

	LiveDetailsInfoBroadcastInfo({this.aliyunChannel, this.channelUrl});

	LiveDetailsInfoBroadcastInfo.fromJson(Map<String, dynamic> json) {
		aliyunChannel = json['aliyun_channel'] != null ? new LiveDetailsInfoBroadcastInfoAliyunChannel.fromJson(json['aliyun_channel']) : null;
		channelUrl = json['channel_url'] != null ? new LiveDetailsInfoBroadcastInfoChannelUrl.fromJson(json['channel_url']) : null;
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

class LiveDetailsInfoBroadcastInfoAliyunChannel {
	String appName;
	String cdnDomain;
	String streamName;
	String publishUrl;

	LiveDetailsInfoBroadcastInfoAliyunChannel({this.appName, this.cdnDomain, this.streamName, this.publishUrl});

	LiveDetailsInfoBroadcastInfoAliyunChannel.fromJson(Map<String, dynamic> json) {
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

class LiveDetailsInfoBroadcastInfoChannelUrl {
	String urlFlv;
	String liveChannelId;
	String urlRtmp;
	String pulishUrl;
	String status;
	String urlHls;

	LiveDetailsInfoBroadcastInfoChannelUrl({this.urlFlv, this.liveChannelId, this.urlRtmp, this.pulishUrl, this.status, this.urlHls});

	LiveDetailsInfoBroadcastInfoChannelUrl.fromJson(Map<String, dynamic> json) {
		urlFlv = json['url_flv'];
		liveChannelId = json['live_channel_id'];
		urlRtmp = json['url_rtmp'];
		pulishUrl = json['pulish_url'];
		status = json['status'];
		urlHls = json['url_hls'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['url_flv'] = this.urlFlv;
		data['live_channel_id'] = this.liveChannelId;
		data['url_rtmp'] = this.urlRtmp;
		data['pulish_url'] = this.pulishUrl;
		data['status'] = this.status;
		data['url_hls'] = this.urlHls;
		return data;
	}
}







class LiveDetailsInfoLiveList {
	String image;
	String courseId;
	String youinshCateId;
	String isPlay;
	String startTime;
	String id;
	String title;
	String isShow;
	String cid;
	String status;
	 PlayUrlBean play_url;

	LiveDetailsInfoLiveList({this.image, this.courseId, this.youinshCateId, this.isPlay, this.startTime, this.id, this.title, this.isShow, this.cid, this.status});




	LiveDetailsInfoLiveList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		courseId = json['course_id'];
		youinshCateId = json['youinshCateId'];
		isPlay = json['is_play'];
		startTime = json['startTime'];
		id = json['id'];
		title = json['title'];
		isShow = json['is_show'];
		cid = json['cid'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['course_id'] = this.courseId;
		data['youinshCateId'] = this.youinshCateId;
		data['is_play'] = this.isPlay;
		data['startTime'] = this.startTime;
		data['id'] = this.id;
		data['title'] = this.title;
		data['is_show'] = this.isShow;
		data['cid'] = this.cid;
		data['status'] = this.status;
		return data;
	}
}

class PlayUrlBean {

	String pulish_url;
	String url_rtmp;
	String status;
	String url_hls;
	String live_channel_id;
	String url_flv;
	String publish_url;

	PlayUrlBean({this.pulish_url, this.url_rtmp, this.status, this.url_hls, this.live_channel_id, this.url_flv, this.publish_url});

	PlayUrlBean.fromJson(Map<String, dynamic> json) {
		pulish_url = json['pulish_url'];
		url_rtmp = json['url_rtmp'];
		status = json['status'];
		url_hls = json['url_hls'];
		live_channel_id = json['live_channel_id'];
		url_flv = json['url_flv'];
		publish_url = json['publish_url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['pulish_url'] = this.pulish_url;
		data['url_rtmp'] = this.url_rtmp;
		data['status'] = this.status;
		data['url_hls'] = this.url_hls;
		data['live_channel_id'] = this.live_channel_id;
		data['url_flv'] = this.url_flv;
		data['publish_url'] = this.publish_url;
		return data;
	}
}
