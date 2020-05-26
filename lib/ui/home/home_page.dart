import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flui/flui.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/services.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xupdate/flutter_xupdate.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/bean/is_certification_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_news_index_entity.dart';
import 'package:yqy_flutter/ui/home/tab/tab_flfg.dart';
import 'package:yqy_flutter/ui/home/tab/tab_gf.dart';
import 'package:yqy_flutter/ui/home/tab/tab_live.dart';
import 'package:yqy_flutter/ui/home/tab/tab_special.dart';
import 'package:yqy_flutter/ui/home/tab/tab_zx.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/local_storage_utils.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/ui/home/tab/tab_home.dart';
import 'package:yqy_flutter/ui/home/tab/tab_medical.dart';
import 'package:yqy_flutter/common/constant.dart' as AppColors;
import 'package:yqy_flutter/widgets/dialog/notice_dialog.dart';
import 'package:yqy_flutter/widgets/dialog/real_name_dialog.dart';
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
  _TabData(tab: Text('医学专题'), body: TabSpecialPage()),
  _TabData(tab: Text('医药资讯'), body:TabZxPage()),
 // _TabData(tab: Text('规范解读'), body: TabGFPage())
];




class HomePage extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin {



  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

   final tabBarList = _tabDataList.map((item) => item.tab).toList();
   final tabBarViewList = _tabDataList.map((item) => item.body).toList();

  TabController _tabController;

  GlobalKey<UpdateDialogState> _dialogKey = new GlobalKey();

  int tabIndex = 0;  // 当前选中索引  用索引来判断刷新字体大小  为了解决字体抖动

   bool _showScreenBtn = false;// 用来判断 是否显示 筛选按钮  当只有滑动到资讯页面 才展示

  bool _showScreenView = false;// 用来判断 是否显示 筛选view

  /// 用来接收 资讯新闻的筛选数据==
  String _SeleItem; // 当前选中的筛选
  /// =================================

  IsCertificationInfo _isCertificationInfo;

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

    initEventBusListener();
    // 判断当前用户是否需要去实名认证

