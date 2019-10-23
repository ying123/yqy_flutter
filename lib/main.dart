import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/special/special_page.dart';
import 'package:yqy_flutter/ui/user/user_page.dart';
import 'package:yqy_flutter/ui/task/task_page.dart';
import 'package:yqy_flutter/ui/home/home_page.dart';
import 'package:yqy_flutter/utils/event_bus_util.dart';

import 'ui/live/live_page.dart';

void main() {

  runApp(MainHomePage());

}


class MainHomePage extends StatelessWidget {

  MainHomePage() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final router = new Router();
    Routes.configureRoutes(router);
    RRouter.initWithRouter(router);
    requestPermission();
  }


  @override
  Widget build(BuildContext context) {

    return  RefreshConfiguration( // 刷新控件全部配置
        headerTriggerDistance: 100.0,// 头部触发刷新的越界距离
        hideFooterWhenNotFull: true, // Viewport不满一屏时,禁用上拉加载更多功能
        footerBuilder: () => ClassicFooter(
          loadingText: "努力加载中..",
          noDataText: "我是有底线的~",
          idleText: "上拉加载",
          failedText: "加载失败！点击重试！",
        ) ,
        child: OKToast( // Toast 全局配置
            child:  MaterialApp(
              title: "药企源",
              debugShowCheckedModeBanner: false,//不显示debug
              theme: ThemeData(
                  primaryColor: Colors.blue,
                  backgroundColor: Colors.white
              ),
              home: Home() ,
              onGenerateRoute: RRouter.router().generator,
            )
        )
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin{

  final _bottomNavigationColor = Colors.black45;
  int _currentIndex = 0; //当前选中的坐标

  String showTv = "首页"; //当前显示的页面布局

  final pages = [HomePage(),SpecialPage(null),LiveHomePage(null),TaskHome(),UserPage()];



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
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

Future requestPermission() async {

  // 申请权限

  Map<PermissionGroup, PermissionStatus> permissions =

  await PermissionHandler().requestPermissions([PermissionGroup.storage]);

  // 申请结果

  PermissionStatus permission =

  await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

  if (permission == PermissionStatus.granted) {

  //  Fluttertoast.showToast(msg: "权限申请通过");

  } else {

  //  Fluttertoast.showToast(msg: "权限申请被拒绝");

  }

}






