class LawsDeailsEntity {
	String message;
	String status;
	LawsDeailsInfo info;

	LawsDeailsEntity({this.message, this.status, this.info});

	LawsDeailsEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new LawsDeailsInfo.fromJson(json['info']) : null;
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

class LawsDeailsInfo {
	List<LawsDeailsInfoChapter> chapter;
	String lawsId;
	String title;

	LawsDeailsInfo({this.chapter, this.lawsId, this.title});

	LawsDeailsInfo.fromJson(Map<String, dynamic> json) {
		if (json['chapter'] != null) {
			chapter = new List<LawsDeailsInfoChapter>();(json['chapter'] as List).forEach((v) { chapter.add(new LawsDeailsInfoChapter.fromJson(v)); });
		}
		lawsId = json['lawsId'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.chapter != null) {
      data['chapter'] =  this.chapter.map((v) => v.toJson()).toList();
    }
		data['lawsId'] = this.lawsId;
		data['title'] = this.title;
		return data;
	}
}

class LawsDeailsInfoChapter {
	String chapter;
	String chapterId;
	List<LawsDeailsInfoChapterRegulation> regulations;

	LawsDeailsInfoChapter({this.chapter, this.chapterId, this.regulations});

	LawsDeailsInfoChapter.fromJson(Map<String, dynamic> json) {
		chapter = json['chapter'];
		chapterId = json['chapterId'];
		if (json['regulations'] != null) {
			regulations = new List<LawsDeailsInfoChapterRegulation>();(json['regulations'] as List).forEach((v) { regulations.add(new LawsDeailsInfoChapterRegulation.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['chapter'] = this.chapter;
		data['chapterId'] = this.chapterId;
		if (this.regulations != null) {
      data['regulations'] =  this.regulations.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class LawsDeailsInfoChapterRegulation {
	String regulationsId;
	String noun;
	String content;

	LawsDeailsInfoChapterRegulation({this.regulationsId, this.noun, this.content});

	LawsDeailsInfoChapterRegulation.fromJson(Map<String, dynamic> json) {
		regulationsId = json['regulationsId'];
		noun = json['noun'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['regulationsId'] = this.regulationsId;
		data['noun'] = this.noun;
		data['content'] = this.content;
		return data;
	}
}
