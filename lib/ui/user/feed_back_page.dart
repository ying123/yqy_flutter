import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



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
      backgroundColor: Colors.white,
        appBar: AppBar(

          centerTitle: true,
          title: Text("意见反馈"),

        ),

        body: Form(
          key: _formKey,
          child: new ListView(

            shrinkWrap: true,
            children: <Widget>[

              new  Container(
                //  height: ScreenUtil().setHeight(500),
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[

                    cYM(ScreenUtil().setHeight(10)),

                    Container(
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29), ScreenUtil().setHeight(71), 0, 0),
                      child:
                      Text("问题和意见",style: TextStyle(fontSize: ScreenUtil().setSp(40),color: Colors.black,fontWeight: FontWeight.bold),),
                    ),
                    new  Container(
                      constraints: BoxConstraints(
                        minHeight: ScreenUtil().setHeight(100),
                        maxHeight: ScreenUtil().setHeight(200),
                      ),
                      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(59), 0, ScreenUtil().setWidth(59), 0),
                      child:  TextFormField(
                        maxLines: 5,
                        maxLengthEnforced:true,
                        autofocus: true,
                        keyboardType: TextInputType.text,
                        onSaved: (String value) => _str = value,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "请简要描述您要反馈的问题和意见",
                            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35))
                        ),
                        style: TextStyle(color: Colors.black45,fontSize: setSP(42)),
                        validator: (v){
                          if(v.length==0){
                            return "";
                          }
                          return null;
                        },
                      ) ,

                    ),

                /*    new Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(59)),
                      width: ScreenUtil().setWidth(228),
                      height: ScreenUtil().setHeight(179),
                      child: Icon(Icons.add_photo_alternate,size:ScreenUtil().setWidth(200),),

                    ),*/



                  ],

                ),


              ),

              cYM(15),
              new Container(
                height: ScreenUtil().setHeight(12),
                color: Color(0xFFF5F5F5),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29), ScreenUtil().setHeight(71), 0, 0),
                child:
                Text("联系方式",style: TextStyle(fontSize: ScreenUtil().setSp(40),color: Colors.black,fontWeight: FontWeight.bold),),
              ),
              new Container(
                height: ScreenUtil().setHeight(100),

                child: Row(

                  children: <Widget>[
                    cXM(ScreenUtil().setWidth(59)),
                    Expanded(
                        child: TextFormField(
                          onSaved: (String value) => _phone = value,
                          keyboardType: TextInputType.phone,
                          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "请留下您的手机号码",
                              hintStyle: TextStyle(fontSize: ScreenUtil().setSp(35),color: Color(0xFF999999))
                          ),
                          style: TextStyle(color: Colors.black45,fontSize: setSP(42)),
                        )
                    )
                  ],

                ),
              ),
              cYM(ScreenUtil().setHeight(30)),
              new Container(
                height: ScreenUtil().setHeight(12),
                color: Color(0xFFF5F5F5),
              ),
              cYM(ScreenUtil().setHeight(80)),
             new InkWell(
                child:     new  Container(
                  margin:EdgeInsets.fromLTRB(ScreenUtil().setWidth(248), 0, ScreenUtil().setWidth(248), 0),
                  width: ScreenUtil().setWidth(585),
                  height: ScreenUtil().setHeight(100),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF68E0CF),Color(0xFF209CFF)],begin: Alignment.topCenter,end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(43)))
                  ),
                  alignment: Alignment.center,
                  child: Text("提 交",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),),


                ),
                onTap: (){
                  if((_formKey.currentState as FormState).validate()){
                    _formKey.currentState.save();
                    //验证通过提交数据
                    NetUtils.requestFeedbackAdd(_str,_phone)
                        .then((res){


                      FLToast.info(text:res.msg);

                      if(res.code==200){
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

          ),
        )

    );
  }
}
