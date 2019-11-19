class TaskQuestionEntity {
	String message;
	String status;
	TaskQuestionInfo info;

	TaskQuestionEntity({this.message, this.status, this.info});

	TaskQuestionEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		info = json['info'] != null ? new TaskQuestionInfo.fromJson(json['info']) : null;
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

class TaskQuestionInfo {
	String createTime;
	String answerNum;
	String dataFlag;
	String updateTime;
	String id;
	String title;
	List<TaskQuestionInfoList> xList;
	String content;
	String tid;
	String isShow;
	String points;

	TaskQuestionInfo({this.createTime, this.answerNum, this.dataFlag, this.updateTime, this.id, this.title, this.xList, this.content, this.tid, this.isShow, this.points});

	TaskQuestionInfo.fromJson(Map<String, dynamic> json) {
		createTime = json['createTime'];
		answerNum = json['answerNum'];
		dataFlag = json['dataFlag'];
		updateTime = json['updateTime'];
		id = json['id'];
		title = json['title'];
		if (json['list'] != null) {
			xList = new List<TaskQuestionInfoList>();(json['list'] as List).forEach((v) { xList.add(new TaskQuestionInfoList.fromJson(v)); });
		}
		content = json['content'];
		tid = json['tid'];
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
		if (this.xList != null) {
      data['list'] =  this.xList.map((v) => v.toJson()).toList();
    }
		data['content'] = this.content;
		data['tid'] = this.tid;
		data['isShow'] = this.isShow;
		data['points'] = this.points;
		return data;
	}
}

class TaskQuestionInfoList {
	String questionId;
	String question;
	String answer;
	String dataFlag;
	String id;
	String sort;
	String type;
	List<String> content;
	String points;

	TaskQuestionInfoList({this.questionId, this.question, this.answer, this.dataFlag, this.id, this.sort, this.type, this.content, this.points});

	TaskQuestionInfoList.fromJson(Map<String, dynamic> json) {
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
