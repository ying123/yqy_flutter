class SpecialVideoEntity {
  var image;
  var pv;
  var videoId;
  var playUrl;
  var createTime;
	var type;
  var title;
  var content;
	var contents;
	var isTop;
	var isShow;
	var sid;
	var id;
	var cid;
	var status;

	SpecialVideoEntity({this.contents,this.image, this.pv, this.videoId, this.playUrl, this.createTime, this.type, this.title, this.content, this.isTop, this.isShow, this.sid, this.id, this.cid, this.status});

	SpecialVideoEntity.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		pv = json['pv'];
		videoId = json['video_id'];
		playUrl = json['play_url'];
		createTime = json['create_time'];
		type = json['type'];
		title = json['title'];
		content = json['content'];
		isTop = json['is_top'];
		isShow = json['is_show'];
		sid = json['sid'];
		id = json['id'];
		cid = json['cid'];
		status = json['status'];
		contents = json['contents'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['pv: null'] = this.pv;
		data['video_id:'] = this.videoId;
		data['play_url'] = this.playUrl;
		data['create_time'] = this.createTime;
		data['type'] = this.type;
		data['title'] = this.title;
		data['content'] = this.content;
		data['is_top'] = this.isTop;
		data['is_show'] = this.isShow;
		data['sid'] = this.sid;
		data['id'] = this.id;
		data['cid'] = this.cid;
		data['status'] = this.status;
		data['contents'] = this.contents;
		return data;
	}
}