    if(mounted){
      initUserCurrentStatus();
    }

  }


  @override
  void dispose() {
    super.dispose();
   _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 1080, height: 1920);

        return Scaffold(

          appBar: AppBar(
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            title:  buildTopView(),
            elevation: 0,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
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
                            child: Material(
                              color: Colors.white,
                              child: InkWell(
                                  onTap: (){
                                    setState(() {
                                      _showScreenView?_showScreenView=false:_showScreenView=true;
                                    });
                                  },
                                  child: Container(
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(_SeleItem==null?"全部":_SeleItem,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(32)),),
                                        cXM(ScreenUtil().setWidth(8)),
                                        Image.asset(wrapAssets(_showScreenView?"tab/tab_zx_up_arrow.png":"tab/tab_zx_down_arrow.png"),width: ScreenUtil().setWidth(23),height: ScreenUtil().setHeight(14),)
                                      ],
                                    ),
                                  )
                              ),
                            )
                        ),
                    ),
                    cXM(ScreenUtil().setWidth(10))
                  ],
                )
              ),

           Expanded(
               child:  Stack(
                 children: <Widget>[
                   TabBarView(
                     controller: _tabController,
                     children: tabBarViewList,
                   ),
                  buildScreenView()
                 ],
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
        width: ScreenUtil().setWidth(512),
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
  PackageInfo packageInfo;
  Future<void> initUpdateAppVersion() async {

    // 只有是android 设备 才请求检查
    if(Platform.isAndroid){
      //获取当前版本
     /* FlutterXUpdate.init(
        ///是否输出日志
          debug: true,
          ///是否使用post请求
          isPost: true,
          ///post请求是否是上传json
          isPostJson: false,
          ///是否开启自动模式
          isWifiOnly: false,
          ///是否开启自动模式
          isAutoMode: false,
          ///需要设置的公共参数
          supportSilentInstall: false,
          ///在下载过程中，如果点击了取消的话，是否弹出切换下载方式的重试提示弹窗
          enableRetry: false
      ).then((value) {


      }).catchError((error) {
        print(error);
      });

       FlutterXUpdate.checkUpdate(url: "https://gitee.com/xuexiangjys/XUpdate/raw/master/jsonapi/update_test.json");
       NetUtils.requestAppVersionAndroid()
           .then((res){

         if(res.code==200){
           UpdateVersionInfo updateVersionInfo =  UpdateVersionInfo.fromJson(res.info);

           FlutterXUpdate.updateByInfo(updateEntity: customParseJson(updateVersionInfo));
         }

       });*/

      NetUtils.requestAppVersionAndroid()
          .then((res) async {

        if(res.code==200){

          _updateVersionInfo = UpdateVersionInfo.fromJson(res.info);





          //获取当前版本
          PackageInfo packageInfo = await PackageInfo.fromPlatform();

          int  buildNumber =  int.parse(packageInfo.buildNumber); // 本地版本

          int  versioncode =  int.parse(_updateVersionInfo.versioncode); // 服务器版本




          if(buildNumber<versioncode){ // 如果本地 小于  服务器  开始提示更新

            // ios 和 android 的更新提示
            if (Platform.isIOS) {  // 如果是 ios 手机 直接跳转到 appstore更新

              final url = "https://itunes.apple.com/cn/app/id1484902664"; // id 后面的数字换成自己的应用 id 就行了
              if (await canLaunch(url)) {
                await launch(url, forceSafariVC: false);
              } else {
                throw 'Could not launch $url';
              }

            }else{

              //获取权限
              var per = await checkPermission();
              if(per != null && !per){
                return null;
              }

              _showUpdateDialog(_updateVersionInfo.versionname,_updateVersionInfo.downdress,_updateVersionInfo.status==2?true:false);

            }




          }

        }


      });


    }else{ // ios 版本检查更新  一般用不到此接口  除非要修复 ios特有的bug

    }


  }


  ///将自定义的json内容解析为UpdateEntity实体类
  UpdateEntity customParseJson(UpdateVersionInfo json) {
    return UpdateEntity(
        hasUpdate:true,
        isForce: false,
        isIgnorable:false,
        versionCode: 112,
        versionName:"222",
        updateContent: "6666",
        downloadUrl: "444",
        apkSize: 222);
//    return UpdateEntity(
//        hasUpdate:true,
//        isForce: json.status==2?true:false,
//        isIgnorable:false,
//        versionCode: int.parse(json.versioncode),
//        versionName: json.versionname,
//        updateContent: json.remark.replaceAll(" ", "\n"),
//        downloadUrl: json.downdress,
//        apkSize: int.parse(json.size));
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          cXM(ScreenUtil().setWidth(27)),
          Image.asset(wrapAssets("logo3.png"),width: ScreenUtil().setWidth(180),height: ScreenUtil().setHeight(66)),
          cXM(ScreenUtil().setWidth(33)),
          buildAppbarView(),
          InkWell(
            onTap: (){
              RRouter.push(context, Routes.taskNewPage,{}); // 跳转积分首页
            },
            child: Image.asset(wrapAssets("home/integral_btn.png"),width: ScreenUtil().setWidth(204),height: ScreenUtil().setHeight(100),),

          ),

          InkWell(
            onTap: (){
           //   FLToast.info(text: "暂无内容");
              RRouter.push(context ,Routes.noticeHomePage,{},transition:TransitionType.cupertino);
              //RRouter.push(context, Routes.noticeHomePage,{});
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


          ),
          cXM(setW(10))


        ],



      ),


    );



  }


  ///
  ///  弹出筛选的view
  ///
  buildScreenView() {

    List<TabNewsIndexInfoCateList> list;
    List<String> _nameList;
    /// 从本地 获取数据
    if(LocalStorage.getObject("TabNewsIndexInfoCateList")!=null){

      Map json = LocalStorage.getObject("TabNewsIndexInfoCateList");
      TabNewsIndexInfo  _newsIndexInfo  =  TabNewsIndexInfo.fromJson(json);
      list =  _newsIndexInfo.cateList;
     _nameList =  list.map((item) => item.name).toList();
    }

    return  Visibility(
        visible: _showScreenView,
        child: Column(

          children: <Widget>[

           list==null?Container(): new Container(
              color: Colors.white,
              child: Column(

                children: <Widget>[

                  GridView.count(
                    shrinkWrap: true ,
                    //水平子Widget之间间距
                    crossAxisSpacing: ScreenUtil().setWidth(12),
                    //垂直子Widget之间间距
                    mainAxisSpacing: ScreenUtil().setHeight(17),
                    //GridView内边距
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    //一行的Widget数量
                    crossAxisCount: 4,
                    childAspectRatio: 2.4,
                    //子Widget宽高比例
                    //子Widget列表
                    children: list.map((item) => buildItemView(item.name)).toList(),
                  )


                ],

              ),
            ),
           new Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              height: ScreenUtil().setHeight(105),
              child:  new Row(

                children: <Widget>[
                  FlatButton(
                     padding: EdgeInsets.all(0),
                      onPressed: (){
                    eventBus.fire(new EventBusChangeNew(null));

                  }, child:  Container(
                    padding: EdgeInsets.all(0),
                    width: ScreenUtil().setWidth(540),
                    alignment: Alignment.center,
                    child: Text("重置",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37)),),
                  )),
                  FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){

                        if(_SeleItem.isEmpty){
                          showToast("请先选择分类");
                          return;
                        }
                        eventBus.fire(new EventBusChangeNew(list[_nameList.indexOf(_SeleItem)].id.toString()));
                        setState(() {
                          _showScreenView=false;
                        });
                      }, child:  Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(0),
                    width: ScreenUtil().setWidth(540),
                    alignment: Alignment.center,
                    child: Text("确定",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(37)),),
                  ))
                  
                ],

              ),
              
            ),
           new Expanded(
               child: InkWell(

                 onTap: (){
                   setState(() {
                     _showScreenView=false;
                   });
                 },
                 child: Container(
                   color: Colors.black38,
                 ),
               )
           )

          ],


        )

    );

  }




 Widget buildItemView(String item) {

    return  InkWell(
      onTap: (){

        setState(() {

          _SeleItem = item;

        });
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(14))),
            color: Color( _SeleItem == item?0xFFE3F5FF:0xFFF5F5F5)
        ),
        child: Text(item,style: TextStyle(color: Color( _SeleItem == item?0xFF2CAAEE:0xFF333333),fontSize: ScreenUtil().setSp(32)),),

      ),
    );

  }


  ///
  ///  判断是否需要实名认证
  ///
  void initUserCurrentStatus() {

    NetUtils.requestGetCertification()
        .then((res){

      if(res.code==200){

        _isCertificationInfo =   IsCertificationInfo.fromJson(res.info);

        if(_isCertificationInfo.isCert==1){  // 1 需要  0 不需要

            //  1 医生    2 推广经理  根据角色类型调换不同的实名认证页面
            requestIsRZ(context,_isCertificationInfo.regType.toString());
        }


     }

    });

  }

  StreamSubscription changeSubscription;
  void initEventBusListener() {

      changeSubscription =  eventBus.on<EventBusChangeNew>().listen((event) {

        // 重置数据
        if(event.v==null){
          setState(() {
            _SeleItem = null;
            _showScreenView=false;
          });

        }

      });

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

// 安装
Future<Null> _installApk() async {

  OpenFile.open(APPConfig.APK_PATH);

}






