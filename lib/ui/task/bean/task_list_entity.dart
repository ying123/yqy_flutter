class TaskListEntity {
	String msg;
	int code;
	TaskListInfo info;

	TaskListEntity({this.msg, this.code, this.info});

	TaskListEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new TaskListInfo.fromJson(json['info']) : null;
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

class TaskListInfo {
	int allTask;
	List<TaskListInfoTaskList> taskList;
	int completeTask;
	int points;

	TaskListInfo({this.allTask, this.taskList, this.completeTask, this.points});

	TaskListInfo.fromJson(Map<String, dynamic> json) {
		allTask = json['all_task'];
		if (json['task_list'] != null) {
			taskList = new List<TaskListInfoTaskList>();(json['task_list'] as List).forEach((v) { taskList.add(new TaskListInfoTaskList.fromJson(v)); });
		}
		completeTask = json['complete_task'];
		points = json['points'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['all_task'] = this.allTask;
		if (this.taskList != null) {
      data['task_list'] =  this.taskList.map((v) => v.toJson()).toList();
    }
		data['complete_task'] = this.completeTask;
		data['points'] = this.points;
		return data;
	}
}

class TaskListInfoTaskList {
	int beforeTid;
	int id;
	String title;
	int type;
	int points;
	int status;

	TaskListInfoTaskList({this.beforeTid, this.id, this.title, this.type, this.points, this.status});

	TaskListInfoTaskList.fromJson(Map<String, dynamic> json) {
		beforeTid = json['before_tid'];
		id = json['id'];
		title = json['title'];
		type = json['type'];
		points = json['points'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['before_tid'] = this.beforeTid;
		data['id'] = this.id;
		data['title'] = this.title;
		data['type'] = this.type;
		data['points'] = this.points;
		data['status'] = this.status;
		return data;
	}
}
