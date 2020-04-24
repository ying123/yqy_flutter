class IntegralListEntity {
  int code;
  String msg;
  Info info;

  IntegralListEntity({this.code, this.msg, this.info});

  IntegralListEntity.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    info = json['info'] != null ? new Info.fromJson(json['info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.info != null) {
      data['info'] = this.info.toJson();
    }
    return data;
  }
}

class Info {
  int add;
  int minus;
  List<Data> data;

  Info({this.add, this.minus, this.data});

  Info.fromJson(Map<String, dynamic> json) {
    add = json['add'];
    minus = json['minus'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['add'] = this.add;
    data['minus'] = this.minus;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  int dataId;
  int dataSrc;
  int payType;
  String createTime;
  int money;
  int userMoney;
  String remark;

  Data(
      {this.id,
        this.dataId,
        this.dataSrc,
        this.payType,
        this.createTime,
        this.money,
        this.userMoney,
        this.remark});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    dataId = json['dataId'];
    dataSrc = json['dataSrc'];
    payType = json['payType'];
    createTime = json['create_time'];
    money = json['money'];
    userMoney = json['userMoney'];
    remark = json['remark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['dataId'] = this.dataId;
    data['dataSrc'] = this.dataSrc;
    data['payType'] = this.payType;
    data['create_time'] = this.createTime;
    data['money'] = this.money;
    data['userMoney'] = this.userMoney;
    data['remark'] = this.remark;
    return data;
  }
}