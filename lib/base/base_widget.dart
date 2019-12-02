import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/common/constant.dart';

import 'NavigatorManger.dart';

abstract class BaseWidget extends StatefulWidget {
  BaseWidgetState baseWidgetState;



  @override
  BaseWidgetState createState() {
    baseWidgetState = getState();
    return baseWidgetState;
  }

  BaseWidgetState getState();
  String getStateName() {
    return baseWidgetState.getWidgetName();
  }
}

abstract class BaseWidgetState<T extends BaseWidget> extends State<T>
    with WidgetsBindingObserver {
  //平台信息
//  bool isAndroid = Platform.isAndroid;
  BuildContext _contextBaseFunction;
  bool _onResumed = false; //页面展示标记
  bool _onPause = false; //页面暂停标记

  @override
  void initState() {
    _contextBaseFunction = this.context;
    NavigatorManger().addWidget(this);
    WidgetsBinding.instance.addObserver(this);
    onCreate();
    if(mounted){}
    super.initState();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
//    log("----buildbuild---deactivate");
    //说明是被覆盖了
    if (NavigatorManger().isSecondTop(this)) {
      if (!_onPause) {
        onPause();
        _onPause = true;
      } else {
        onResume();
        _onPause = false;
      }
    } else if (NavigatorManger().isTopPage(this)) {
      if (!_onPause) {
        onPause();
      }
    }
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
//    log("------buildbuild---build");
    if (!_onResumed) {
      //说明是 初次加载
      if (NavigatorManger().isTopPage(this)) {
        _onResumed = true;
        onResume();
      }
    }
    return  buildWidget(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    onDestory();
    WidgetsBinding.instance.removeObserver(this);
    _onResumed = false;
    _onPause = false;
    //把改页面 从 页面列表中 去除
    NavigatorManger().removeWidget(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    //此处可以拓展 是不是从前台回到后台
    if (state == AppLifecycleState.resumed) {
      //on resume
      if (NavigatorManger().isTopPage(this)) {
        onForeground();
        onResume();
      }
    } else if (state == AppLifecycleState.paused) {
      //onpause
      if (NavigatorManger().isTopPage(this)) {
        onBackground();
        onPause();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  String getWidgetName() {
    if (_contextBaseFunction == null) {
      return "";
    }
    String className = _contextBaseFunction.toString();
    if (className == null) {
      return "";
    }

    if (APPConfig.DEBUG) {
      try {
        className = className.substring(0, className.indexOf("("));
      } catch (err) {
        className = "";
      }
      return className;
    }

    return className;
  }

  ///初始化一些变量 相当于 onCreate ， 放一下 初始化数据操作
  void onCreate();

  ///相当于onResume, 只要页面来到栈顶， 都会调用此方法，网络请求可以放在这个方法
  void onResume();

  ///页面被覆盖,暂停
  void onPause();

  ///返回UI控件 相当于setContentView()
  Widget buildWidget(BuildContext context);

  ///app切回到后台
  void onBackground() {
    log("回到后台");
  }

  ///app切回到前台
  void onForeground() {
    log("回到前台");
  }

  ///页面注销方法
  void onDestory() {
    log("destory");
  }
  void log(String content) {
    print(getWidgetName() + "------:" + content);
  }
}

