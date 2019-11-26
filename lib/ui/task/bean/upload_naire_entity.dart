 class UploadQuestionBean {

   String tid;
   String token;
   List<answer> answe;

   UploadQuestionBean({this.tid, this.token, this.answe});

   UploadQuestionBean.fromJson(Map<String, dynamic> json) {
     tid = json['tid'];
     token = json['token'];
     if (json['answer'] != null) {
       answe = new List<answer>();(json['answer'] as List).forEach((v) { answe.add(new answer.fromJson(v)); });
     }
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['tid'] = this.tid;
     data['token'] = this.token;
     if (this.answe != null) {
       data['answer'] =  this.answe.map((v) => v.toJson()).toList();
     }
     return data;
   }
 }




 class answer {
   String id;
   String value;

   answer({this.id, this.value});

   answer.fromJson(Map<String, dynamic> json) {
     id = json['id'];
     value = json['value'];
   }

   Map<String, dynamic> toJson() {
     final Map<String, dynamic> data = new Map<String, dynamic>();
     data['id'] = this.id;
     data['value'] = this.value;
     return data;
   }


 }