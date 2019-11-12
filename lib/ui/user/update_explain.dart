import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';

///
///   修改  个人简介页面
///
class UpdateExplainPage extends StatefulWidget {
  @override
  _UpdateExplainPageState createState() => _UpdateExplainPageState();
}

class _UpdateExplainPageState extends State<UpdateExplainPage> {

  final _formKey = GlobalKey<FormState>();

  String _str; //反馈的内容


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          centerTitle: true,
          title: Text("个人简介"),

        ),

        body: Padding(padding: EdgeInsets.all(20),

            child: Form(
              key: _formKey,
              child: new Column(

                children: <Widget>[

                  new  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueAccent,width: 1)
                    ),
                    height: 150,
                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: <Widget>[

                        cYM(10),

                        Container(
                          padding: EdgeInsets.only(left: 10),
                          child:
                          Text("个人简介",style: TextStyle(fontSize: 16,color: Colors.black),),

                        ),
                        Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          child:  TextFormField(
                            maxLength: 15,
                            maxLengthEnforced:true,
                            autofocus: true,
                            onSaved: (String value) => _str = value,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请输入内容",
                              hintStyle: TextStyle(color: Colors.black26)
                            ),
                            validator: (v){
                              if(v.length==0){
                                return "内容不能为空";
                              }
                              return null;
                            },
                          ) ,

                        )
                      ],

                    ),


                  ),

                  cYM(15),

                  new  FlatButton(
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text("保存",style: TextStyle(color: Colors.white,fontSize: 16),),
                    ),
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {

                      if((_formKey.currentState as FormState).validate()){
                        _formKey.currentState.save();
                        //验证通过提交数据
                        NetworkUtils.requestEditUserInfo(UserUtils.getUserInfo().userId,_str)
                            .then((res){

                          showToast(res.message);

                          if(res.status=="9999"){

                            // 延时1s执行返回
                            Future.delayed(Duration(seconds: 1), (){
                              Navigator.of(context).pop();
                            });
                          }
                        });


                      }
                    },
                  )

                ],

              ),)
        )

    );
  }
}
