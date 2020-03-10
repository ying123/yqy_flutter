import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
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
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/regex_utils.dart';
import 'package:fluwx/fluwx.dart' as fluwx;


class BindPhonePage extends StatefulWidget {

  String unionid;// 	微信unionid

  String opentype = "wx";

  BindPhonePage(this.unionid); // 	第三方登录类型 默认微信


  @override
  _BindPhonePageState createState() => _BindPhonePageState();
}

class _BindPhonePageState extends State<BindPhonePage> {

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



  @override
  Widget build(BuildContext context) {
    return  new  Scaffold(
      backgroundColor: Colors.white,
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
                      Text("绑定手机号码",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(65),fontWeight: FontWeight.bold),),
                      cYM(ScreenUtil().setHeight(160)),
                      // 手机号输入
                      buildMobileInputView(context),
                      buildLine(),
                      Visibility(visible: loginType==0?false:true,child:    buildLine()),
                      cYM(ScreenUtil().setHeight(73)),
                      buildBtnLoginView(context),
                      cYM(ScreenUtil().setHeight(10)),
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


      }else if(res.code==1501){ // 去绑定手机号码


      }else{ //错误信息
        showToast(res.msg);
      }


    });

  }







}
