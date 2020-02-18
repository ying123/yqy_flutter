import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/ui/home/notice/tab/tab_hd_page.dart';
import 'package:yqy_flutter/ui/home/notice/tab/tab_notice_page.dart';
import 'package:yqy_flutter/ui/home/notice/tab/tab_system_page.dart';
import 'package:yqy_flutter/utils/margin.dart';


class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('系统消息'), body: TabSystemPage()),
  _TabData(tab: Text('公告通知'), body: TabNoticePage()),
  _TabData(tab: Text('互动'), body: TabHDPage()),
  // _TabData(tab: Text('规范解读'), body: TabGFPage())
];



class NoticeHomeNewPage extends StatefulWidget {
  @override
  _NoticeHomeNewPageState createState() => _NoticeHomeNewPageState();
}

class _NoticeHomeNewPageState extends State<NoticeHomeNewPage> with SingleTickerProviderStateMixin {

  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  final tabBarViewList = _tabDataList.map((item) => item.body).toList();

  TabController _tabController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabBarList.length);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: getCommonAppBar("消息"),


      body: Column(

        children: <Widget>[

          TabBar(
            controller: _tabController,
            tabs:tabBarList,
            indicatorColor: Colors.white, //指示器颜色 如果和标题栏颜色一样会白色
            isScrollable: true, //是否可以滑动
            labelPadding: EdgeInsets.only(right: ScreenUtil().setWidth(80)),
            labelColor: Color(0xFF17E2BD) ,
            unselectedLabelColor: Color(0xFF7E7E7E),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(37)), //防止字体抖动 不用此方法
            labelStyle: TextStyle(fontSize: ScreenUtil().setSp(58),fontWeight: FontWeight.bold),  //防止字体抖动 不用此方法
          ),
          Expanded(
              child:  Stack(
                children: <Widget>[
                  TabBarView(
                    controller: _tabController,
                    children: tabBarViewList,
                  ),
                ],
              )
          ),


        ],
      ),

      
    );
  }
}
