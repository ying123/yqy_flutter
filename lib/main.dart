import 'package:flutter/material.dart';
import 'package:yqy_flutter/ui/user/user_page.dart';
import 'package:yqy_flutter/ui/task/task_page.dart';
import 'package:yqy_flutter/ui/home/home_page.dart';
void main() {

  runApp(MainHomePage());

}


class MainHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "药企源",
      debugShowCheckedModeBanner: false,//不显示debug
      theme: ThemeData(
          primaryColor: Colors.blue,
          backgroundColor: Colors.white
      ),
      home: Home() ,



    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>{

  final _bottomNavigationColor = Colors.black45;
  int _currentIndex = 0; //当前选中的坐标

  String showTv = "首页"; //当前显示的页面布局

  final pages = [HomePage(), Text("专题"),Text("直播"),TaskHome(),UserPage()];
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      ///使用 indexedStack 防止方式页面重复绘制
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
          items: [btmNb("首页", Icons.home),
          btmNb("专题", Icons.apps),
          btmNb("直播", Icons.live_tv),
          btmNb("任务", Icons.assignment_turned_in),
          btmNb("我的", Icons.person)
          ],
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,//显示底部 图标 和文字
          selectedItemColor: Colors.blue, //显示的颜色
      ),
    );
  }

  /// 点击事件切换
  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  ///底部导航栏item
  btmNb(String v,IconData iconData) => BottomNavigationBarItem(icon: Icon(iconData),title: Text(v));





}








