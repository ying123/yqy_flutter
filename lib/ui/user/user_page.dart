import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/bean/personal_entity.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:share/share.dart';


class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {


  PersonalInfo _personalInfo;
  StreamSubscription changeSubscription;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    initEventBusListener();
  }




loadData () async{


  NetworkUtils.requestUserIndex(UserUtils.getUserInfo().userId)
      .then((res) {

    int statusCode = int.parse(res.status);

    if(statusCode==9999){

      _personalInfo = PersonalInfo.fromJson(res.info);

    }
    setState(() {


    });
  });

}


@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    changeSubscription.cancel();
  }

/*@override
  void deactivate() {
    // TODO: implement deactivate
  super.deactivate();
    if(UserUtils.isLogin()){
      loadData();
    }
  }*/

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return Scaffold(
     body:ListView(
      padding: EdgeInsets.all(0),
       children: <Widget>[
          getUserTopView(),// 顶部个人信息布局  收藏列表布局
          cYM(5),
          getTopGridView(),
          getOtherGridView(),
       ],

     ),
    );

  }



  //  item 布局跳转
  Widget getItemGridView(String v,IconData iconData,Color colorr){

    return   InkWell(
      onTap: (){
        switch(v){
          case "意见反馈":
            RRouter.push(context ,Routes.feedBackPage,{},transition:TransitionType.cupertino);
            break;
          case "我的收藏":
            RRouter.push(context ,Routes.myCollectionPage,{},transition:TransitionType.cupertino);
            break;
          case "系统设置":
            RRouter.push(context ,Routes.settingPage,{},transition:TransitionType.cupertino);
            break;
          case "我的积分":
            RRouter.push(context ,Routes.myIntegralPage,{},transition:TransitionType.cupertino);
            break;
          case "积分兑换":
            RRouter.push(context ,Routes.shopHomePage,{},transition:TransitionType.cupertino);
            break;
          case "我的足迹":
            RRouter.push(context ,Routes.myFootPage,{},transition:TransitionType.cupertino);
            break;
          case "我的企业":
            RRouter.push(context ,Routes.myEnterprisePage,{},transition:TransitionType.cupertino);
            break;
          case "分享":
            Share.share('水燕Med  http://www.shuiyanmed.com/');
            break;

        }


      },
      child: Container(

        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Icon(iconData,size:40,color:colorr??Colors.black),
            cYM(5),
            Text(v,style: TextStyle(color: Colors.black,fontSize: 15),)

          ],

        ),

      ),
    );
    
  }
  
  

 Widget getUserTopView() => new Stack(

    children: <Widget>[
      new Column(
        children: <Widget>[
          new Container(
            height:setH(600),
            color: Colors.blue,
            child:  Stack(
              children: <Widget>[
                new  Container(
                  child: new ClipOval(
                  child: new Image.network(_personalInfo==null?"":_personalInfo.userPhoto,width: ScreenUtil().setWidth(240),height: ScreenUtil().setWidth(240),fit: BoxFit.fill,)
                   ),
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), ScreenUtil().setHeight(200), 0, 0),
                ),

                new  Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(400),  ScreenUtil().setHeight(240), 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text(_personalInfo==null?"":_personalInfo.realName,style: TextStyle(color: Colors.white,fontSize: 20),),
                    //  cXM(10),
                  //    Icon(Icons.android,size: 18,)
                    ],
                  ) ,
                ),
                new  Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(380), ScreenUtil().setHeight(340), 0, 0),
                  child: Row(
                    children: <Widget>[
                    /*  Text("关注：1",style: TextStyle(color: Colors.white,fontSize: 16),),
                      cXM(15),
                      Text("粉丝：1",style: TextStyle(color: Colors.white,fontSize: 16),),
                      cXM(15),*/
                      InkWell(
                        onTap: (){



                          // 1 医生用户   2 代表用户
                          UserUtils.getUserInfo().regType=="1"?RRouter.push(context, Routes.realNamePage,{},transition:TransitionType.cupertino):
                                              RRouter.push(context, Routes.realNameRepresentPage,{},transition:TransitionType.cupertino);

                       //   RRouter.push(context, Routes.realNameRepresentPage,{},transition:TransitionType.cupertino);
                        },
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: 75,
                            height: 25,
                            color: Colors.white,
                            child: buildUserStatus(_personalInfo==null?"":_personalInfo),
                            alignment: Alignment.center,
                          ),
                        ),

                      )
                    ],
                  ),
                ),
                new Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: (){
                        RRouter.push(context, Routes.personalPage,{"avatar":_personalInfo.userPhoto,"info":_personalInfo.userInfo});
                      },
                      child:  Icon(Icons.arrow_forward_ios,size: 20,color: Colors.white,),
                  ),
                ),
                new Container(
                  alignment: Alignment.bottomLeft,
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(90), 0, 0, ScreenUtil().setHeight(60)),
                  child:  Text(_personalInfo==null?"":_personalInfo.userInfo,style: TextStyle(color: Colors.white),)

                )

              ],
            ),
          ),
          

        ],

      ),

    ],


  );

  Widget getRowView(IconData iconData,String v) => new Container(

    color: Colors.white,
    height: 55,
    child:  new Row(
      children: <Widget>[
        cXM(15),
        Icon(Icons.android,size: 26,),
        cXM(25),
        Expanded(
          child: Container(
            decoration: new BoxDecoration(
                border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(v,style: TextStyle(fontSize: 18,color: Colors.black),),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.arrow_forward_ios,size: 20,color: Colors.black26,),

                )

              ],

            ),

          )

        )

      ],

    ),

  );

 Widget getTopGridView() {

   return
   new  Container(
       height:140,
       padding: EdgeInsets.all(5),
       child: Card(
         elevation: 0.3, //设置阴影
         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))), //设置圆角
         child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: <Widget>[
             getItemGridView("我的积分",Icons.monetization_on,Colors.blueAccent),
             getItemGridView("积分兑换",Icons.shopping_cart,Colors.green),
             getItemGridView("系统设置",Icons.settings,Colors.deepOrange)

           ],
         ),

       )

     );




 }

