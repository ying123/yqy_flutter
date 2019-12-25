import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'dart:async';

import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/login/bean/login_entity.dart';
import 'package:yqy_flutter/utils/regex_utils.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';

void main(){

  runApp(LoginPage());

}


class LoginPage extends StatefulWidget  {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin  {

  TabController _tabController;

  var tabTitle = [
    '密码登录',
    '快捷登录',
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabTitle.length);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return new  Scaffold(


      body: Stack(

        children: <Widget>[

          // 背景图
          new Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [Color(0xFF68E0CF),Color(0xFF209CFF)],begin: Alignment.topCenter,end: Alignment.bottomCenter)
            ),
          ),

          //logo
         new Positioned(
             top:ScreenUtil().setHeight(220),left: ScreenUtil().setWidth(436),child: Image.asset(wrapAssets("logo_login.png"),width: ScreenUtil().setWidth(255),height: ScreenUtil().setHeight(347),fit: BoxFit.fill,)),

          // 选项卡
         new Positioned(
              child: Container(
                height: ScreenUtil().setHeight(80),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(620)),
            alignment: Alignment.center,
            child: TabBar(
              controller: _tabController,
              tabs: tabTitle.map((f) => Tab(text: f)).toList(),
              indicatorColor:Colors.white, //指示器颜色 如果和标题栏颜色一样会白色
              isScrollable: true, //是否可以滑动
              labelColor: Colors.white ,
              unselectedLabelColor:  Colors.white,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(40)),
              labelStyle: TextStyle(fontSize: ScreenUtil().setSp(50),fontWeight: FontWeight.bold),
              indicatorPadding: EdgeInsets.only(top: 5),
            ),
          )),

         // 选项内容
         new  Positioned(
              top: ScreenUtil().setHeight(750),
              left: ScreenUtil().setWidth(109),
              child:  Container(
                width: ScreenUtil().setWidth(861),
                height: ScreenUtil().setHeight(800),
                child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildContainerPwdLogin(context),//密码登录
                      buildContainerSmsLogin(context),//短信登陆
                    ]
                ),
              )



          ),

         // 微信登陆
         new Positioned(
           bottom: ScreenUtil().setHeight(79),
             left: ScreenUtil().setWidth(248),
             child: Container(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: <Widget>[
                   new   Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Container(
                         width: ScreenUtil().setWidth(114),
                         height: ScreenUtil().setHeight(1),
                         color: Color(0xFFCFCFCF),
                       ),
                       cXM(ScreenUtil().setWidth(92)),
                       Text("其他登录方式",style: TextStyle(color: Color(0xFFf5f5f5),fontSize: ScreenUtil().setSp(29),fontWeight: FontWeight.w300),),
                       cXM(ScreenUtil().setWidth(92)),
                       Container(
                         width: ScreenUtil().setWidth(114),
                         height: ScreenUtil().setHeight(1),
                         color: Color(0xFFCFCFCF),
                       )


                     ],
                   ),
                   cYM(ScreenUtil().setHeight(50)),
                   Image.asset(wrapAssets("login/ic_wx.png"),width: ScreenUtil().setWidth(86),height: ScreenUtil().setHeight(73),)

                 ],
               ),
             )
         )

        ],
      ),


    );
  }

  Widget buildContainerPwdLogin(BuildContext context) {
    return new Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setHeight(30), ScreenUtil().setHeight(50), ScreenUtil().setHeight(30),  ScreenUtil().setHeight(50)),
              width: ScreenUtil().setWidth(861),
              height: ScreenUtil().setHeight(800),
              decoration: BoxDecoration(
                 borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(72))),
                 // 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
                  boxShadow: [ BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0.0, 15.0), //阴影xy轴偏移量
                      blurRadius: 15.0, //阴影模糊程度
                      spreadRadius: 1.0 //阴影扩散程度
                  )],
                color: Colors.white
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  cYM(ScreenUtil().setHeight(30)),
                    // 手机号输入
                   buildMobileInputView(context),
                    buildLine(),
                   // 密码输入
                   buildPwdInputView(context,1),
                   buildLine(),
                  // 忘记密码
                  buildForgetPwdView(context),
                   cYM(ScreenUtil().setHeight(70)),
                   //登陆按钮
                  buildBtnLoginView(context),
                   cYM(ScreenUtil().setHeight(43)),
                   //注册按钮
                   buildBtnRegistertView(context),

                ],
              ),


            );
  }

  buildMobileInputView(BuildContext context) {

    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("login/ic_user.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "输入手机号",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
        )),
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(40),
          height:   ScreenUtil().setWidth(40),
          child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        
      ],

    );

  }

  buildLine() {

    return Container(
      width: ScreenUtil().setWidth(723),
      color: Color(0xFF2CAAEE),
      height: ScreenUtil().setWidth(1),
    );

  }

  buildPwdInputView(BuildContext context,int type) {

    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets(type==1?"login/ic_pwd.png":"login/ic_sms.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "请输入登陆密码",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
        )),
        type==1?Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Icon(Icons.visibility_off,color: Color(0xFFAAAAAA),),
        ):Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(0), 0),
          width:   ScreenUtil().setWidth(200),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Text("获取验证码",style: TextStyle(color: Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(32)),),
        ),
      ],

    );
  }

  buildForgetPwdView(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
      alignment: Alignment.centerRight,
      child: Text("忘记密码?",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),


    );

  }

  buildBtnLoginView(BuildContext context) {

    return  InkWell(
      onTap: (){

      },
      child: Container(
        width: ScreenUtil().setWidth(585),
        height: ScreenUtil().setHeight(98),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF68E0CF),Color(0xFF209CFF)]),
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(43)))
        ),
        alignment: Alignment.center,
        child: Text("登录",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),),
      ),
    );

  }



  buildBtnRegistertView(BuildContext context) {

    return InkWell(
      onTap: (){
        RRouter.push(context, Routes.registerPage,{});
      },
      child:  Container(
        width: ScreenUtil().setWidth(585),
        height: ScreenUtil().setHeight(98),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(43))),
            border: Border.all(color:Color(0xFF3FBBFE),width: ScreenUtil().setWidth(3)),
            color: Colors.white
        ),
        alignment: Alignment.center,
        child: Text("立即注册",style: TextStyle(color:Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),),
      ),
    );
  }



  ///
  ///  短信登陆
  ///
  buildContainerSmsLogin(BuildContext context) {
    return new Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setHeight(30), ScreenUtil().setHeight(50), ScreenUtil().setHeight(30),  ScreenUtil().setHeight(50)),
      width: ScreenUtil().setWidth(861),
      height: ScreenUtil().setHeight(800),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(72))),
          // 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
          boxShadow: [ BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0), //阴影xy轴偏移量
              blurRadius: 15.0, //阴影模糊程度
              spreadRadius: 1.0 //阴影扩散程度
          )],
          color: Colors.white
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          cYM(ScreenUtil().setHeight(30)),
          // 手机号输入
          buildMobileInputView(context),
          buildLine(),
          // 短信验证码输入
          buildPwdInputView(context,2),
          buildLine(),
          // 忘记密码
          buildForgetPwdView(context),
          cYM(ScreenUtil().setHeight(70)),
          //登陆按钮
          buildBtnLoginView(context),
          cYM(ScreenUtil().setHeight(43)),
          //注册按钮
          buildBtnRegistertView(context),

        ],
      ),


    );
  }
}


