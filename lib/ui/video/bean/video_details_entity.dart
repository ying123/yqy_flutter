class VideoDetailsEntity {
	String message;
	String status;
	VideoDetailsInfo info;

	VideoDetailsEntity({this.message, this.status, this.info});

	VideoDetailsEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new VideoDetailsInfo.fromJson(json['info']) : null;
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

class VideoDetailsInfo {
	String introduces;
	String pv;
	String title;
	String content;
	String points;
	String playUrl;
	String ifCollect;
	String clickNum;
	String startTime;
	List<VideoDetailsInfoPlayList> playList;
	String id;
	String image;
	String cate;
	String address;
	String isPay;
	String introduce;
	String author;
	String dataFlag;
	String updateTime;
	String catePath;
	String cateString;
	String isShow;
	List<Null> node;
	String liveId;
	String createTime;
	String contents;
	String isTop;
	String endTime;

	VideoDetailsInfo({this.introduces, this.pv, this.title, this.content, this.points, this.playUrl, this.ifCollect, this.clickNum, this.startTime, this.playList, this.id, this.image, this.cate, this.address, this.isPay, this.introduce, this.author, this.dataFlag, this.updateTime, this.catePath, this.cateString, this.isShow, this.node, this.liveId, this.createTime, this.contents, this.isTop, this.endTime});

	VideoDetailsInfo.fromJson(Map<String, dynamic> json) {
		introduces = json['introduces'];
		pv = json['pv'];
		title = json['title'];
		content = json['content'];
		points = json['points'];
		playUrl = json['playUrl'];
		ifCollect = json['ifCollect'];
		clickNum = json['clickNum'];
		startTime = json['startTime'];
		if (json['play_list'] != null) {
			playList = new List<VideoDetailsInfoPlayList>();(json['play_list'] as List).forEach((v) { playList.add(new VideoDetailsInfoPlayList.fromJson(v)); });
		}
		id = json['id'];
		image = json['image'];
		cate = json['cate'];
		address = json['address'];
		isPay = json['isPay'];
		introduce = json['introduce'];
		author = json['author'];
		dataFlag = json['dataFlag'];
		updateTime = json['updateTime'];
		catePath = json['catePath'];
		cateString = json['cateString'];
		isShow = json['isShow'];
		if (json['node'] != null) {
			node = new List<Null>();
		}
		liveId = json['live_id'];
		createTime = json['createTime'];
		contents = json['contents'];
		isTop = json['isTop'];
		endTime = json['endTime'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['introduces'] = this.introduces;
		data['pv'] = this.pv;
		data['title'] = this.title;
		data['content'] = this.content;
		data['points'] = this.points;
		data['playUrl'] = this.playUrl;
		data['ifCollect'] = this.ifCollect;
		data['clickNum'] = this.clickNum;
		data['startTime'] = this.startTime;
		if (this.playList != null) {
      data['play_list'] =  this.playList.map((v) => v.toJson()).toList();
    }
		data['id'] = this.id;
		data['image'] = this.image;
		data['cate'] = this.cate;
		data['address'] = this.address;
		data['isPay'] = this.isPay;
		data['introduce'] = this.introduce;
		data['author'] = this.author;
		data['dataFlag'] = this.dataFlag;
		data['updateTime'] = this.updateTime;
		data['catePath'] = this.catePath;
		data['cateString'] = this.cateString;
		data['isShow'] = this.isShow;
		if (this.node != null) {
      data['node'] =  [];
    }
		data['live_id'] = this.liveId;
		data['createTime'] = this.createTime;
		data['contents'] = this.contents;
		data['isTop'] = this.isTop;
		data['endTime'] = this.endTime;
		return data;
	}
}

class VideoDetailsInfoPlayList {
	String image;
	String author;
	String id;
	String title;
	String url;

	VideoDetailsInfoPlayList({this.image, this.author, this.id, this.title, this.url});

	VideoDetailsInfoPlayList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		author = json['author'];
		id = json['id'];
		title = json['title'];
		url = json['url'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['author'] = this.author;
		data['id'] = this.id;
		data['title'] = this.title;
		data['url'] = this.url;
		return data;
	}
}
