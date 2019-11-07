class VideoListEntity {
	dynamic page;
	List<VideoListList> xList;


	@override
	String toString() {
		return 'VideoListEntity{page: $page, xList: $xList}';
	}

	VideoListEntity({this.page, this.xList});

	VideoListEntity.fromJson(Map<String, dynamic> json) {
		page = json['page'];
		if (json['list'] != null) {
			xList = new List<VideoListList>();(json['list'] as List).forEach((v) { xList.add(new VideoListList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['page'] = this.page;
		if (this.xList != null) {
      data['list'] =  this.xList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}



class VideoListList {
	dynamic image;
	dynamic startTime;
	dynamic id;
	dynamic title;

	String click_id;
	String clickNum;
	String type;
	String collectId;

	@override
	String toString() {
		return 'VideoListList{image: $image, startTime: $startTime, id: $id, title: $title}';
	}

	VideoListList({this.image, this.startTime, this.id, this.title,this.click_id, this.clickNum, this.type, this.collectId});

	VideoListList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		startTime = json['startTime'];
		id = json['id'];
		title = json['title'];
		click_id = json['click_id'];
		clickNum = json['clickNum'];
		type = json['type'];
		collectId = json['collectId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['startTime'] = this.startTime;
		data['id'] = this.id;
		data['title'] = this.title;
		data['click_id'] = this.click_id;
		data['clickNum'] = this.clickNum;
		data['type'] = this.type;
		data['collectId'] = this.collectId;
		return data;
	}
}
