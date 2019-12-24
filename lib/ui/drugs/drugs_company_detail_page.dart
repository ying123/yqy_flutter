import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';

class DrugsCompanyDetailPage extends StatefulWidget {
  @override
  _DrugsCompanyDetailPageState createState() => _DrugsCompanyDetailPageState();
}

class _DrugsCompanyDetailPageState extends State<DrugsCompanyDetailPage> with SingleTickerProviderStateMixin  {
  var tabTitle = [
    '主页',
    '文章',
    '视频',
    '相关',
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: new DefaultTabController(
          length: tabTitle.length,
          child: Scaffold(
            body: new NestedScrollView(
              headerSliverBuilder: (context, bool) {
                return [
                  SliverAppBar(
                    title: Text("公司详情"),
                    backgroundColor: Color(0xFF1DD5E6),
                    centerTitle: true,
                    leading: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    ),
                    expandedHeight: ScreenUtil().setHeight(650),
                    floating: true,
                    pinned: true,
                    flexibleSpace: new FlexibleSpaceBar(
                   //   title: Text("山东汉方制药有限公司"),
                        centerTitle: true,
                        background: Container(
                            height: ScreenUtil().setHeight(550),
                            child:  buildTopView(context)
                        )

                    ),
                  ),
                  new SliverPersistentHeader(
                    delegate: new SliverTabBarDelegate(
                      new TabBar(
                        tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                        indicatorColor: Color(0xFF1DD5E6), //指示器颜色 如果和标题栏颜色一样会白色
                        //    isScrollable: true, //是否可以滑动
                        labelColor: Color(0xFF1DD5E6) ,
                        unselectedLabelColor: Color(0xFF999999),
                        indicatorSize: TabBarIndicatorSize.label,
                        unselectedLabelStyle: TextStyle(fontSize: 16),
                        labelStyle: TextStyle(fontSize: 16),
                        indicatorPadding: EdgeInsets.only(top: 5),
                      ),
                      color: Colors.white,
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  //  buildDoctorHomeView(context),
                  new  Container(
                    child: ListView(
                      physics: new NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      children: <Widget>[
                        getRowTextView("产品推荐"),
                        buildProductPublicityView(context),
                        getRowTextView("学术内容"),
                        buildLiveNoticeView(new List()),
                        getRowTextView("视频"),
                        buildLiveNoticeView(new List()),
                      ],
                    ),
                    color: Colors.white,
                  ),
                  Container(
                    height: 20,
                    child: Text("暂无数据"),
                  ),
                  Container(
                    height: 20,
                    child: Text("暂无数据"),
                  ),
                  Container(
                    height: 20,
                    child: Text("暂无数据"),
                  ),

                ],
              ),
            ),
          )),

    );
  }

