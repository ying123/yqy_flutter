import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutter/material.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/tab/tab_flfg.dart';
import 'package:yqy_flutter/ui/home/tab/tab_gf.dart';
import 'package:yqy_flutter/ui/home/tab/tab_live.dart';
import 'package:yqy_flutter/ui/home/tab/tab_zx.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/ui/home/tab/tab_home.dart';
import 'package:yqy_flutter/ui/home/tab/tab_medical.dart';
import 'package:yqy_flutter/ui/home/tab/tab_news.dart';
import 'package:yqy_flutter/common/constant.dart' as AppColors;
import 'package:yqy_flutter/widgets/dialog/update_dialog.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/bean/update_version_entity.dart';
import 'package:package_info/package_info.dart';
import 'package:device_info/device_info.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';

class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('推荐'), body: TabHomePage()),
  _TabData(tab: Text('直播'), body: TabLivePage()),
  _TabData(tab: Text('医学专题'), body: TabFlfgPage()),
  _TabData(tab: Text('医药咨询'), body:TabZxPage()),
 // _TabData(tab: Text('规范解读'), body: TabGFPage())
];




class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> with SingleTickerProviderStateMixin {



  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

   final tabBarList = _tabDataList.map((item) => item.tab).toList();
   final tabBarViewList = _tabDataList.map((item) => item.body).toList();

  TabController _tabController;

  GlobalKey<UpdateDialogState> _dialogKey = new GlobalKey();

  int tabIndex = 0;  // 当前选中索引  用索引来判断刷新字体大小  为了解决字体抖动

