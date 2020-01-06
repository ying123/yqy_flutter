import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sharesdk_plugin/sharesdk_plugin.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/regex_utils.dart';
import 'package:fluwx/fluwx.dart' as fluwx;


class LoginHomePage extends StatefulWidget {
  @override
  _LoginHomePageState createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {

  int loginType = 0;// 当前的登陆方式 0 获取验证码  1 密码  默认0

  bool  pwdShow = false ;// 是否显示密码输入框

  String _phone = "";// 手机号码


  final _formKey = GlobalKey<FormState>();

  TextEditingController _phoneController = new TextEditingController();


  TextEditingController _pwdController = new TextEditingController();

  String pwd; // 密码


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initControllerListener();

  }

  void initControllerListener() {


    _pwdController.addListener((){

     setState(() {
       pwd = _phoneController.text;
     });

    });

  }


  void sendAuth({
    @required ValueChanged<fluwx.WeChatAuthResponse> onAuthResp,
    String openId,
  }) async {
    await fluwx.sendWeChatAuth(
      scope: 'snsapi_userinfo',
      openId: openId,
      state: '${DateTime.now().millisecondsSinceEpoch}',
    );
    StreamSubscription subscription;
    var callback = (fluwx.WeChatAuthResponse resp) {
      subscription?.cancel();
      onAuthResp(resp);
    };
    subscription = fluwx.responseFromAuth.listen(callback);
  }

  @override
  Widget build(BuildContext context) {
    return  new  Scaffold(
    backgroundColor: Colors.white,
      body: Stack(

        children: <Widget>[

        Form(
            key: _formKey,
            child:  new   ListView(

          children: <Widget>[
            new  Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                cYM(ScreenUtil().setHeight(260)),
                Text("欢迎来到药企源",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(65),fontWeight: FontWeight.bold),),
                cYM(ScreenUtil().setHeight(160)),
                // 手机号输入
                buildMobileInputView(context),
                buildLine(),
                cYM(ScreenUtil().setHeight(36)),
                buildTipView(),
                Visibility(visible: loginType==0?false:true,child:    buildLine()),
                cYM(ScreenUtil().setHeight(73)),
                buildBtnLoginView(context),
                cYM(ScreenUtil().setHeight(10)),
                buildPwdLoginView(context),
                cYM(ScreenUtil().setHeight(330)),
                buildTipView2(),
                cYM(ScreenUtil().setHeight(46)),
                // 其他登陆方式
                buildOtherLoginView(context),
              ],
            )

          ],

        ))


        ],
      ),

    );

  }

  buildMobileInputView(BuildContext context) {

    return   new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(135), 0, 0, 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("login/ic_user.png"),width:  ScreenUtil().setWidth(56),height: ScreenUtil().setWidth(60),fit: BoxFit.fill,),
        ),
        cXM(ScreenUtil().setWidth(42)),
        Expanded(
            child: TextFormField(
          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          maxLength: 11,
          decoration: InputDecoration(
            hintText: "输入手机号",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(46)),
            border: InputBorder.none, // 去除下划线
            counterText: "",//此处控制最大字符是否显示
          ),
              onSaved: (v){
                _phone = v;
              },
         validator: (String value) {
           if(value.length==0){
             showToast("请输入手机号");
             return null;
             }
           if(!RegexUtils.isChinaPhoneLegal(value)){
             showToast("手机号码格式不正确");
             return null;
           }
             return null;
         },
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(50)),
        )),
        InkWell(
          onTap: (){
            setState(() {
              _phoneController.text="";
            });
          },
          child:  Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(135), 0),
            width:   ScreenUtil().setWidth(40),
            height:   ScreenUtil().setWidth(40),
            child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
          ),

        )

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

  buildBtnLoginView(BuildContext context) {
    return loginType==0? Container(
          width: ScreenUtil().setWidth(861),
          height: ScreenUtil().setHeight(120),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF68E0CF),Color(0xFF209CFF)]),
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(43)))
          ),
          alignment: Alignment.center,
           child: FlatButton(
             onPressed: (){
               if (_formKey.currentState.validate()) {
                 ///只有输入的内容符合要求通过才会到达此处
                 _formKey.currentState.save();
                 if(RegexUtils.isChinaPhoneLegal(_phone)){

                   RRouter.push(context ,Routes.loginSendSmsPage,{"phone":_phone},transition:TransitionType.cupertino);

                 }

               }


             },
             child:  Container(
               alignment: Alignment.center,
               width: double.infinity,
               height: double.infinity,
               child: Text("获取验证码",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w500),  ),
             )

           )
    ):Container(
        width: ScreenUtil().setWidth(861),
        height: ScreenUtil().setHeight(120),
        decoration:pwd==null?
        BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(43))),
            color: Colors.black26
        ):BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF68E0CF),Color(0xFF209CFF)]),
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(43)))
        ),
        alignment: Alignment.center,
        child: FlatButton(
            onPressed: (){
              RRouter.push(context ,Routes.loginSendSmsPage,{},transition:TransitionType.cupertino);
            },
            child:  Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: double.infinity,
              child: Text("登录",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w500),  ),
            )
        )
    );

  }

  buildTipView() {

    return  loginType==0?Container(
      alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(135), 0, 0, 0),
      child: Text("未注册的手机号验证后即自动注册",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(36)),)
    ): new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(135), 0, 0, 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("login/ic_user.png"),width:  ScreenUtil().setWidth(56),height: ScreenUtil().setWidth(60),fit: BoxFit.fill,),
        ),
        cXM(ScreenUtil().setWidth(42)),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          obscureText: !pwdShow,
          maxLines: 1,
          maxLength: 11,
          decoration: InputDecoration(
            hintText: "请输入密码",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(46)),
            border: InputBorder.none, // 去除下划线
            counterText: "",//此处控制最大字符是否显示
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(50)),
        )),
        InkWell(
          onTap: (){

              setState(() {
                pwdShow?pwdShow = false : pwdShow = true;

              });

          },
          child:   Container(
              margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(135), 0),
              width:   ScreenUtil().setWidth(50),
              height:   ScreenUtil().setWidth(50),
              child: Icon(pwdShow?Icons.visibility:Icons.visibility_off,size: ScreenUtil().setWidth(60),color: Color(0xFF999999),)

          ),
        )

      ],

    );;

  }

  buildTipView2() {
    return Text("其他登录方式",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(32)),);

  }



  buildPwdLoginView(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(80), 0, 0, 0),
        child: FlatButton(onPressed: (){

          setState(() {
            loginType==0?loginType=1:loginType=0;
          });

        }, child: Text( loginType==0?"密码登录":"验证码登录",style: TextStyle(color: Color(0xFF2CAAEE)),))
    );

  }

  buildOtherLoginView(BuildContext context) {

    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        InkWell(
          onTap: (){

              SharesdkPlugin.auth(
                  ShareSDKPlatforms.wechatSession, null, (SSDKResponseState state,
                  Map user, SSDKError error) {
                print("微信登陆的回调结果："+user.toString());
              });


        /*    sendAuth(onAuthResp: (data){
              print("微信登陆的回调结果："+data.toString());
            });*/
          },
          child: Container(
            padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
            child:     new  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(wrapAssets("login/ic_wx.png"),width:  ScreenUtil().setWidth(100),height: ScreenUtil().setWidth(100),fit: BoxFit.fill,),
                cYM(ScreenUtil().setHeight(10)),
                Text("微信登录",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(29)),)


              ],
            ),
          ),
        )


      ],
    );

  }





}
