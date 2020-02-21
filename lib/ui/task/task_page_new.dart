import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




//滚动最大距离
const APPBAR_SCROLL_OFFSET = 40;

class TaskNewPage extends StatefulWidget {
  @override
  _TaskNewPageState createState() => _TaskNewPageState();
}

class _TaskNewPageState extends State<TaskNewPage> {


  double appBarAlpha = 0;
  __onScroll(offset){
    double alpha = offset/APPBAR_SCROLL_OFFSET;
    if(alpha < 0 && appBarAlpha == 0||alpha > 1 && appBarAlpha == 1) {
      return;
    }
    if(alpha<0){
      alpha = 0;
    }else if(alpha>1){
      alpha = 1;
    }



    setState(() {
      appBarAlpha = alpha;
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

    backgroundColor: Colors.white,
        body: Stack(
          children: <Widget>[
            MediaQuery.removePadding(context: context,
                removeTop: true,
                //监听列表的滚动
                child: NotificationListener(
                  //监听滚动后要调用的方法
                  // ignore: missing_return
                  onNotification: (scrollNotification){
                    //只有当是更新状态下和是第0个child的时候才会调用
                    if(scrollNotification is ScrollUpdateNotification &&scrollNotification.depth==0){
                      __onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: ListView(
                    children: <Widget>[
                      buildTopView(context),
                      buildItemListView(context),
                      buildTipTextView(),
                      cYM(ScreenUtil().setHeight(40)),
                      buildBottomShopView(context),
                      cYM(ScreenUtil().setHeight(80)),
                    ],
                  ),
                )
            ),
            //通过Opacity的透明度来控制appBar的显示与隐藏
            // opacity:透明度，0.0 到 1.0，0.0表示完全透明，1.0表示完全不透明
            Visibility(
              visible: appBarAlpha>0,
                child:  Opacity(
              opacity: appBarAlpha,
              child: Container(
                  height: ScreenUtil().setHeight(220),
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                      Positioned(left:ScreenUtil().setWidth(30),top: ScreenUtil().setHeight(120),
                          child: InkWell(
                            onTap: (){
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: ScreenUtil().setWidth(60),
                              color: Colors.black26,
                            ),
                          )
                      ),
                      Positioned(top: ScreenUtil().setHeight(120),child:  Text("积分兑换",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.w600),))

                    ],
                  )
              ),
            ))
          ],
        )


     /* body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          buildTopView(context),
          buildItemListView(context),
          buildTipTextView(),
          cYM(ScreenUtil().setHeight(40)),
          buildBottomShopView(context),
          cYM(ScreenUtil().setHeight(80)),
        ],
      ),*/

    );
  }

