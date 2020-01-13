class BaseResult{


  var info;
  int code;
  String msg;

  var status;
  var message;


  bool get tokenCancel => 300 == code;

  @override
  String toString() {
    return 'BaseResult{info: $info, code: $code, msg: $msg}';
  }

  BaseResult(this.info, this.code, this.msg);

  static BaseResult fromJsonMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BaseResult articleBean = BaseResult(map['info'],map['code'],map['msg']);
    return articleBean;
  }



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['info'] = info;
    data['code'] = code;
    data['msg'] = msg;
    return data;
  }








}