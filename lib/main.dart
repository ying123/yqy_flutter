import 'dart:async';
import 'dart:io';

import 'package:flui/flui.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
import 'package:fluwx/fluwx.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/route/tokenCancelRouter.dart';
import 'package:yqy_flutter/ui/doctor/doctor_home_page.dart';
import 'package:yqy_flutter/ui/guide/guide_page.dart';
import 'package:yqy_flutter/ui/home/video_page.dart';
import 'package:yqy_flutter/ui/login/login_home_page.dart';
import 'package:yqy_flutter/ui/special/special_page.dart';
import 'package:yqy_flutter/ui/task/task_page_new.dart';
import 'package:yqy_flutter/ui/user/user_new_page.dart';
import 'package:yqy_flutter/ui/user/user_page.dart';
import 'package:yqy_flutter/ui/task/task_page.dart';
import 'package:yqy_flutter/ui/home/home_page.dart';
import 'package:yqy_flutter/utils/chinese_cupertino_localizations.dart';
import 'package:yqy_flutter/utils/local_storage_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';
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
    FLToastDefaults _toastDefaults = FLToastDefaults();
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
          noDataText: "已经拉到最底部啦~",
          idleText: "上拉加载",
          failedText: "加载失败！点击重试！",
          canLoadingText: "加载更多数据",
        ) ,
        child: OKToast( // ---------------------------------Toast 全局配置  待删除--------------------------------------------//
            child: FLToastProvider(  // Toast 全局配置
                  defaults: _toastDefaults,
                  child:  MaterialApp(
                    title: "水燕Med",
                    navigatorKey: TokenRouter.navigatorKey, //设置在这里
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
                  //  home: HomeMainPage() ,
                   home: UserUtils.isLogin()?HomeMainPage():LoginHomePage() ,
                    onGenerateRoute: RRouter.router().generator,
                  ),

              )
        )
    );
  }

  void initUMeng() async{
  await  FlutterUmplus.init(
      '5dde2aec4ca357e85300027b',
      channel: Platform.isAndroid?"Android":"iOS",
      reportCrash: false,
      logEnable: true,
      encrypt: true,
    );

  }

  ///
  ///  初始化微信sdk相关
  ///
  initWxSDK() async {
    await registerWxApi(
        appId: APPConfig.WX_APP_ID,
        doOnAndroid: true,
        doOnIOS: true,
        universalLink: "https://shuiyanmed.com/");
    var result = await isWeChatInstalled;

  //  FLToast.info(text: result.toString());

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

  final pages = [HomePage(),GuidePage(),VideoPage(),DoctorHomePage(),NewUserPage()];


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
    ScreenUtil.init(context,width: 1080, height: 1920);
    return Scaffold(

      ///使用 indexedStack 防止方式页面重复绘制
      body: IndexedStack(
        index: _currentIndex,
        children: pages,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
          items: [btmNb("首页",  Image.asset("assets/imgs/tab/tab_home.png",width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),),0),
          btmNb("文献指南",  Image.asset("assets/imgs/tab/tab_news.png",width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),),1),
          btmNb("视频",  Image.asset("assets/imgs/tab/tab_video.png",width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),),2),
          btmNb("专家",  Image.asset("assets/imgs/tab/tab_doc.png",width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),),3),
          btmNb("我的", Image.asset("assets/imgs/tab/tab_me.png",width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),),4)
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
  btmNb(String v,Widget iconData,int pos) => BottomNavigationBarItem(icon: iconData,title: Text(v,style: TextStyle(color:pos==_currentIndex? Color(buildColorType(_currentIndex)):Color(0xFF333333),fontSize: ScreenUtil().setSp(32)),),activeIcon: Image.asset(buildseleIcon(_currentIndex),width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),));


  ///
  ///   选中的 icon 变化
  ///
  String buildseleIcon(int currentIndex) {

    String img;
    switch(currentIndex){
      case 0:
        img = "assets/imgs/tab/tab_home_sele.png";
        break;
      case 1:
        img = "assets/imgs/tab/tab_news_sele.png";
        break;
      case 2:
        img = "assets/imgs/tab/tab_video_sele.png";
        break;
      case 3:
        img = "assets/imgs/tab/tab_doc_sele.png";
        break;
      case 4:
        img = "assets/imgs/tab/tab_me_sele.png";
        break;

    }

    return img;

  }



  ///
  ///  选择的 icon 的颜色变化
  ///
  int buildColorType(int currentIndex) {

    int  color;
    switch(currentIndex){
      case 0:
        color = 0xFF10D5B1;
        break;
      case 1:
        color = 0xFF35A4FC;
        break;
      case 2:
        color = 0xFF8551FE;
        break;
      case 3:
        color = 0xFF3FBBFE;
        break;
      case 4:
        color = 0xFFFB7D39;
        break;

    }

    return color;


  }





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