  buildTopView(BuildContext context) {

    return Container(
      height: ScreenUtil().setHeight(1050),
      child: new Stack(
        children: <Widget>[
          Image.asset(wrapAssets("task/task_bg.png"),width:double.infinity ,height: double.infinity,fit: BoxFit.fill,),


           Visibility(
             visible: appBarAlpha==0,
             child:  new Positioned(
               top: ScreenUtil().setHeight(150),
               left: ScreenUtil().setWidth(30),
               child: InkWell(
                 onTap: (){
                   Navigator.pop(context);
                 },
                 child: Icon(Icons.arrow_back_ios,color: Colors.white,size: ScreenUtil().setWidth(70),),
           )),),

           new   Positioned(
                left: ScreenUtil().setWidth(228),
                top: ScreenUtil().setHeight(100),
                child:  Container(
                  width: ScreenUtil().setWidth(623),
                  height: ScreenUtil().setHeight(563),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[

                      Image.asset(wrapAssets("task/task_bg_current.png"),width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                      Positioned(top:ScreenUtil().setHeight(148),child: Text("-  当前积分  -",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(35)),)),
                      Positioned(top:ScreenUtil().setHeight(190),child: Text("150",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(150)),)),
                      Positioned(
                        top: ScreenUtil().setHeight(360),
                        child: Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(311),
                          height: ScreenUtil().setHeight(98),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Color(0xFFFFEB7D),Color(0xFFF6C643)]),
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(49)))
                          ),
                          child: FlatButton(onPressed: (){

                          }, child: Text("兑换礼品",style: TextStyle(color: Color(0xFF863C0B),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),)

                        ),

                      )

                    ],
                  ),


                )

            ),

          new Positioned(
            left: ScreenUtil().setWidth(115),
              top: ScreenUtil().setHeight(630),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(72))),
                  boxShadow: [BoxShadow(color: Color(0x4D50909B), offset: Offset(5.0, 5.0),    blurRadius: 10.0, spreadRadius: 2.0)],
                ),
                width: ScreenUtil().setWidth(851),
                height: ScreenUtil().setHeight(144),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton.icon(
                      color: Colors.white,
                      icon: Image.asset(wrapAssets("task/task_ic_order.png"),width: ScreenUtil().setWidth(84),height: ScreenUtil().setWidth(84),),
                      label: Text("我的订单",style: TextStyle(color: Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(40)),),
                      onPressed: (){

                      },
                    ),

                    Container(
                      color: Color(0xFF999999),
                      width: ScreenUtil().setWidth(3),
                      height: ScreenUtil().setHeight(46),

                    ),

                    FlatButton.icon(
                      color: Colors.white,
                      icon: Image.asset(wrapAssets("task/task_ic_detail.png"),width: ScreenUtil().setWidth(84),height: ScreenUtil().setWidth(84),),
                      label: Text("积分明细",style: TextStyle(color: Color(0xFFFA994C),fontSize: ScreenUtil().setSp(40)),),
                      onPressed: (){

                      },
                    ),



                  ],


                ),

              )
          ),


          new Positioned(
              bottom: ScreenUtil().setHeight(60),
              left: ScreenUtil().setWidth(40),
              child: Text("做任务领积分",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(45),fontWeight: FontWeight.bold),),

          )


        ],
      ),

    );

  }

  buildItemListView(BuildContext context) {

    return Column(

      children: <Widget>[

        buildItemTask(context),
        buildItemTask(context),
        buildItemTask(context),
        buildItemTask(context),

      ],



    );


  }

  buildItemTask(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(0),
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(42),0 , ScreenUtil().setWidth(42), ScreenUtil().setHeight(42)),
      width: ScreenUtil().setWidth(1022),
      height: ScreenUtil().setHeight(260),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
        boxShadow: [BoxShadow(color: Color(0x4D50909B), offset: Offset(1.0, 1.0),    blurRadius: 10, spreadRadius: 2.0)],
      ),
      child: Stack(

        children: <Widget>[
          new Positioned(bottom: 0,child:  Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(220),height: ScreenUtil().setWidth(200),fit: BoxFit.fill,),),
         new Positioned(
              left: ScreenUtil().setWidth(270),
              child:Container(
                height: ScreenUtil().setHeight(260),
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text("临床应用病例征集",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
                    cYM(ScreenUtil().setHeight(10)),
                    Text("完成任务可获得10积分",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
                    cYM(ScreenUtil().setHeight(16)),
                    Text("+10积分",style: TextStyle(color: Color(0xFFFA994C),fontSize: ScreenUtil().setSp(46)),)

                  ],
                ),
              )
          ),

          new Positioned(
              right: 0,
              child: Container(
                width: ScreenUtil().setWidth(272),
                height: ScreenUtil().setHeight(101),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    Image.asset(wrapAssets("task/task_item_l.png"),width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                    Text("领取任务",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w500),)
                  ],
                ),


              )

          ),


        ],

      ),
    );

  }


  buildTipTextView() {

    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
      child:   Text("兑换礼品",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(45),fontWeight: FontWeight.bold)),
    );
    
  }

  buildBottomShopView(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[

        InkWell(
          onTap: (){
            RRouter.push(context ,Routes.shopDetailsPage,{"id":6},transition:TransitionType.cupertino);
          },
          child:    new  Container(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(75), 0, ScreenUtil().setWidth(75), 0),
            width: ScreenUtil().setWidth(500),
            height: ScreenUtil().setHeight(680),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
              boxShadow: [BoxShadow(color: Color(0x4D50909B), offset: Offset(0.0, 1.0),    blurRadius: 10.0, spreadRadius: 0.0)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(240),height: ScreenUtil().setWidth(300),fit: BoxFit.fill,),
                Text("中医药适宜技术培训班学分证书",style: TextStyle(color:Color(0xFF333333),fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w400,),textAlign: TextAlign.center,),
                Text("100积分",style: TextStyle(color:Color(0xFFFA994C),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
                FlatButton(onPressed: (){

                }, child:  Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(311),
                  height: ScreenUtil().setHeight(98),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFFFEB7D),Color(0xFFF6C643)]),
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(49)))
                  ),
                  child: Text("立即兑换",style: TextStyle(color: Color(0xFF863C0B),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
                ),)
              ],
            ),
          ),

        ),
        InkWell(
          onTap: (){
            RRouter.push(context ,Routes.shopDetailsPage,{},transition:TransitionType.cupertino);
          },
          child:    new  Container(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(75), 0, ScreenUtil().setWidth(75), 0),
            width: ScreenUtil().setWidth(500),
            height: ScreenUtil().setHeight(680),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
              boxShadow: [BoxShadow(color: Color(0x4D50909B), offset: Offset(0.0, 1.0),    blurRadius: 10.0, spreadRadius: 0.0)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(240),height: ScreenUtil().setWidth(300),fit: BoxFit.fill,),
                Text("中医药适宜技术培训班学分证书",style: TextStyle(color:Color(0xFF333333),fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w400,),textAlign: TextAlign.center,),
                Text("100积分",style: TextStyle(color:Color(0xFFFA994C),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
                FlatButton(onPressed: (){

                }, child:  Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(311),
                  height: ScreenUtil().setHeight(98),
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xFFFFEB7D),Color(0xFFF6C643)]),
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(49)))
                  ),
                  child: Text("立即兑换",style: TextStyle(color: Color(0xFF863C0B),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
                ),)
              ],
            ),
          ),

        ),




      ],

    );


  }
}