Widget  getOtherGridView() {

   return Container(
    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
     height: 280,
     child: Card(
       elevation: 0.3, //设置阴影
       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))), //设置圆角

       child: GridView(
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 3,
           //子组件宽高长度比例
         ),
         padding: EdgeInsets.all(0),
         physics: new NeverScrollableScrollPhysics(),
         children: <Widget>[
           getItemGridView("我的收藏",Icons.collections,Colors.blueAccent),
           getItemGridView("我的足迹",Icons.apps,Colors.green),
           getItemGridView("意见反馈",Icons.feedback,Colors.red),
           getItemGridView("分享",Icons.share,Colors.blueAccent),


           getItemGridView("我的企业",Icons.supervised_user_circle,Colors.green),


           // 当只有用户是 代表时  才会显示 我的企业
        /*   Visibility(
             visible: UserUtils.getUserInfo().regType=="2"?true:false,
             child:getItemGridView("我的企业",Icons.supervised_user_circle,Colors.green),
           )*/


         ],
       ),


     ),

   );

}

 Widget buildUserStatus(PersonalInfo personalInfo) {

   //                0:未认证，1认证成功，2待审核，3认证失败

   String userInfoStatus = personalInfo.userInfoStatus;

   String text;

   switch (userInfoStatus) {
     case "1":
       text= "认证成功";
       break;
     case "2":
       text = "待审核";
       break;
     case "3":
       text = "认证失败";
       break;
     default:
       text = "立即认证";
       break;
   }

   return Text(text,style: TextStyle(color: Colors.blue,fontSize: 12),);
  }



  void initEventBusListener() {
    changeSubscription =  eventBus.on<EventBusChange>().listen((event) {
      setState(() {
        loadData();
      });
    });




  }








}



