import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutter/material.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/ui/home/tab/tab_home.dart';


class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('首页'), body: TabHomePage()),
  _TabData(tab: Text('医学园'), body:Text("医学园")),
  _TabData(tab: Text('医药新闻'), body: Text("医药新闻")),
  _TabData(tab: Text('政策资讯'), body: Text("政策资讯")),
  _TabData(tab: Text('法律法规'), body: Text("法律法规")),
  _TabData(tab: Text('规范解读'), body: Text("规范解读"))
];



class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> with SingleTickerProviderStateMixin{

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
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
        return Column(

        children: <Widget>[
          cYM(60),

          Container(
            height: 38,
            color: Colors.white,
            child:  TabBar(
              controller: _tabController,
              tabs: tabBarList,
              indicatorColor: Colors.blueAccent, //指示器颜色 如果和标题栏颜色一样会白色
              isScrollable: true, //是否可以滑动
              labelColor: Colors.blueAccent ,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelStyle: TextStyle(fontSize: 16),
              labelStyle: TextStyle(fontSize: 16),
              indicatorPadding: EdgeInsets.only(top: 5),
            ),

          ),
          Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabBarViewList,
              )
          )


        ],


      );



  }
}






