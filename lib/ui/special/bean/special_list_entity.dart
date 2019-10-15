class SpecialListEntity {
	List<SpecilaListList> lists;
	var page;
	var nowPage;


	@override
	String toString() {
		return 'SpecialListEntity{lists: $lists, page: $page, nowPage: $nowPage}';
	}

	SpecialListEntity({this.lists, this.page, this.nowPage});

	SpecialListEntity.fromJson(Map<String, dynamic> json) {
		if (json['lists'] != null) {
			lists = new List<SpecilaListList>();(json['lists'] as List).forEach((v) { lists.add(new SpecilaListList.fromJson(v)); });
		}
		page = json['page'];
		nowPage = json['now_page'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.lists != null) {
      data['lists'] =  this.lists.map((v) => v.toJson()).toList();
    }
		data['page'] = this.page;
		data['now_page'] = this.nowPage;
		return data;
	}
}

class SpecilaListList {
	var image;
	var id;
	var title;
	var isShow;
	var isTop;
	var type;
	SpecilaListList({this.image, this.id, this.title, this.isShow, this.isTop,this.type});

	SpecilaListList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		id = json['id'];
		title = json['title'];
		isShow = json['is_show'];
		isTop = json['is_top'];
		type = json['type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['id'] = this.id;
		data['title'] = this.title;
		data['is_show'] = this.isShow;
		data['is_top'] = this.isTop;
		data['type'] = this.type;
		return data;
	}
}
