class QuestionTaskEntity {
	String msg;
	int code;
	QuestionTaskInfo info;

	QuestionTaskEntity({this.msg, this.code, this.info});

	QuestionTaskEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new QuestionTaskInfo.fromJson(json['info']) : null;
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

class QuestionTaskInfo {
	int times;
	QuestionTaskInfoTask task;
	List<QuestionTaskInfoQuestionList> questionList;
	int id;
	String title;
	String content;

	QuestionTaskInfo({this.times, this.task, this.questionList, this.id, this.title, this.content});

	QuestionTaskInfo.fromJson(Map<String, dynamic> json) {
		times = json['times'];
		task = json['task'] != null ? new QuestionTaskInfoTask.fromJson(json['task']) : null;
		if (json['question_list'] != null) {
			questionList = new List<QuestionTaskInfoQuestionList>();(json['question_list'] as List).forEach((v) { questionList.add(new QuestionTaskInfoQuestionList.fromJson(v)); });
		}
		id = json['id'];
		title = json['title'];
		content = json['content'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['times'] = this.times;
		if (this.task != null) {
      data['task'] = this.task.toJson();
    }
		if (this.questionList != null) {
      data['question_list'] =  this.questionList.map((v) => v.toJson()).toList();
    }
		data['id'] = this.id;
		data['title'] = this.title;
		data['content'] = this.content;
		return data;
	}
}

class QuestionTaskInfoTask {
	int id;
	int points;

	QuestionTaskInfoTask({this.id, this.points});

	QuestionTaskInfoTask.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		points = json['points'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['points'] = this.points;
		return data;
	}
}

class QuestionTaskInfoQuestionList {
	int id;
	String title;
	int type;
	List<String> content;

	QuestionTaskInfoQuestionList({this.id, this.title, this.type, this.content});

	QuestionTaskInfoQuestionList.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		title = json['title'];
		type = json['type'];
		content = json['content']?.cast<String>();
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['title'] = this.title;
		data['type'] = this.type;
		data['content'] = this.content;
		return data;
	}
}
