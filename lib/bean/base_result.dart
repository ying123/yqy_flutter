class BaseResult{
    dynamic info;
    dynamic status;
    String message;

    bool get tokenCancel => "0000" == status;

    @override
    String toString() {
        return 'BaseResult{info: $info, status: $status, message: $message}';
    }

    BaseResult(this.info, this.status, this.message);

    static BaseResult fromJsonMap(Map<String, dynamic> map) {
        if (map == null) return null;
        BaseResult articleBean = BaseResult(map['info'],map['status'],map['message']);
        return articleBean;
    }




    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['info'] = info;
        data['status'] = status;
        data['message'] = message;
        return data;
    }


}