import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/utils/margin.dart';




class FeedBackPage extends StatefulWidget {
  @override
  _FeedBackPageState createState() => _FeedBackPageState();
}

class _FeedBackPageState extends State<FeedBackPage> {

  final _formKey = GlobalKey<FormState>();

  String _str; //反馈的内容

  String  _phone; //联系方式   可为空



  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          centerTitle: true,
          title: Text("意见反馈"),

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
                height: 200,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    cYM(10),

                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child:
                      Text("意见反馈",style: TextStyle(fontSize: 16,color: Colors.black),),

                    ),
                    Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child:  TextFormField(
                        maxLines: 7,
                        maxLengthEnforced:true,
                        autofocus: true,
                        onSaved: (String value) => _str = value,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "请输入反馈内容",
                        ),
                        validator: (v){
                          if(v.length==0){
                            return "反馈内容不能为空";
                          }
                          return null;
                          },
                      ) ,

                    )
                  ],

                ),


              ),

              cYM(15),

              new Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent,width: 1)
                ),
                height: 45,

                child: Row(

                  children: <Widget>[
                    cXM(10),
                    Text("联系方式",style: TextStyle(fontSize: 16,color: Colors.black),),
                    cXM(25),
                    Expanded(
                        child: TextFormField(
                          onSaved: (String value) => _phone = value,
                          keyboardType: TextInputType.number,
                          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "选填联系方式",
                              hintStyle: TextStyle(fontSize: 16)

                          ),


                        )

                    )


                  ],

                ),
              ),
              cYM(20),
              new  FlatButton(
                color: Colors.blue,
                highlightColor: Colors.blue[700],
                colorBrightness: Brightness.dark,
                splashColor: Colors.grey,
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  child: Text("提交",style: TextStyle(color: Colors.white,fontSize: 16),),

                ),
                shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                onPressed: () {
                  if((_formKey.currentState as FormState).validate()){
                    _formKey.currentState.save();
                    //验证通过提交数据
                    showToast(_str);

                  }
                },
              )

            ],

          ),)
        )

    );
  }
}
