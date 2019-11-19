class TaskVideoEntity {
	String message;
	String status;
	TaskVideoInfo info;

	TaskVideoEntity({this.message, this.status, this.info});

	TaskVideoEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new TaskVideoInfo.fromJson(json['info']) : null;
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

class TaskVideoInfo {
	String vid;
	String playUrl;
	List<TaskVideoInfoQuestionList> questionList;
	TaskVideoInfoQuestionInfo questionInfo;
	String id;
	String time;
	String pic;
	String title;
	String qid;
	String tid;
	String content;
	String playTime;

	TaskVideoInfo({this.vid, this.playUrl, this.questionList, this.questionInfo, this.id, this.time, this.pic, this.title, this.qid, this.tid, this.content, this.playTime});

	TaskVideoInfo.fromJson(Map<String, dynamic> json) {
		vid = json['vid'];
		playUrl = json['play_url'];
		if (json['question_list'] != null) {
			questionList = new List<TaskVideoInfoQuestionList>();(json['question_list'] as List).forEach((v) { questionList.add(new TaskVideoInfoQuestionList.fromJson(v)); });
		}
		questionInfo = json['question_info'] != null ? new TaskVideoInfoQuestionInfo.fromJson(json['question_info']) : null;
		id = json['id'];
		time = json['time'];
		pic = json['pic'];
		title = json['title'];
		qid = json['qid'];
		tid = json['tid'];
		content = json['content'];
		playTime = json['play_time'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['vid'] = this.vid;
		data['play_url'] = this.playUrl;
		if (this.questionList != null) {
      data['question_list'] =  this.questionList.map((v) => v.toJson()).toList();
    }
		if (this.questionInfo != null) {
      data['question_info'] = this.questionInfo.toJson();
    }
		data['id'] = this.id;
		data['time'] = this.time;
		data['pic'] = this.pic;
		data['title'] = this.title;
		data['qid'] = this.qid;
		data['tid'] = this.tid;
		data['content'] = this.content;
		data['play_time'] = this.playTime;
		return data;
	}
}

class TaskVideoInfoQuestionList {
	String questionId;
	String question;
	String answer;
	String dataFlag;
	String id;
	String sort;
	String type;
	List<String> content;
	String points;

	TaskVideoInfoQuestionList({this.questionId, this.question, this.answer, this.dataFlag, this.id, this.sort, this.type, this.content, this.points});

	TaskVideoInfoQuestionList.fromJson(Map<String, dynamic> json) {
		questionId = json['questionId'];
		question = json['question'];
		answer = json['answer'];
		dataFlag = json['dataFlag'];
		id = json['id'];
		sort = json['sort'];
		type = json['type'];
		content = json['content']?.cast<String>();
		points = json['points'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['questionId'] = this.questionId;
		data['question'] = this.question;
		data['answer'] = this.answer;
		data['dataFlag'] = this.dataFlag;
		data['id'] = this.id;
		data['sort'] = this.sort;
		data['type'] = this.type;
		data['content'] = this.content;
		data['points'] = this.points;
		return data;
	}
}

class TaskVideoInfoQuestionInfo {
	String createTime;
	String answerNum;
	String dataFlag;
	String updateTime;
	String id;
	String title;
	String content;
	String isShow;
	String points;

	TaskVideoInfoQuestionInfo({this.createTime, this.answerNum, this.dataFlag, this.updateTime, this.id, this.title, this.content, this.isShow, this.points});

	TaskVideoInfoQuestionInfo.fromJson(Map<String, dynamic> json) {
		createTime = json['createTime'];
		answerNum = json['answerNum'];
		dataFlag = json['dataFlag'];
		updateTime = json['updateTime'];
		id = json['id'];
		title = json['title'];
		content = json['content'];
		isShow = json['isShow'];
		points = json['points'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['createTime'] = this.createTime;
		data['answerNum'] = this.answerNum;
		data['dataFlag'] = this.dataFlag;
		data['updateTime'] = this.updateTime;
		data['id'] = this.id;
		data['title'] = this.title;
		data['content'] = this.content;
		data['isShow'] = this.isShow;
		data['points'] = this.points;
		return data;
	}
}
