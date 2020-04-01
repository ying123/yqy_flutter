import 'package:flui/flui.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/doctor/bean/doctor_home_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'dart:math' as math;

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage>  with TickerProviderStateMixin {

  TabController _tabController;
  GlobalKey _globalKey = new GlobalKey();

  bool showDrawerType1 = true; // 筛选抽屉菜单是否展开  默认展开
  bool showDrawerType2 = true;
  bool showDrawerType3 = true;


  String seleV1,seleV2,seleV3;// 当前选中的  科室  地区  学会

  int viewType = 0;// 当前的排列方式  我的预约排列   0 gridview  1  listvie

  DoctorHomeInfo _doctorHomeInfo;


  String _bannerIndexName = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    initData();

  }

  @override
  Widget build(BuildContext context) {

    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.init(context,width: 1080, height: 1920);
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: getCommonAppBar("专家视频"),

      endDrawer: buildDrawer(context),

      body:_doctorHomeInfo==null?Container(): Column(

        children: <Widget>[
          Container(height: ScreenUtil().setHeight(30),color: Colors.white,),
          buildBanner(context),
          buildBannerTitle(context),
          Expanded(child:  CustomScrollView(

            shrinkWrap: true,
            slivers: <Widget>[

              new SliverToBoxAdapter(
                child: Column(
                  children: <Widget>[
                    // 横向推荐视频
                    getHotVideo(_doctorHomeInfo.recomVideo),
                    //buildAdView(context),
                    getRowTextView("特约专家"),//往期会议标题栏
                     Container(
                       color: Color(0xfff9f9f9),
                       child:    getDocViews(_doctorHomeInfo.recomDoctor),
                     )
                  ],
                ),
              ),
              SliverStickyHeader(
                header:  buildScreenView(context),
                sliver: viewType==0? SliverGrid.count(
                     //水平子Widget之间间距
                     //  crossAxisSpacing: ScreenUtil().setWidth(20),
                    //垂直子Widget之间间距
                    // mainAxisSpacing: ScreenUtil().setHeight(10),
                    childAspectRatio:1,
                    //一行的Widget数量
                    crossAxisCount: 2,
                  children: _doctorHomeInfo.videoList
                      .map((e)=> buildItemView(e)).toList())
                    :
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, i) =>
                            getLiveItemView(context, _doctorHomeInfo.videoList[i]),
                    childCount:  _doctorHomeInfo.videoList.length,
                  ),
                ),
              ),

            ],

          ),
          )

        ],
      )

    );
  }
  Widget getRowTextView(String type){


    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(120),
      alignment: Alignment.center,
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(27), 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(type,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w800),),
            new GestureDetector(
          child: Container(
            child: Row(
              children: <Widget>[
                Text("更多专家",style: TextStyle(color:Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
                cXM(ScreenUtil().setWidth(4)),
                Icon(Icons.arrow_forward_ios,color: Colors.black12,size: ScreenUtil().setWidth(35),),
              ],

            ),
          ),
          onTap: (){

            FLToast.info(text: "暂无更多内容");

          },

        ),

        ],


      ),

    );

  }



  buildBanner(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(360),
      width: double.infinity,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return wrapImageUrl( _doctorHomeInfo.topBanner[index].url, double.infinity, double.infinity);
        },
        itemCount: _doctorHomeInfo.topBanner.length,
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        autoplayDelay: 8000,
        onIndexChanged: (index){

           setState(() {
             _bannerIndexName = _doctorHomeInfo.topBanner[index].name;
           });

        },
      ),

    );

  }

  buildBannerTitle(BuildContext context) {
    
    return Container(
      height: setH(120),
      alignment: Alignment.center,
      width: double.infinity,
      child: Text(_bannerIndexName,style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(40)),),
      
    );

  }

  buildRowRecommendView(BuildContext context) {

    return  Row(

      children: <Widget>[
      cXM(ScreenUtil().setWidth(30)),
      new  Expanded(
          child:  Container(
            height: ScreenUtil().setHeight(410),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(501),height: ScreenUtil().setHeight(288),fit: BoxFit.fill,),
                Padding(padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), 0, ScreenUtil().setWidth(14), 0),child:   Text("这种疫苗怎么打？要不要打？",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                Padding(padding:  EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), 0, ScreenUtil().setWidth(14), 0),child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("2019-09-21",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                    Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  ],
                ),)


              ],

            ),
          )),
      cXM(ScreenUtil().setWidth(20)),
      new  Expanded(
          child:  Container(
            height: ScreenUtil().setHeight(410),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(501),height: ScreenUtil().setHeight(288),fit: BoxFit.fill,),
                Padding(padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), 0, ScreenUtil().setWidth(14), 0),child:   Text("这种疫苗怎么打？要不要打？",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                Padding(padding:  EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), 0, ScreenUtil().setWidth(14), 0),child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("2019-09-21",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                    Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  ],
                ),)


              ],

            ),
          )),
      cXM(ScreenUtil().setWidth(30))
      ],
    );
  }

  buildAdView(BuildContext context) {
    
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: ScreenUtil().setHeight(173),
      child: Image.asset(wrapAssets("ad_bg.png"),width: ScreenUtil().setWidth(1022),height: ScreenUtil().setHeight(173),fit: BoxFit.fill,),
    );
    
  }




  Widget getHotVideo(List<DoctorHomeInfoRecomVideo>  list){

    return list==null?Container(): GridView.count(
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(5),
      //GridView内边距
      padding:EdgeInsets.fromLTRB(setW(29), 0, setW(29), 0),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: list.getRange(0,list.length).map((item) => itemVideoView(item)).toList(),
    );
  }


  ///
  ///  特约专家布局
  ///
  Widget getDocViews(List<DoctorHomeInfoRecomDoctor> list) {

    return list==null?Container(): GridView.builder(
        itemCount: list.length,
        shrinkWrap: true ,
        padding: EdgeInsets.all(ScreenUtil().setWidth(27)),
        physics: new NeverScrollableScrollPhysics(),
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //横轴元素个数
            crossAxisCount: 2,
            //纵轴间距
            mainAxisSpacing: ScreenUtil().setHeight(20),
            //横轴间距
            crossAxisSpacing: ScreenUtil().setHeight(25),
            //子组件宽高长度比例
            childAspectRatio: 1.4),
        itemBuilder: (BuildContext context, int index) {
          //Widget Function(BuildContext context, int index)
          return getDocView(list[index]);
        });

  }

  Widget getDocView(DoctorHomeInfoRecomDoctor bean){
    return InkWell(

      onTap: (){
        FLToast.info(text: "暂无相关信息");
     //   RRouter.push(context, Routes.doctorDetailsPage,{"userId":bean.id});
      },
      child: new Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            wrapImageUrl(bean.recomImage, ScreenUtil().setWidth(230), ScreenUtil().setHeight(220)),
            cXM(ScreenUtil().setWidth(29)),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Text(bean.realName??"",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w500),),
                Text(bean.department??"",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35)),),
                Text(bean.job==null?"":bean.job,style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),)


              ],

            )


          ],
        ),


      ),
    );

  }
  ///
  ///  热门视频 item
  ///
  Widget itemVideoView(DoctorHomeInfoRecomVideo bean) {


    return  InkWell(
      onTap: (){
        //   RRouter.push(context, Routes.livePaybackPage, {});
        RRouter.push(context, Routes.doctorVideoInfoPage,{"id": bean.id.toString()},transition:  TransitionType.cupertino);
      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            wrapImageUrl(bean.img, ScreenUtil().setWidth(501), ScreenUtil().setHeight(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(bean.name,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            cYM(setH(5)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                 // Text(bean.,style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(32)),),
                //  Text(bean.pv.toString()+"次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(32)),),
                ],
              ),
            )

          ],
        ),

      ),
    );

  }


  Widget buildScreenView(BuildContext context) {

    return  new  Container(
      color: Colors.white,
      height: setH(120),
      padding:EdgeInsets.fromLTRB(setW(30), 0, setW(30), 0),
      //  height: ScreenUtil().setHeight(40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
         Expanded(child:   Text("为你推荐",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w800),),),
          Container(
            width: ScreenUtil().setWidth(80),
            child:   FlatButton(
              onPressed: (){
                setState(() {
                  viewType==0?viewType=1:viewType=0;
                });
              },
              padding: EdgeInsets.all(0),
              child: Image.asset(wrapAssets(viewType==0?"tab/tab_live_iv1.png":"tab/tab_live_iv11.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setHeight(40),),
            ),

          ),
          cXM(ScreenUtil().setWidth(40)),

          Builder(builder: (context1){
            return
              InkWell(
                  onTap: (){
                    Scaffold.of(context1).openEndDrawer();
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child:  Row(
                      children: <Widget>[
                        Image.asset(wrapAssets("tab/tab_screen.png"),width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),),
                        cXM(ScreenUtil().setWidth(6)),
                        Text("筛选",style:TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)))
                      ],


                    ),
                  )

              );

          })


        ],

      ),
    );


    /*   return  new  Container(
      color: Colors.white,
      margin: EdgeInsets.fromLTRB(0, 0,0, 0),
      padding: EdgeInsets.only(right: setW(10)),
      //  height: ScreenUtil().setHeight(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(child:  TabBar(
            controller: _tabController,
            tabs: [Text("为你推荐",textAlign: TextAlign.center,),Text("按时间"),Text("按热度")],
            indicatorColor: Colors.white, //指示器颜色 如果和标题栏颜色一样会白色
            isScrollable: true, //是否可以滑动
            labelColor:Color(0xFF2CAAEE) ,
            unselectedLabelColor:Color(0xFF7E7E7E),
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(40)),
            labelStyle: TextStyle(fontSize: ScreenUtil().setSp(40)),
            //  indicatorPadding: EdgeInsets.only(top: 5),
          ),),
          Container(
            width: ScreenUtil().setWidth(80),
            child:   FlatButton(
              onPressed: (){
                setState(() {
                  viewType==0?viewType=1:viewType=0;
                });
              },
              padding: EdgeInsets.all(0),
              child: Image.asset(wrapAssets(viewType==0?"tab/tab_live_iv1.png":"tab/tab_live_iv11.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setHeight(40),),
            ),

          ),
          cXM(ScreenUtil().setWidth(40)),

          Builder(builder: (context1){
            return
              InkWell(
                  onTap: (){
                    Scaffold.of(context1).openEndDrawer();
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child:  Row(
                      children: <Widget>[
                        Image.asset(wrapAssets("tab/tab_screen.png"),width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),),
                        cXM(ScreenUtil().setWidth(6)),
                        Text("筛选",style:TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)))
                      ],


                    ),
                  )

              );

          })


        ],

      ),
    );*/

  }




  Widget buildItemView(DoctorHomeInfoVideoList bean) {


    return  InkWell(
      onTap: (){
        RRouter.push(context, Routes.doctorVideoInfoPage,{"id": bean.id.toString()},transition:  TransitionType.cupertino);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(setW(20), 0, setW(20), 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            wrapImageUrl(bean.image, ScreenUtil().setWidth(501), ScreenUtil().setHeight(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(bean.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            cYM(setH(5)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  // Text(bean.,style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(32)),),
                  //  Text(bean.pv.toString()+"次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(32)),),
                ],
              ),
            )

          ],
        ),

      ),
    );


  }

  buildDrawer(BuildContext context) {

    List<String> list1 = ["麻醉科","妇产科","皮肤病科","骨科","外科","内科","男科","儿科","传染病科","五官科","肿瘤科","中医科","医学影像科","康复医学科","精神心理科","营养科","其他科室"];
    List<String> list2 = ["北京","上海","广东","天津","山东","安徽","河北""河南","黑龙江","江苏","浙江","山西","四川","陕西","内蒙古"];
    List<String> list3 = ["学会1","学会2","学会3","学会4","学会5","学会6","学会7","学会8","学会11","学会12","学会13","学会14","学会15","学会16"];

    return Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(825),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[

            ListView(
              children: <Widget>[
                buildItemDrawerView(list1,"科室",showDrawerType1),
                buildItemDrawerView(list2,"地区",showDrawerType2),
                buildItemDrawerView(list3,"学会",showDrawerType3),
                cYM(ScreenUtil().setHeight(240))
              ],
            ),

            new Container(
              height: ScreenUtil().setHeight(200),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){

                        setState(() {
                          seleV1 = "";
                          seleV2 = "";
                          seleV3 = "";
                        });


                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFFBFBFB),
                            border: Border.all(color: Color(0xFFEEEEEE),width: ScreenUtil().setWidth(1)),
                            borderRadius:BorderRadius.only(bottomLeft: Radius.circular(ScreenUtil().setWidth(29),),topLeft: Radius.circular(ScreenUtil().setWidth(29)))
                        ),
                        alignment: Alignment.center,
                        width: ScreenUtil().setWidth(346),
                        height: ScreenUtil().setHeight(115),
                        child: Text("重置",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37)),),
                      )
                  ),
                  FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF2CAAEE),
                            border: Border.all(color: Color(0xFF2CAAEE),width: ScreenUtil().setWidth(1)),
                            borderRadius:BorderRadius.only(bottomRight: Radius.circular(ScreenUtil().setWidth(29),),topRight: Radius.circular(ScreenUtil().setWidth(29)))
                        ),
                        alignment: Alignment.center,
                        width: ScreenUtil().setWidth(346),
                        height: ScreenUtil().setHeight(115),
                        child: Text("确定",style: TextStyle(color: Color(0xFFFFFFFF),fontSize: ScreenUtil().setSp(37)),),
                      )

                  )


                ],
              ),
            )


          ],


        )
    );

  }

  buildItemDrawerView(List<String> list,String type,bool show) {

    return Column(

      children: <Widget>[

        new Container(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29), ScreenUtil().setWidth(39), ScreenUtil().setWidth(40), 0),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Text(type,style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),

              Material(

                color: Colors.white,
                child:  InkWell(

                  onTap: (){

                    switch(type){

                      case"科室":
                        show?showDrawerType1=false:showDrawerType1=true;
                        break;
                      case"地区":
                        show?showDrawerType2=false:showDrawerType2=true;
                        break;
                      case"学会":
                        show?showDrawerType3=false:showDrawerType3=true;
                        break;
                    }

                    setState(() {

                    });

                  },
                  child: Padding(padding: EdgeInsets.all(10),
                    child:  Icon( show?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,color: Color(0xFF7E7E7E),size: ScreenUtil().setSp(50),),
                  ),
                ),
              ),


            ],


          ),
        ),

        Visibility(
            visible: show,
            child: GridView.count(
              shrinkWrap: true,
              physics: new NeverScrollableScrollPhysics(),
              //水平子Widget之间间距
              crossAxisSpacing: 10.0,
              //垂直子Widget之间间距
              mainAxisSpacing: ScreenUtil().setHeight(14),
              //GridView内边距
              padding: EdgeInsets.all(10.0),
              //一行的Widget数量
              crossAxisCount: 3,
              //子Widget宽高比例
              childAspectRatio: 2.2,
              //子Widget列表
              children:  list.map((item) => buildGridItemView(item,type)).toList(),
            )
        )

      ],

    );


  }

  Widget buildGridItemView(String value,String type) {

    return InkWell(
      onTap: (){

        switch(type){

          case"科室":
            seleV1 = value;
            break;
          case"地区":
            seleV2 = value;
            break;
          case"学会":
            seleV3 = value;
            break;
        }

        setState(() {

        });

      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius:  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(29))),
            color: Color(seleV1==value||seleV2==value||seleV3==value?0xFFE3F5FF:0xFFF5F5F5)
        ),
        child: Text(value,style: TextStyle(color: Color(seleV1==value||seleV2==value||seleV3==value?0xFF2CAAEE:0xFF333333),fontSize: ScreenUtil().setSp(32)),),

      ),
    );


  }
  ///
  ///   列表item
  ///
  Widget getLiveItemView(context,DoctorHomeInfoVideoList listBean){

    return  GestureDetector(

      onTap: (){
        //  RRouter.push(context, Routes.videoDetailsPage,{"reviewId":listBean.id});
        RRouter.push(context, Routes.doctorVideoInfoPage,{"id": listBean.id.toString()},transition:  TransitionType.cupertino);
      },

      child: new Container(
        height: ScreenUtil().setHeight(250),
        padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(27), 0, 0,  ScreenUtil().setHeight(40)),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            // Icon(Icons.apps,size: 110,color: Colors.blueAccent,),
            wrapImageUrl(listBean.image, ScreenUtil().setHeight(215),ScreenUtil().setWidth(288)),
          //  Image.asset(wrapAssets("tab/tab_live_img.png"),fit: BoxFit.fill,height: ScreenUtil().setHeight(215),width:ScreenUtil().setWidth(288)),
            //  new Image(image: new CachedNetworkImageProvider("http://via.placeholder.com/350x150"),width: 110,height: 110,color: Colors.black,),
            cXM(ScreenUtil().setHeight(20)),
            new Container(
                width: ScreenUtil().setWidth(720),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(listBean.title,style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(37)),maxLines: 2,overflow: TextOverflow.ellipsis,),

                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Text(listBean.pv.toString()+"次播放",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
                         /*   Image.asset(wrapAssets("tab/tab_live_ic2.png"),width: ScreenUtil().setSp(32),height: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text("张素娟  李霞  将建成  张大大  王素娥",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),*/
                          ],

                        ),

                        //       Text("看录播",style: TextStyle(color: Colors.greenAccent),)

                      ],
                    ),
                /*    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Icon(Icons.access_time,size: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text("2019-12-01  03:33:00",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
                          ],

                        ),

                        //       Text("看录播",style: TextStyle(color: Colors.greenAccent),)

                      ],
                    ),*/

                  ],

                )

            )


          ],


        ),

      ),


    );

  }

  void initData() {

    NetUtils.requestDoctorIndex()
        .then((res){

          if(res.code==200){

            setState(() {
                _doctorHomeInfo  =   DoctorHomeInfo.fromJson(res.info);
            });

          }

    });



  }


}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

