import 'dart:async';
import 'dart:io';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/login/login_page.dart';
import 'package:yqy_flutter/ui/special/special_page.dart';
import 'package:yqy_flutter/ui/user/user_page.dart';
import 'package:yqy_flutter/ui/task/task_page.dart';
import 'package:yqy_flutter/ui/home/home_page.dart';
import 'package:yqy_flutter/utils/chinese_cupertino_localizations.dart';
import 'package:yqy_flutter/utils/local_storage_utils.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'ui/live/live_page.dart';
import 'package:fluwx/fluwx.dart' as fluwx;



void main()  {
  WidgetsFlutterBinding.ensureInitialized();
   LocalStorage.getInstance().then((res){
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
     runApp(MainHomePage());
   });

}



class MainHomePage extends StatelessWidget {


  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  MainHomePage()  {
    final router = new Router();
    Routes.configureRoutes(router);
    RRouter.initWithRouter(router);
    initUMeng();
    initWxSDK();
    requestPermission();

  }




  @override
  Widget build(BuildContext context) {

    return  RefreshConfiguration( // 刷新控件全部配置
        headerTriggerDistance: 100.0,// 头部触发刷新的越界距离
        hideFooterWhenNotFull: true, // Viewport不满一屏时,禁用上拉加载更多功能
        headerBuilder: ()=> ClassicHeader(
          idleText: "下拉刷新",
          completeText: "刷新完成",
          failedText: "刷新失败",
          refreshingText: "刷新中",
          releaseText: "释放开始刷新",
          canTwoLevelText: "",
        ),
        footerBuilder: () => ClassicFooter(
          loadingText: "努力加载中..",
          noDataText: "我是有底线的~",
          idleText: "上拉加载",
          failedText: "加载失败！点击重试！",
          canLoadingText: "加载更多数据",
        ) ,
        child: OKToast( // Toast 全局配置
            child:  MaterialApp(
              title: "水燕Med",
              navigatorKey: navigatorKey,
              debugShowCheckedModeBanner: false,//不显示debug
                localizationsDelegates: [
                  ChineseCupertinoLocalizations.delegate, // 这里加上这个,是自定义的delegate
                  DefaultCupertinoLocalizations.delegate, // 这个截止目前只包含英文
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                  const Locale("en", "US"),
                  const Locale("zh", "CH"),
                ],
              theme: ThemeData(
                  appBarTheme: AppBarTheme(
                    brightness: Brightness.light,
                  ),
                  primaryColor: Colors.blue,
                 backgroundColor: Colors.white,

        ),
              home: UserUtils.isLogin()?HomeMainPage():LoginPage() ,
              onGenerateRoute: RRouter.router().generator,
            )
        )
    );
  }

  void initUMeng() async{
  await  FlutterUmplus.init(
       Platform.isAndroid?'5dde2aec4ca357e85300027b':"5de76de9570df303f5000336",
      channel: Platform.isAndroid?"Android":"iOS",
      reportCrash: false,
      logEnable: true,
      encrypt: true,
    );

  }

  void initWxSDK() {

    fluwx.registerWxApi(appId:"wx86155ed3e169e37a",universalLink:"https://shuiyanmed.com/");

  }
}

class HomeMainPage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomeMainPage> with TickerProviderStateMixin{


  final _bottomNavigationColor = Colors.black45;
  int _currentIndex = 0; //当前选中的坐标

  String showTv = "首页"; //当前显示的页面布局

  final pages = [HomePage(),SpecialPage(null),LiveHomePage(null),TaskHome(),UserPage()];


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //取消订阅
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






