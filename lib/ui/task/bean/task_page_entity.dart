class TaskPageEntity {
	String msg;
	int code;
	TaskPageInfo info;

	TaskPageEntity({this.msg, this.code, this.info});

	TaskPageEntity.fromJson(Map<String, dynamic> json) {
		msg = json['msg'];
		code = json['code'];
		info = json['info'] != null ? new TaskPageInfo.fromJson(json['info']) : null;
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

class TaskPageInfo {
	List<TaskPageInfoGoodsList> goodsList;
	int myPoints;
	List<TaskPageInfoTaskList> taskList;

	TaskPageInfo({this.goodsList, this.myPoints, this.taskList});

	TaskPageInfo.fromJson(Map<String, dynamic> json) {
		if (json['goods_list'] != null) {
			goodsList = new List<TaskPageInfoGoodsList>();(json['goods_list'] as List).forEach((v) { goodsList.add(new TaskPageInfoGoodsList.fromJson(v)); });
		}
		myPoints = json['my_points'];
		if (json['task_list'] != null) {
			taskList = new List<TaskPageInfoTaskList>();(json['task_list'] as List).forEach((v) { taskList.add(new TaskPageInfoTaskList.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.goodsList != null) {
      data['goods_list'] =  this.goodsList.map((v) => v.toJson()).toList();
    }
		data['my_points'] = this.myPoints;
		if (this.taskList != null) {
      data['task_list'] =  this.taskList.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class TaskPageInfoGoodsList {
	String image;
	int id;
	String title;
	String points;

	TaskPageInfoGoodsList({this.image, this.id, this.title, this.points});

	TaskPageInfoGoodsList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		id = json['id'];
		title = json['title'];
		points = json['points'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['id'] = this.id;
		data['title'] = this.title;
		data['points'] = this.points;
		return data;
	}
}

class TaskPageInfoTaskList {
	String image;
	int startTime;
	String descs;
	int endTime;
	int id;
	String title;
	int allTask;
	int completeTask;
	int points;
	int status;

	TaskPageInfoTaskList({this.image, this.startTime, this.descs, this.endTime, this.id, this.title, this.allTask, this.completeTask, this.points, this.status});

	TaskPageInfoTaskList.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		startTime = json['start_time'];
		descs = json['descs'];
		endTime = json['end_time'];
		id = json['id'];
		title = json['title'];
		allTask = json['all_task'];
		completeTask = json['complete_task'];
		points = json['points'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['start_time'] = this.startTime;
		data['descs'] = this.descs;
		data['end_time'] = this.endTime;
		data['id'] = this.id;
		data['title'] = this.title;
		data['all_task'] = this.allTask;
		data['complete_task'] = this.completeTask;
		data['points'] = this.points;
		data['status'] = this.status;
		return data;
	}
}
