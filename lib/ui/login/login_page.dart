import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'dart:async';

import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/login/bean/login_entity.dart';
import 'package:yqy_flutter/utils/regex_utils.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:fluwx/fluwx.dart' as fluwx;


class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Timer _timer;

  //倒计时数值
  var countdownTime = 0;


  final _formKey = GlobalKey<FormState>();
  String _phone = "", _smsCode,_type="sms";
  bool _isObscure = true;
  Color _eyeColor;
  List _loginMethod = [
    {
      "title": "facebook",
      "icon": Icons.account_circle,
    },
    {
      "title": "google",
      "icon":Icons.account_circle,
    },
    {
      "title": "twitter",
      "icon": Icons.account_circle,
    },
  ];


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
    return new Scaffold(
      backgroundColor: Colors.white,
        body: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                buildTitle(),
                buildTitleLine(),
                SizedBox(height: 70.0),
                buildEmailTextField(),
                SizedBox(height: 30.0),
                buildSmsRow(context),
                //    buildPasswordTextField(context),
                //buildForgetPasswordText(context),
                SizedBox(height: 60.0),
                buildLoginButton(context),
                SizedBox(height: 30.0),
             //   buildOtherLoginText(),
             //   buildOtherMethod(context),
                buildRegisterText(context),
                buildOtherMethod(context)
              ],
            )));
  }

  Align buildRegisterText(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('没有账号？'),
            GestureDetector(
              child: Text(
                '点击注册',
                style: TextStyle(color: Colors.blueAccent),
              ),
              onTap: () {
                //TODO 跳转到注册页面
                RRouter.push(context, Routes.registerPage,{});
                },
            ),
          ],
        ),
      ),
    );
  }

  ButtonBar buildOtherMethod(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: _loginMethod
          .map((item) => Builder(
        builder: (context) {
          return IconButton(
              icon: Icon(item['icon'],
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                //TODO : 第三方登录方法
                Scaffold.of(context).showSnackBar(new SnackBar(
                  content: new Text("${item['title']}登录"),
                  action: new SnackBarAction(
                    label: "取消",
                    onPressed: () {
                      fluwx
                          .sendWeChatAuth(
                          scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
                          .then((data) {});

                    },
                  ),
                ));
              });
        },
      ))
          .toList(),
    );
  }

  Align buildOtherLoginText() {
    return Align(
        alignment: Alignment.center,
        child: Text(
          '其他账号登录',
          style: TextStyle(color: Colors.grey, fontSize: 14.0),
        ));
  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 320.0,
        child: RaisedButton(
          child: Text(
            '登陆',
            style: Theme.of(context).primaryTextTheme.title,
          ),
          color: Colors.blueAccent,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              //TODO 执行登录方法
              print('email:$_phone , assword:$_smsCode');

              uploadLoginData();


            }
          },
          shape: StadiumBorder(side: BorderSide(color: Colors.blueAccent)),
        ),
      ),
    );
  }





  Padding buildForgetPasswordText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: FlatButton(
          child: Text(
            '忘记密码？',
            style: TextStyle(fontSize: 14.0, color: Colors.grey),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }


  Container buildSmsRow(BuildContext context){

    return Container(

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Expanded(

          child: buildPasswordTextField(context),

          ),

          SizedBox(width: 20,),


          InkWell(
            onTap: (){

              if(_phone.length>0&&RegexUtils.isChinaPhoneLegal(_phone)){
                //验证通过提交数据
                startCountdown();
              }else{
                showToast("手机号码格式不正确！");
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
     // obscureText: _isObscure,
      inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
      keyboardType: TextInputType.number,
      maxLength: 6,
      decoration: InputDecoration(
          labelText: '验证码',
         ),
      validator: (String value) {
        if(value.length==0){
          return "请输入验证码";
        }
        return null;
      },
      onSaved: (String value) => _smsCode = value,
    );
  }

  TextFormField buildEmailTextField() {
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
        return null;
      },
      onSaved: (String value) => _phone = value,
    );
  }

  Padding buildTitleLine() {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 4.0),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: Colors.blue,
          width: 40.0,
          height: 2.0,
        ),
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '水燕Med',
        style: TextStyle(fontSize: 42.0,color: Colors.blue),
      ),
    );
  }




  ///
  /// 发送短信验证请求
  ///
  void sendSmsRequest() {
    NetworkUtils.requestLoginSms(_phone)
        .then((res) {
      showToast(res.message);

    });
  }

    void uploadLoginData() {
    NetworkUtils.requestLogin(phone: _phone,pass: _smsCode,type: _type)
        .then((res){

      int statusCode = int.parse(res.status);


      if(statusCode==9999){

         UserUtils.saveUserInfo(LoginEntity.fromJson(res.info));
      //    print(UserUtils.getUserInfo().token);
          RRouter.push(context, Routes.homePage,{},clearStack: true);

      }else{

        showToast(res.message);

      }

    });


    }




}