   bool _showScreenBtn = false;// 用来判断 是否显示 筛选按钮  当只有滑动到资讯页面 才展示


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabBarList.length)
      ..addListener(() {
        if (_tabController.index.toDouble() == _tabController.animation.value) {

          if(_tabController.index==3){
            _showScreenBtn = true;
          }else{
            _showScreenBtn = false;
          }
          setState(() {

          });

        }
      });


    if(!APPConfig.DEBUG){
      initUpdateAppVersion();
    }

  }



  @override
  void dispose() {
    super.dispose();
   _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
        return Scaffold(

          appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title:  buildTopView(),
            elevation: 0,
            titleSpacing: 0,
          ),

          body: new Column(
            children: <Widget>[
           new   Container(
                height: ScreenUtil().setHeight(85),
                width: double.infinity,
                alignment: Alignment.centerLeft,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    cXM(ScreenUtil().setWidth(30)),
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

                    Visibility(
                        visible: _showScreenBtn,
                        child:  Expanded(
                            child: InkWell(
                              onTap: (){

                              },
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text("全部",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(32)),),
                                  cXM(ScreenUtil().setWidth(10)),
                                  Image.asset(wrapAssets("tab/tab_zx_down_arrow.png"),width: ScreenUtil().setWidth(23),height: ScreenUtil().setHeight(14),)
                                ],
                              ),
                            )
                        ),
                    ),
                    cXM(ScreenUtil().setWidth(60))

                  ],
                )
              ),

           Expanded(
               child: TabBarView(
                 controller: _tabController,
                 children: tabBarViewList,
               )
           ),


            ],

          ),
        );



  }

 Widget  buildAppbarView() {

    return  InkWell(

      onTap: (){
        RRouter.push(context, Routes.searchHomePage,{});
      },
      child: Container(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
        alignment: Alignment.centerLeft,
        width: ScreenUtil().setWidth(517),
        height: ScreenUtil().setHeight(84),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(42))),
          color: Color(0xFFEEEEEE),
        ),
        child: Row(

          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
            
            Text("搜索",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),

            Container(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(25)),
              child:   Image.asset(wrapAssets("home/search.png"),width: ScreenUtil().setWidth(39),height: ScreenUtil().setWidth(39),),

            )



          ],
          
          
        ),


      ),
    );



 }



  ///
  ///   检查App版本更新
  ///
  UpdateVersionInfo _updateVersionInfo;
  void initUpdateAppVersion() {


    // 只有是android 设备 才请求检查
    if(Platform.isAndroid){

      NetworkUtils.requestAppVersion()
          .then((res) async {

        if(res.status=="9999"){

          _updateVersionInfo = UpdateVersionInfo.fromJson(res.info);

          //获取当前版本
          PackageInfo packageInfo = await PackageInfo.fromPlatform();

          int  buildNumber =  int.parse(packageInfo.buildNumber); // 本地版本

          int  versioncode =  int.parse(_updateVersionInfo.versioncode); // 服务器版本

          if(buildNumber<versioncode){ // 如果本地 小于  服务器  开始提示更新

            //获取权限
            var per = await checkPermission();
            if(per != null && !per){
              return null;
            }

            print("_updateVersionInfo.status："+_updateVersionInfo.status);

            _showUpdateDialog(_updateVersionInfo.versionname,_updateVersionInfo.downdress,_updateVersionInfo.status=="2"?true:false);

          }




        }


      });


    }





  }


  ///检查是否有权限
  checkPermission() async {
    //检查是否已有读写内存权限
    PermissionStatus status = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    //判断如果还没拥有读写权限就申请获取权限
    if(status != PermissionStatus.granted){
      var map = await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      if(map[PermissionGroup.storage] != PermissionStatus.granted){
        return false;
      }
    }
  }


  void _showUpdateDialog(String version, String url, bool isForceUpgrade) {
    showDialog(
      barrierDismissible: false,
      context: context,
   //  builder: (_) => DownloadProgressDialog(version,url),
     builder: (_) => _buildDialog(version, url, isForceUpgrade),
    );
  }

  Response response;
  Dio dio = Dio();
  Widget _buildDialog(String version, String url, bool isForceUpgrade) {
    return WillPopScope(
        onWillPop: () async => false,
        child: UpdateDialog(
          key: _dialogKey,
          exit: isForceUpgrade,
          version: version,
          onClickWhenDownload: (_msg) {
            //提示不要重复下载
            showToast(_msg);
          },
          onClickWhenNotDownload: () async {
            //下载apk，完成后打开apk文件，建议使用dio+open_file插件
            response = await dio.download(url, APPConfig.APK_PATH,onReceiveProgress: (int count, int total){

              _updateProgress(count/total);

                if(count.toString()==total.toString()){

                  _installApk();

                }



            });
          },

        ));
  }

  //dio可以监听下载进度，调用此方法
  void _updateProgress(_progress) {
    setState(() {
      _dialogKey.currentState.progress = _progress;
    });
  }

 Widget buildTopView() {

    return Container(
      padding: EdgeInsets.all(0),
      child: Row(
        children: <Widget>[
          cXM(ScreenUtil().setWidth(27)),
          Image.asset(wrapAssets("home/logo.png"),width: ScreenUtil().setWidth(194),height: ScreenUtil().setHeight(66)),
          cXM(ScreenUtil().setWidth(33)),
          buildAppbarView(),
          cXM(ScreenUtil().setWidth(10)),
          Image.asset(wrapAssets("home/integral_btn.png"),width: ScreenUtil().setWidth(204),height: ScreenUtil().setHeight(100),),
          InkWell(
            onTap: (){
              RRouter.push(context, Routes.noticeHomePage,{});
            },
            child: Image.asset(wrapAssets("home/msg_btn.png"),width: ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(58),),
          ),
          Container(
            margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(35)),
           width: ScreenUtil().setWidth(17),
            height: ScreenUtil().setHeight(17),
            decoration: BoxDecoration(
              color: Color(0xFFFF1818),
              borderRadius: BorderRadius.all(Radius.circular(30))

            ),


          )


        ],



      ),


    );



  }
}


// 安装
Future<Null> _installApk() async {

  OpenFile.open(APPConfig.APK_PATH);

}






