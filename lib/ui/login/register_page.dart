import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/login/bean/login_entity.dart';
import 'package:yqy_flutter/utils/regex_utils.dart';
import 'package:yqy_flutter/utils/user_utils.dart';



class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey _formKey= new GlobalKey<FormState>();

  int code = 1; // 表示当前注册的类型   1  医生    2  推广经理   默认为医生

  String _name;

  String _hos;

  String _sms; // 验证码

  String _phone = "";//手机号


  Timer _timer;
  //倒计时数值
  var countdownTime = 0;

  //倒计时方法
  startCountdown() {
    //倒计时时间
    countdownTime = 60;
    final call = (timer) {
      if (countdownTime < 1) {
        _timer.cancel();
      } else {
        setState(() {
          countdownTime -= 1;
        });
      }
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);

    sendSmsRequest();

  }


  String handleCodeAutoSizeText() {
    if (countdownTime > 0) {
      return "${countdownTime}s后重新获取";
    }
    return "获取验证码";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_timer!=null){
      _timer.cancel();
    }
  }
  @override
  Widget build(BuildContext context) {
    return   new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("注册"),
        ),
        body: Padding(padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey ,
              child:  ListView(
                children: <Widget>[

                  SizedBox(height: 10,),
                  buildTopSele(context),
                  SizedBox(height: 10,),
                  buildNameET(context),
                  buildHosET(context),
                  buildMobileET(context),
                  buildSmsRow(context),
                  SizedBox(height: 40,),
                  buildSubBtn(context),
                  SizedBox(height: 5,),
                  buildTipText(context),
                  SizedBox(height: 30,),
                  buildAgreementText(context),

                ],

              ),)
        )
    );
  }

Widget  buildTopSele(BuildContext context) {

    return Flex(
      direction:  Axis.horizontal,
      children: <Widget>[
         new Expanded(
           flex: 1,
           child: InkWell(
             onTap: (){

               if(code!=1){
                 setState(() {
                   code = 1;
                 });
               }
             },
             child: Container(
               decoration: BoxDecoration(
                 border: Border.all(color:code==1?Colors.blueAccent:Colors.black12,width: 1.2),
                 borderRadius: BorderRadius.all(Radius.circular(5)),
                 color:code==1?Colors.blue[100]:Colors.white
               ),
               height: 115,
               child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Image.asset("assets/imgs/icon_doctor.png",width: 30,height: 30,),
                   Text("医生",style: TextStyle(color: Colors.blueAccent),)
                 ],
               ),
             ),
           )

         ),
         SizedBox(width: 10,),
        new Expanded(
          flex: 1,
          child:InkWell(
            onTap: (){

              if(code!=2){
                setState(() {
                  code = 2;
                });
              }
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color:code==2?Colors.blueAccent:Colors.black12,width: 1.2),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color:code==2?Colors.blue[100]:Colors.white
              ),
              height: 115,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset("assets/imgs/icon_representative.png",width: 30,height: 30,),
                  Text("推广经理",style: TextStyle(color: Colors.blueAccent),)
                ],
              ),
            ),
          )

        ),
      ],

    );

  }

  Widget buildNameET(BuildContext context) {

    return  TextFormField(
        autofocus: true,
      //  controller: _nameController,
        decoration: InputDecoration(
          labelText: "姓名",
          hintText: "输入您的姓名",
        ),
      onSaved: (String value) => _name = value,
        // 校验用户名
        validator: (v) {
          return v
              .trim()
              .length > 0 ? null : "姓名不能为空";
        }

    );
  }

 Widget buildHosET(BuildContext context) {
   return TextFormField(
        autofocus: true,
    //    controller: _hosController,
       onSaved: (String value) => _hos = value,
        decoration: InputDecoration(
          labelText: "医院",
          hintText: "输入您所在医院名称",
        ),
        // 校验用户名
        validator: (v) {
          return v
              .trim()
              .length > 0 ? null : "医院不能为空";
        }

    );
  }

 Widget buildMobileET(BuildContext context) {

   return TextFormField(
     onChanged: (v){
       _phone = v;
     },
     inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
     maxLength: 11,
     keyboardType: TextInputType.number,
     decoration: InputDecoration(
       labelText: '手机号',
     ),
     validator: (String value) {
       if(value.length==0){
         return "请输入手机号";
       }

       if(!RegexUtils.isChinaPhoneLegal(value)){
         return "手机号码格式不正确";

       }

       return null;
     },
  //   onSaved: (String value) => _email = value,
   );


  }
  Container buildSmsRow(BuildContext context){

    return Container(

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[

          Expanded(
            child: buildPasswordTextField(context),
          ),
          SizedBox(width: 20,),

          InkWell(
            onTap: (){

              if(countdownTime==0){
                if(_phone.length>0&&RegexUtils.isChinaPhoneLegal(_phone)){
                  //验证通过提交数据
                  startCountdown();
                }else{
                    showToast("手机号码格式不正确！");
                }
              }
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueAccent)
              ),
              alignment: Alignment.center,
              height: 40,
              child: Padding(padding:EdgeInsets.fromLTRB(10, 0, 10, 0) ,child: Text(handleCodeAutoSizeText(),style: TextStyle(color: Colors.blueAccent),),),

            ) ,
          )

          //buildPasswordTextField(context),

        ],

      ),

    );

  }

  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _sms = value,
      keyboardType: TextInputType.number,
      inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
      decoration: InputDecoration(
        labelText: '验证码',
      ),
      validator: (v){
        if(v.length==0){
          return "验证码不能为空";
        }
        return null;
      },
    );
  }

 Widget buildSubBtn(BuildContext context) {
    return   FlatButton(
      color: Colors.blue,
      highlightColor: Colors.blue[700],
      colorBrightness: Brightness.dark,
      splashColor: Colors.grey,
      child: Container(
        alignment: Alignment.center,
        height: 50,
        child: Text("注册",style: TextStyle(color: Colors.white,fontSize: 16),),
      ),
      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      onPressed: () {
        if((_formKey.currentState as FormState).validate()){
          //验证通过提交数据
          (_formKey.currentState as FormState).save();

              uploadData();

        }


      },
    );


 }


 ///
  /// 发送短信验证请求
  ///
  void sendSmsRequest() {

    NetworkUtils.requestRegisterSms(_phone)
        .then((res){
          showToast(res.message);

    });

  }

  void uploadData() {

    NetworkUtils.requestRegister(regType:code.toString(),realName: _name,phone: _phone,h_name: _hos,code: _sms,h_id: "0")
        .then((res){
      //showToast(res.message);

      int statusCode = int.parse(res.status);


      if(statusCode==9999){

        UserUtils.saveUserInfo(LoginEntity.fromJson(res.info));

        RRouter.push(context, Routes.homePage,{},clearStack: true);

      }


    });


  }

 Widget buildTipText(BuildContext context) {

    return Text("一旦注册不可更改身份",style: TextStyle(fontSize: 14,color: Colors.black45),);

  }

 Widget buildAgreementText(BuildContext context) {


   return Container(


     child: Row(

       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[

       Text("点击注册即表示同意",style: TextStyle(fontSize: 14,color: Colors.black45),),

       InkWell(

         onTap: (){
           RRouter.push(context, Routes.webPage,{"url":APPConfig.Agreement,"title":"用户协议"});
         },
         child:   Text("《用户注册协议》",style: TextStyle(fontSize: 14,color: Colors.blueAccent),),


       )



       ],


     ),


    );

  }



}
