import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flui/flui.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/login/bean/send_sms_entity.dart';
import 'package:yqy_flutter/ui/login/bean/wx_info_entity.dart';
import 'package:yqy_flutter/utils/local_storage_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/regex_utils.dart';
import 'package:fluwx/fluwx.dart' as fluwx;
import 'package:yqy_flutter/utils/user_utils.dart';


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

  String pwd = ""; // 密码


  String _result = "无"; // 微信登陆响应的结果

  bool isFirst =  true;  // 是否是第一次安装

  bool isProtocol = false;// 当前是否同意

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initControllerListener();
    initWxLoginListener();
    initProtocolDialog();
  }

  void initControllerListener() {


    _pwdController.addListener((){

     setState(() {
       pwd = _pwdController.text;
     });

    });

  }


  void initWxLoginListener() {

    fluwx.weChatResponseEventHandler.distinct((a, b) => a == b).listen((res) {
      if (res is fluwx.WeChatAuthResponse) {

        if(res.isSuccessful){

          requestWxUserInfoData(res.code).then((res){
            // 发起微信登陆的请求

            requestWxLogin(res);

          });

        }else{
          FLToast.error(text: "授权失败");
        }


      }
    });


  }



  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 1080, height: 1920);
    return  new  Scaffold(
    backgroundColor: Colors.white,
      body: Stack(

        children: <Widget>[

        Form(
            key: _formKey,
            child:  new   ListView(

          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              child:   new  Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  cYM(ScreenUtil().setHeight(260)),
                  Text("欢迎来到药企源",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(65),fontWeight: FontWeight.bold),),
                  cYM(ScreenUtil().setHeight(160)),
                  // 手机号输入
                  buildMobileInputView(context),
                  buildLine(),
                  cYM(ScreenUtil().setHeight(36)),
                  buildPwdInputView(),
                  Visibility(visible: loginType==0?false:true,child:    buildLine()),
                  cYM(ScreenUtil().setHeight(73)),
                  buildBtnLoginView(context),
                  cYM(ScreenUtil().setHeight(10)),
                  buildPwdLoginView(context),
                  cYM(ScreenUtil().setHeight(240)),
                  buildTipView2(),
                  cYM(ScreenUtil().setHeight(30)),
                  // 其他登陆方式
                  buildOtherLoginView(context),
                  cYM(ScreenUtil().setHeight(60)),
                  // 用户协议 和 隐私协议
                  buildProtocolView(context)
                ],
              ),
              onTap: (){
                // 触摸收起键盘
                FocusScope.of(context).requestFocus(FocusNode());

              },
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
          child:  Image.asset(wrapAssets("login/ic_mobile.png"),width:  ScreenUtil().setWidth(56),height: ScreenUtil().setWidth(60),fit: BoxFit.fill,),
        ),
        cXM(ScreenUtil().setWidth(42)),
        Expanded(
            child: TextFormField(
        autofocus: true,
          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          maxLength: 11,
          decoration: InputDecoration(
            hintText:  loginType==0? "输入手机号":"输入账号",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(46)),
            border: InputBorder.none, // 去除下划线
            counterText: "",//此处控制最大字符是否显示
          ),
              onSaved: (v){
                _phone = v;
              },
         validator: (String value) {
           if(value.length==0){
             showToast( loginType==0?"请输入手机号":"请输入账号");
             return null;
             }
           if(!RegexUtils.isChinaPhoneLegal(value)&& loginType==0){
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

               if(!isProtocol){
                 FLToast.info(text: "请先点击同意下方的“用户协议和隐私政策”");
                 return;
               }


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
        decoration:pwd==null||pwd.length==0?
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
              // 当密码输入的时候 才能够点击效果
              if (pwd != null || pwd.length > 0) {
                if (_formKey.currentState.validate()) {
                  ///只有输入的内容符合要求通过才会到达此处
                  _formKey.currentState.save();

                    // 发起密码登录的请求
                    requestPwdLogin(context,_phone,pwd);

                }
              }


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

  buildPwdInputView() {

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
          child:  Image.asset(wrapAssets("login/ic_pwd.png"),width:  ScreenUtil().setWidth(56),height: ScreenUtil().setWidth(60),fit: BoxFit.fill,),
        ),
        cXM(ScreenUtil().setWidth(42)),
        Expanded(child: TextFormField(
          controller: _pwdController,
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

            fluwx
                .sendWeChatAuth(
                scope: "snsapi_userinfo", state: "wechat_sdk_demo_test")
                .then((data) {});

          },
          child: Container(
            padding: EdgeInsets.all(ScreenUtil().setHeight(30)),
            child:     new  Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(wrapAssets("wx_logo.png"),width:  ScreenUtil().setWidth(120),height: ScreenUtil().setWidth(120),fit: BoxFit.fill,),
                cYM(ScreenUtil().setHeight(20)),
                Text("微信登录",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(32)),)

              ],
            ),
          ),
        )

      ],
    );
  }



  ///
  ///  获取微信登录用户信息
  ///
  Future<String> requestWxUserInfoData(String code) async {

    Dio _dio = Dio();
    String url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid="+APPConfig.WX_APP_ID
                  +"&secret="+ APPConfig.WX_APP_SECRET+"&code="+code+"&grant_type=authorization_code";
    Response  response = await _dio.get(url);

    WxInfoEntity wxInfoEntity = WxInfoEntity.fromJson(json.decode(response.data));
    return  wxInfoEntity.unionid;

  }


  ///
  ///  微信登陆的请求
  ///
  void requestWxLogin(String unionid) {

    NetUtils.requestQuickLogin("wx", unionid)
        .then((res){

        SendSmsInfo _loginInfo = SendSmsInfo.fromJson(res.info);

        if(res.code==200){ // 直接登录
          UserUtils.saveToken(_loginInfo.token.toString()).then((_){
            RRouter.push(context ,Routes.homePage,{},transition:TransitionType.cupertino,clearStack: true);
          });

        }else if(res.code==1501){ // 去绑定手机号码
          RRouter.push(context ,Routes.bindPhonePage,{"unionid":unionid},transition:TransitionType.cupertino);
        }else{ //错误信息
          FLToast.error(text: res.msg);
        }

    });

  }


  ///
  ///  密码登录请求
  ///
  void requestPwdLogin(BuildContext context, String phone, String pwd) {


    if(!isProtocol){

      FLToast.info(text: "请先点击同意下方的“用户协议和隐私政策”");
      return;
    }


    NetUtils.requestPassLogin(phone,pwd)
        .then((res){

          if(res.code==200){

            SendSmsInfo  _loginInfo = SendSmsInfo.fromJson(res.info);
            UserUtils.saveToken(_loginInfo.token.toString()).then((bool){
              RRouter.push(context, Routes.homePage, {},clearStack: true);
            });


          }else{
            FLToast.error(text: res.msg);
          }

    });
  }

  buildProtocolView(BuildContext context) {


    return Container(

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[


          Checkbox(value: isProtocol, onChanged: (e){

              setState(() {
                isProtocol  = e;
              });

          }),
          buildText("已同意"),

          InkWell(

            onTap: (){
              NetUtils.requestAgreements()
                  .then((res){

                if(res.code==200){
                  RRouter.push(context, Routes.webPage,{"url":res.info["content"],"title":"用户协议和隐私政策"});
                }

              });
            },
            child:    buildText("《用户协议和隐私政策》",color: "#FF209CFF"),

          )



        ],
      ),
    );


  }


  ///
  ///  应用宝市场要求  必须有 隐私政策和用户协议
  ///
  ///   如果是首次安装打开   显示弹窗
  ///
  ///    仅安卓
  ///
  void initProtocolDialog() {


    if(Platform.isAndroid){

      isFirst =  LocalStorage.getBool("isFirst");


     // 第一次
      if(!isFirst){

        LocalStorage.putBool("isFirst", true);
        isProtocol =  false;
      }else{
        isProtocol =  true;
      }

      setState(() {

      });


    }


  }


}
