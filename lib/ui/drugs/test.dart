import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/utils/margin.dart';

const url =
    'http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg';

void main(){

  runApp( TestPage());
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var tabTitle = [
    '主页',
    '文章',
    '视频',
    '相关',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: new DefaultTabController(
          length: tabTitle.length,
          child: Scaffold(
            body: new NestedScrollView(
              headerSliverBuilder: (context, bool) {
                return [
                  SliverAppBar(
                    title: Text("公司详情"),
                    centerTitle: true,
                    leading: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    ),
                    expandedHeight: ScreenUtil().setHeight(800),
                    floating: true,
                    pinned: true,
                    flexibleSpace: new FlexibleSpaceBar(
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
                      shrinkWrap: true,
                      children: <Widget>[
                        Container(
                          height: 180,
                          color: Colors.blue,
                        ),
                        Container(
                          height: 180,
                          color: Colors.black,
                        ),
                        Container(
                          height: 600,
                          color: Colors.red,
                        ),
                      ],
                    ),
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
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
