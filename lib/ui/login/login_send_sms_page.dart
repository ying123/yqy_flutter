import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/cell_input.dart';

class LoginSendSmsPage extends StatefulWidget {
  @override
  _LoginSendSmsPageState createState() => _LoginSendSmsPageState();
}

class _LoginSendSmsPageState extends State<LoginSendSmsPage> {

  Timer _timer;

  //倒计时数值
  var countdownTime = 0;
  GlobalKey<TextWidgetState> textKey = GlobalKey();

  //倒计时方法
  startCountdown() {
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
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if(_timer!=null){
      _timer.cancel();
    }
  }

  ///
  /// 发送短信验证请求
  ///
  void sendSmsRequest() {
   /* NetworkUtils.requestLoginSms("")
        .then((res) {
      showToast(res.message);

    });*/
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body: Container(
        margin: EdgeInsets.only(top: ScreenUtil().setHeight(100)),
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(80)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            cYM(ScreenUtil().setHeight(200)),
            Text("输入验证码",style: TextStyle(color: Colors.black87,fontSize: ScreenUtil().setSp(75)),),
            cYM(ScreenUtil().setHeight(15)),
            Text("验证码已发送至 +86 178 6593 7635",style: TextStyle(color: Colors.black87,fontSize: ScreenUtil().setSp(35)),),
            cYM(ScreenUtil().setHeight(80)),
            new  CellInput(
                key: UniqueKey(),
                autofocus: true,
                inputType: InputType.number,
                solidColor: Color(0xFFF5F6FB),
                borderRadius: BorderRadius.circular(4),
                inputCompleteCallback: (v) {
                  print(v);
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
    return Text(_text,style: TextStyle(color: Colors.black87,fontSize: ScreenUtil().setSp(35)),);
  }

  void onPressed(String count) {
    setState(() {
      _text = count.toString();
    });
  }
}
