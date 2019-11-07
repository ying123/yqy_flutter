class TaskListEntity {
	String message;
	String status;
	List<TaskListInfo> info;

	TaskListEntity({this.message, this.status, this.info});

	TaskListEntity.fromJson(Map<String, dynamic> json) {
		message = json['message'];
		status = json['status'];
		if (json['info'] != null) {
			info = new List<TaskListInfo>();(json['info'] as List).forEach((v) { info.add(new TaskListInfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['message'] = this.message;
		data['status'] = this.status;
		if (this.info != null) {
      data['info'] =  this.info.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class TaskListInfo {
	String tId;
	String endTime;
	String id;
	String title;
	String type;
	String points;
	String status;

	TaskListInfo({this.tId, this.endTime, this.id, this.title, this.type, this.points, this.status});

	TaskListInfo.fromJson(Map<String, dynamic> json) {
		tId = json['t_id'];
		endTime = json['end_time'];
		id = json['id'];
		title = json['title'];
		type = json['type'];
		points = json['points'];
		status = json['status'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['t_id'] = this.tId;
		data['end_time'] = this.endTime;
		data['id'] = this.id;
		data['title'] = this.title;
		data['type'] = this.type;
		data['points'] = this.points;
		data['status'] = this.status;
		return data;
	}
}
