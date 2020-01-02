import 'package:flutter/material.dart';
import 'package:yqy_flutter/ui/user/collect/cl_article_page.dart';
import 'package:yqy_flutter/ui/user/collect/cl_news_page.dart';
import 'package:yqy_flutter/ui/user/collect/cl_video_page.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('文章'), body: ClArticlePage()),
  _TabData(tab: Text('资讯'), body: ClNewsPage()),
  _TabData(tab: Text('视频'), body: ClVideoPage()),
  // _TabData(tab: Text('规范解读'), body: TabGFPage())
];


class CollectHomePage extends StatefulWidget {
  @override
  _CollectHomePageState createState() => _CollectHomePageState();
}

class _CollectHomePageState extends State<CollectHomePage>  with SingleTickerProviderStateMixin {

  TabController _tabController;

  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  final tabBarViewList = _tabDataList.map((item) => item.body).toList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabBarList.length);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("我的收藏"),

        ),
        body: Column(

          children: <Widget>[
            cYM(ScreenUtil().setHeight(37)),
            TabBar(
              controller: _tabController,
              tabs:tabBarList,
              indicatorColor: Color(0xFF1DD5E6), //指示器颜色 如果和标题栏颜色一样会白色
              isScrollable: true, //是否可以滑动
              labelColor: Color(0xFF333333) ,
              unselectedLabelColor: Color(0xFF999999),
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(50),fontWeight: FontWeight.w400), //防止字体抖动 不用此方法
              labelStyle: TextStyle(fontSize: ScreenUtil().setSp(50),fontWeight: FontWeight.w500),  //防止字体抖动 不用此方法
            ),
            Container(
              height: ScreenUtil().setHeight(1),
              color: Color(0xFFEEEEEE),
            ),
            cYM(ScreenUtil().setHeight(37)),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabBarViewList,
              ),
            ),




          ],
        )

    );
  }




}
