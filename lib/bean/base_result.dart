class BaseResult{
    dynamic info;
    dynamic data; //新增  之前的info字段改为 data
    dynamic status;
    dynamic code;//新增  之前的status字段改为 code
    String message;

    bool get tokenCancel => "0000" == status;


    @override
    String toString() {
        return 'BaseResult{info: $info, data: $data, status: $status, message: $message}';
    }

    BaseResult(this.info,this.data, this.status, this.code, this.message);

    static BaseResult fromJsonMap(Map<String, dynamic> map) {
        if (map == null) return null;
        BaseResult articleBean = BaseResult(map['info'],map['data'],map['status'],map['code'],map['message']);
        return articleBean;
    }




    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['info'] = info;
        data['status'] = status;
        data['code'] = code;
        data['message'] = message;
        data['data'] = data;
        return data;
    }


}