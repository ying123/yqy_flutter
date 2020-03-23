import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/shop/shop_details_page.dart';
import 'package:yqy_flutter/ui/user/bean/integral_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:yqy_flutter/ui/task/bean/task_page_entity.dart';



//滚动最大距离
const APPBAR_SCROLL_OFFSET = 40;

class TaskNewPage extends StatefulWidget {
  @override
  _TaskNewPageState createState() => _TaskNewPageState();
}

class _TaskNewPageState extends State<TaskNewPage> {


  double appBarAlpha = 0;

  __onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0 && appBarAlpha == 0 || alpha > 1 && appBarAlpha == 1) {
      return;
    }
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }


    setState(() {
      appBarAlpha = alpha;
    });
  }


  String _heroImage = "_heroImage";

  TaskPageInfo _taskPageInfo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initData();
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
                  onNotification: (scrollNotification) {
                    //只有当是更新状态下和是第0个child的时候才会调用
                    if (scrollNotification is ScrollUpdateNotification &&
                        scrollNotification.depth == 0) {
                      __onScroll(scrollNotification.metrics.pixels);
                    }
                  },
                  child: CustomScrollView(

                    slivers: <Widget>[

                      SliverToBoxAdapter(

                        child: Column(

                          children: <Widget>[
                            buildTopView(context),
                            cYM(ScreenUtil().setHeight(40)),
                            _taskPageInfo == null ? Container() : buildItemListView(
                                context),
                            buildTipTextView(),
                            cYM(ScreenUtil().setHeight(40)),
                            _taskPageInfo == null ? Container() :buildBottomShopView( _taskPageInfo.goodsList),

                            cYM(ScreenUtil().setHeight(80)),
                          ],
                        ),

                      ),

                    ],

                  ),
                )
            ),
            //通过Opacity的透明度来控制appBar的显示与隐藏
            // opacity:透明度，0.0 到 1.0，0.0表示完全透明，1.0表示完全不透明
            Visibility(
                visible: appBarAlpha > 0,
                child: Opacity(
                  opacity: appBarAlpha,
                  child: Container(
                      height: ScreenUtil().setHeight(220),
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[


                          Positioned(left: ScreenUtil().setWidth(30),
                              top: ScreenUtil().setHeight(120),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  size: ScreenUtil().setWidth(60),
                                  color: Colors.black26,
                                ),
                              )
                          ),
                          Positioned(top: ScreenUtil().setHeight(120),
                              child: Text("积分兑换", style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.w600),))

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
      height: ScreenUtil().setHeight(900),
      child: new Stack(
        children: <Widget>[
          Image.asset(wrapAssets("task/task_bg.png"), width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,),

          Visibility(
            visible: appBarAlpha == 0,
            child: new Positioned(
                top: ScreenUtil().setHeight(150),
                left: ScreenUtil().setWidth(30),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios, color: Colors.white,
                    size: ScreenUtil().setWidth(70),),
                )),),

          new Positioned(
              left: ScreenUtil().setWidth(228),
              top: ScreenUtil().setHeight(100),
              child: Container(
                width: ScreenUtil().setWidth(623),
                height: ScreenUtil().setHeight(563),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[

                    Image.asset(wrapAssets("task/task_bg_current.png"),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.fill,),
                    Positioned(top: ScreenUtil().setHeight(148),
                        child: Text("-  当前积分  -", style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(35)),)),
                    Positioned(top: ScreenUtil().setHeight(190),
                        child: Text(
                          _taskPageInfo == null ? "" : _taskPageInfo.myPoints
                              .toString(), style: TextStyle(color: Colors.white,
                            fontSize: ScreenUtil().setSp(150)),)),
                    Positioned(
                      top: ScreenUtil().setHeight(360),
                      child: Container(
                          alignment: Alignment.center,
                          width: ScreenUtil().setWidth(311),
                          height: ScreenUtil().setHeight(98),
                          decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                  colors: [Color(0xFFFFEB7D), Color(0xFFF6C643)
                                  ]),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(ScreenUtil().setWidth(49)))
                          ),
                          child: FlatButton(onPressed: () {

                          },
                            child: Text("兑换礼品", style: TextStyle(
                                color: Color(0xFF863C0B),
                                fontSize: ScreenUtil().setSp(40),
                                fontWeight: FontWeight.bold),),)

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
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(72))),
                  boxShadow: [BoxShadow(color: Color(0x4D50909B),
                      offset: Offset(5.0, 5.0),
                      blurRadius: 10.0,
                      spreadRadius: 2.0)
                  ],
                ),
                width: ScreenUtil().setWidth(851),
                height: ScreenUtil().setHeight(144),
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    FlatButton.icon(
                      color: Colors.white,
                      icon: Image.asset(wrapAssets("task/task_ic_order.png"),
                        width: ScreenUtil().setWidth(84),
                        height: ScreenUtil().setWidth(84),),
                      label: Text("我的订单", style: TextStyle(
                          color: Color(0xFF4AB1F2),
                          fontSize: ScreenUtil().setSp(40)),),
                      onPressed: () {
                        RRouter.push(context, Routes.orderListPage, {},);
                      },
                    ),

                    Container(
                      color: Color(0xFF999999),
                      width: ScreenUtil().setWidth(3),
                      height: ScreenUtil().setHeight(46),
                    ),


                    FlatButton.icon(
                      color: Colors.white,
                      icon: Image.asset(wrapAssets("task/task_ic_detail.png"),
                        width: ScreenUtil().setWidth(84),
                        height: ScreenUtil().setWidth(84),),
                      label: Text("积分明细", style: TextStyle(
                          color: Color(0xFFFA994C),
                          fontSize: ScreenUtil().setSp(40)),),
                      onPressed: () {
                        RRouter.push(context, Routes.integralListPage, {},
                            transition: TransitionType.cupertino);
                      },
                    ),


                  ],


                ),

              )
          ),


          new Positioned(
            bottom: ScreenUtil().setHeight(10),
            left: ScreenUtil().setWidth(40),
            child: Text("做任务领积分", style: TextStyle(color: Color(0xFF333333),
                fontSize: ScreenUtil().setSp(45),
                fontWeight: FontWeight.bold),),

          )


        ],
      ),

    );
  }

  buildItemListView(BuildContext context) {
    return ListView.builder(
        physics: new NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: _taskPageInfo.taskList.length,
        itemBuilder: (context, index) {
          return buildItemTask(context, _taskPageInfo.taskList[index]);
        });


  }


  buildItemTask(BuildContext context, TaskPageInfoTaskList bean) {
    return Container(
        padding: EdgeInsets.all(setH(30)),
        margin: EdgeInsets.fromLTRB(
            ScreenUtil().setWidth(42), 0, ScreenUtil().setWidth(42),
            ScreenUtil().setHeight(42)),
        width: ScreenUtil().setWidth(1022),
        height: ScreenUtil().setHeight(300),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
              Radius.circular(ScreenUtil().setWidth(30))),
          boxShadow: [BoxShadow(color: Color(0x4D50909B),
              offset: Offset(1.0, 1.0),
              blurRadius: 10,
              spreadRadius: 2.0)
          ],
        ),
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: <Widget>[

            wrapImageUrl(bean.image, setW(173), setW(173)),

            Expanded(child:
            new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    cXM(setW(50)),
                    Expanded(child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        buildText(bean.title, color: "#FF333333",
                            size: 40,
                            fontWeight: FontWeight.bold),
                        buildText("有效期至 2020-3-1", color: "#FF999999",
                            size: 29,
                            fontWeight: FontWeight.w400),

                      ],
                    ),),
                    FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                           RRouter.push(context, Routes.taskListPage, {"id": bean.id},transition: TransitionType.cupertino);

                        },
                        child: Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: setW(20)),
                          width: setW(207),
                          height: setH(66),
                          decoration: BoxDecoration(

                              border: Border.all(
                                  color: Color(0xFFE57C36), width: setW(1)),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(setW(33)))

                          ),
                          // 0未开始 1去完成 2领取奖励 3已完成 4已过期
                          child: Text(getTextStatus(bean.status),
                            style: TextStyle(color: Color(0xFFE88747),
                                fontSize: setSP(35)),),


                        ))

                  ],
                ),

                Container(
                  margin: EdgeInsets.only(left: setW(50)),
                  child: buildText(
                      "+" + bean.points.toString() + "积分", size: 40,
                      color: "#FFFA994C"),
                ),


                // 任务的进度条
                Container(
                  margin: EdgeInsets.only(left: setW(50)),
                  child: Row(
                    children: <Widget>[

                      Container(
                          width: setW(470),
                          height: setH(15),
                          decoration: BoxDecoration(

                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(setW(6))),
                              border: Border.all(
                                  color: Color(0xFF999999), width: setW(1))

                          ),

                          // 为了优化UI美观   当有未完成的任务使用listview实现布局  当都完成时使用Row 实现布局
                          // 目前的方案  待优化
                          child: bean.allTask != bean.completeTask ? ListView
                              .builder(itemCount: bean.allTask,
                              shrinkWrap: true,
                              physics: new NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return buildPgBarView(context, setW((470 -
                                    ((bean.allTask) * bean.completeTask)) /
                                    bean.allTask));
                              }) : Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: getWidget(bean)

                          )

                      ),

                      cXM(setW(20)),
                      buildText("已完成" + bean.completeTask.toString() + " / " +
                          bean.allTask.toString(), size: 32, color: "#FF999999")

                    ],
                  ),

                )


              ],
            ))


          ],

        )
    );
  }


  buildTipTextView() {
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
      child: Text("兑换礼品", style: TextStyle(color: Color(0xFF333333),
          fontSize: ScreenUtil().setSp(45),
          fontWeight: FontWeight.bold)),
    );
  }

  Widget buildBottomShopView(List<TaskPageInfoGoodsList> bean) {
    return GridView.builder(
        itemCount: bean.length,
         shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(setW(27), 0, setW(27), 0),
        physics: new NeverScrollableScrollPhysics(),
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
            crossAxisCount: 2,
            //纵轴间距
            mainAxisSpacing: ScreenUtil().setHeight(42),
            //横轴间距
            crossAxisSpacing: ScreenUtil().setHeight(25),
            //子组件宽高长度比例
            childAspectRatio: 0.6),
        itemBuilder: (BuildContext context, int index) {
          //Widget Function(BuildContext context, int index)
          return getItemContainerShopView(
              context, bean[index]);
        });
  }


