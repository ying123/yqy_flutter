import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/login/bean/send_sms_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:yqy_flutter/widgets/cell_input.dart';

class LoginSendSmsPage extends StatefulWidget {

  String phone;


  LoginSendSmsPage(this.phone);

  @override
  _LoginSendSmsPageState createState() => _LoginSendSmsPageState();
}

class _LoginSendSmsPageState extends State<LoginSendSmsPage> {

  SendSmsInfo _smsInfo,_loginInfo;


   int    userStatus;  // 当前登录的用户状态  1已注册直接登录 2未注册完善资料

  Timer _timer;

  //倒计时数值
  var countdownTime = 0;
  GlobalKey<TextWidgetState> textKey = GlobalKey();

  StreamSubscription changeSubscription;  //验证码输入完成通知
  StreamSubscription changeSubscription2;  // 重新获取验证码通知
  //倒计时方法
  startCountdown() {
    requestSendSmsData();
    //倒计时时间
    countdownTime = 60;
    final call = (timer) {
      if (countdownTime < 1) {
        _timer.cancel();
      } else {
        countdownTime -= 1;
        textKey.currentState.onPressed(handleCodeAutoSizeText());
      }
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);
  }

  String handleCodeAutoSizeText() {
    if (countdownTime > 0) {
      return "${countdownTime}秒后重新获取验证码";
    }
    return "重新获取验证码";
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(mounted){
      startCountdown();
      initEventLoginListener();
    }
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_timer!=null){
      _timer.cancel();
    }
    changeSubscription.cancel();
    changeSubscription2.cancel();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        titleSpacing: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios,color: Colors.black54,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(80)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            cYM(ScreenUtil().setHeight(40)),
            Text("输入验证码",style: TextStyle(color: Colors.black87,fontSize: ScreenUtil().setSp(75)),),
            cYM(ScreenUtil().setHeight(15)),
            Text("验证码已发送至 +86 "+widget.phone,style: TextStyle(color: Colors.black87,fontSize: ScreenUtil().setSp(35)),),
            cYM(ScreenUtil().setHeight(80)),
            new  CellInput(
                key: UniqueKey(),
                autofocus: true,
                inputType: InputType.number,
                solidColor: Color(0xFFF5F6FB),
                borderRadius: BorderRadius.circular(4),
                inputCompleteCallback: (v) {

                  // 发起登陆请求
                  eventBus.fire(new EventBusChange(v));

                }),
            cYM(ScreenUtil().setHeight(80)),
            TextWidget(textKey),


          ],
        ),
      )

    );
  }

  buildMobileInputView(BuildContext context) {

    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(135), 0, 0, 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("login/ic_user.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        cXM(ScreenUtil().setWidth(42)),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "输入手机号",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
           // border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
        )),
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(135), 0),
          width:   ScreenUtil().setWidth(40),
          height:   ScreenUtil().setWidth(40),
          child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),

      ],

    );

  }

  buildLine() {

    return Container(
      width: ScreenUtil().setWidth(861),
      color: Color(0xFFDDDDDD),
      height: ScreenUtil().setHeight(1),
    );

  }

  ///
  ///  发送短信
  ///
  void requestSendSmsData() {

    NetUtils.requestSmsCode(widget.phone)
        .then((res){
          if(res.code==200){

              userStatus =  res.info["status"];

          }else{
            
            showToast(res.msg);
          }

    });



  }
  ///
  ///  登录请求
  ///
  void requestLoginData(BuildContext context,String phone, String code,int status) {

      print(code+phone+status.toString());

    NetUtils.requestSmsLogin(phone,code,status.toString())
        .then((res){


        if(res.code==200){

          _loginInfo = SendSmsInfo.fromJson(res.info);

          //已注册直接登录
          if(status == 1){
            UserUtils.saveToken(_loginInfo.token.toString());
            RRouter.push(context, Routes.homePage, {"phone":phone,"code":code},clearStack: true);
         // 未注册完善资料
          }else{
            RRouter.push(context, Routes.perfectInfoPage, {"phone":phone,"code":code},clearStack: false);
          }

        }else{

          showToast(res.msg);
        }


    });

  }

  void initEventLoginListener() {


    changeSubscription =  eventBus.on<EventBusChange>().listen((event) {

      requestLoginData(context,widget.phone,event.url,userStatus);

    });

    changeSubscription2 =  eventBus2.on<EventBusChange2>().listen((event) {
        startCountdown();
    });

  }
}


class TextWidget extends StatefulWidget {
  TextWidget(Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TextWidgetState();
  }
}

class TextWidgetState extends State<TextWidget> {
  String _text="60秒后重新获取验证码";

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: (){
        eventBus2.fire(EventBusChange2(""));
      },
      child: Text(_text,style: TextStyle(color: Colors.black87,fontSize: ScreenUtil().setSp(35)),),
    );
  }

  void onPressed(String count) {
    setState(() {
      _text = count.toString();
    });
  }
}