  buildTopView(BuildContext context) {

    return  Container(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29), ScreenUtil().setHeight(268), ScreenUtil().setWidth(62),  ScreenUtil().setHeight(52)),
        height: ScreenUtil().setHeight(550),
        decoration: BoxDecoration(

            gradient: LinearGradient(colors: [Color(0xFF1DD5E6),Color(0xFF46AEF7)])

        ),
        child:  Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Image.asset(wrapAssets("drugs/drugs.png"),width: ScreenUtil().setWidth(196),height: ScreenUtil().setWidth(196),fit: BoxFit.fill,),
            cXM(ScreenUtil().setWidth(65)),
            new  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                new Container(
                  width: ScreenUtil().setWidth(724),
                  child:   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("山东汉方制药有限公司",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(52),fontWeight: FontWeight.w500),),
                      Container(
                        alignment: Alignment.center,
                        width: ScreenUtil().setWidth(120),
                        height: ScreenUtil().setHeight(50),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(24))),
                            border: Border.all(color: Colors.white,width: ScreenUtil().setWidth(1))
                        ),
                        child: Text("+关注",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(35)),),


                      )

                    ],
                  ),
                ),
                cYM(ScreenUtil().setHeight(39)),
                new Container(
                  width: ScreenUtil().setWidth(724),
                  child:  Text("山东汉方制药有限公司成立于2004年，是一家集研发、生产、销售为一体的现代化新型中药企业，山东汉方制药已成长为以中医药产业为主导，集合生物科技、医疗器械、中药衍生化妆品、互联网信息科技等多元化的医药集团...",
                    style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(29)),maxLines: 4,overflow: TextOverflow.ellipsis,),
                ),
                cYM(ScreenUtil().setHeight(58)),
                Text("内容  445  |  粉丝  4498",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(40)),)

              ],
            )


          ],
        )
    );
  }

  Widget getRowTextView(String type){

    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(55),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(42), 0, ScreenUtil().setWidth(42), 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(type,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w800),),
          new GestureDetector(
            child: Container(
              child: Row(
                children: <Widget>[

                  Visibility(
                    child:    new  InkWell(
                      child:  Image.asset(wrapAssets(
                          "tab/tab_live_iv11.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                      onTap: (){
                        setState(() {

                        });

                      },
                    ),
                    visible: type=="视频"?true:false,

                  ),

                  cXM(ScreenUtil().setWidth(60)),

                  Visibility(
                      visible: type.contains("相关")||type.contains("产品")?false:true,
                      child: Row(
                        children: <Widget>[
                          Text("更多"+type,style: TextStyle(color:Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
                          Icon(Icons.arrow_forward_ios,color: Colors.black12,size: ScreenUtil().setWidth(35),),
                        ],
                      )
                  )

                ],

              ),
            ),
            onTap: (){
              type=="热门视频"?RRouter.push(context, Routes.liveMeeting,{"title":"11"}):
              RRouter.push(context, Routes.videoListPage,{});
            },

          ),

        ],


      ),

    );

  }
  ///
  ///   产品推荐布局
  ///
  Widget buildProductPublicityView(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(45)),
      child: Row(

        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Image.asset(wrapAssets("drugs/drugs.png"),width: ScreenUtil().setWidth(250),height: ScreenUtil().setHeight(259),fit: BoxFit.fill,),
              cYM(ScreenUtil().setHeight(42)),
              Text("复方黄柏液涂剂",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35)),)

            ],
          )



        ],
      ),

    );

  }
  ///
  ///  直播预告布局
  ///
  Widget buildLiveNoticeView(List<String> list){

    list.add("1");
    list.add("1");
    list.add("1");
    return list==null?Container():ListView.builder(
        shrinkWrap: true ,
        padding: EdgeInsets.only(top: 0),
        physics: new NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context,index){
          return getLiveItemView(context,list);
        }
    );
  }

  ///
  ///   列表item
  ///
  Widget getLiveItemView(context,List listBean){

    return  GestureDetector(

      onTap: (){
        //  RRouter.push(context, Routes.videoDetailsPage,{"reviewId":listBean.id});
      },

      child: new Container(
        height: ScreenUtil().setHeight(250),
        padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(27), ScreenUtil().setHeight(27), 0,  ScreenUtil().setHeight(40)),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            // Icon(Icons.apps,size: 110,color: Colors.blueAccent,),
            //  wrapImageUrl(listBean.image,110.0, 110.0),
            Image.asset(wrapAssets("tab/tab_live_img.png"),fit: BoxFit.fill,height: ScreenUtil().setHeight(215),width:ScreenUtil().setWidth(288)),
            //  new Image(image: new CachedNetworkImageProvider("http://via.placeholder.com/350x150"),width: 110,height: 110,color: Colors.black,),
            cXM(ScreenUtil().setHeight(20)),
            new Container(
                width: ScreenUtil().setWidth(720),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("湖南湘中医联盟肛肠疾病高峰论坛学术交流会",style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(37)),maxLines: 2,overflow: TextOverflow.ellipsis,),

                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Image.asset(wrapAssets("tab/tab_live_ic2.png"),width: ScreenUtil().setSp(32),height: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text("张素娟  李霞  将建成  张大大  王素娥",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
                          ],

                        ),

                        //       Text("看录播",style: TextStyle(color: Colors.greenAccent),)

                      ],
                    ),
                    new Row(
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
                    ),

                  ],

                )

            )


          ],


        ),

      ),


    );

  }


}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(BuildContext context, double shrinkOffset,
      bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}