/* return GridView.builder(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      itemCount: _taskPageInfo.goodsList.length,
      itemBuilder: (BuildContext context, int index) {
        return getItemContainerShopView(_taskPageInfo.goodsList[index]);
      },
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //单个子Widget的水平最大宽度
          maxCrossAxisExtent: setW(500),
          //水平单个子Widget之间间距
          mainAxisSpacing:setW(75),
          //垂直单个子Widget之间间距
          crossAxisSpacing: setH(20)
      ),

    );*/


/*  return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[

        InkWell(
          onTap: (){
            RRouter.push(context ,Routes.shopDetailsPage,{"id":6},transition: TransitionType.cupertino);
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
                Hero(tag: "avatar", transitionOnUserGestures: true, child:  Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(240),height: ScreenUtil().setWidth(300),fit: BoxFit.fill,),),
                Text("中医药适宜技术培训班学分证书",style: TextStyle(color:Color(0xFF333333),fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w400,),textAlign: TextAlign.center,),
                Text("100积分",style: TextStyle(color:Color(0xFFFA994C),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
                FlatButton(onPressed: (){
                  RRouter.push(context ,Routes.shopBuyOrderPage,{"id":"6"},transition:TransitionType.cupertino);
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

    );*/



  ///
  ///  任务进度单一view
  ///
  buildPgBarView(BuildContext context,double width) {

      return Container(
      //  padding: EdgeInsets.all(setW(6)),
         margin: EdgeInsets.fromLTRB(setW(4), setW(3),0,  setW(3)),
         width: width,
         height: setH(15),
         color: Color(0xFFFA994C),
       );

  }

  buildPgBarView2(double width) {

    return Container(
      margin: EdgeInsets.fromLTRB(0, setW(3),0,  setW(3)),
      width: width,
      height: setH(15),
      color: Color(0xFFFA994C),
    );

  }

  ///
  ///  任务首页接口
  ///
  void initData() {

    NetUtils.requestPointsIndex()
        .then((res){

      if(res.code==200){

        setState(() {
          _taskPageInfo =  TaskPageInfo.fromJson(res.info);
        });


      }

    });

  }

  // 0未开始 1去完成 2领取奖励 3已完成 4已过期
  String getTextStatus(int status) {

    String v;
    switch(status){

      case 0:
        v = "未开始";
        break;
      case 1:
        v = "去完成";
        break;
      case 2:
        v = "领取奖励";
        break;
      case 3:
        v = "已完成";
        break;
      case 4:
        v = "已过期";
        break;
    }
    return v;

  }

 List<Widget> getWidget(TaskPageInfoTaskList bean) {
   List<Widget> _listWidget = new List();// 任务进度条 （全部完成时用到）
    List a = new List(bean.completeTask);

    a.forEach((e){

      _listWidget.add( buildPgBarView2(setW((470-((bean.completeTask)*8))/bean.completeTask)));

    });

    return _listWidget;

  }

  ///
  ///  商品的item
  ///
 Widget getItemContainerShopView(BuildContext context,TaskPageInfoGoodsList goodsList) {

   return InkWell(
      onTap: (){
        RRouter.push(context ,Routes.shopDetailsPage,{"id":goodsList.id},transition: TransitionType.cupertino);
      },
      child:  new  Container(
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
          // Hero(tag: "avatar", transitionOnUserGestures: false, child: wrapImageUrl(goodsList.image, setW(240), setH(300))),
           wrapImageUrl(goodsList.image,  setW(240),  setH(300)),
            Text(goodsList.title,style: TextStyle(color:Color(0xFF333333),fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w400,),textAlign: TextAlign.center,),
            Text(goodsList.points+"积分",style: TextStyle(color:Color(0xFFFA994C),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
            FlatButton(onPressed: (){
              RRouter.push(context ,Routes.shopBuyOrderPage,{"id":"6"},transition:TransitionType.cupertino);
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

    );
  }

}