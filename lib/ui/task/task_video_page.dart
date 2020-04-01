import 'dart:async';
import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/task/bean/task_video_entity.dart';
import 'package:yqy_flutter/ui/task/bean/video_task_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/CustomFijkPanel.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TaskVideoPage extends StatefulWidget {
  String  tid;

  TaskVideoPage(this.tid);

  @override
  _TaskVideoPageState createState() => _TaskVideoPageState();
}

class _TaskVideoPageState extends State<TaskVideoPage>   with WidgetsBindingObserver{

  FijkPlayer player = FijkPlayer();

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  VideoTaskInfo _taskVideoInfo;

  StreamSubscription _currentPosSubs;
  Duration _currentPos;

  int videoNode = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    FlutterUmplus.beginPageView(runtimeType.toString());
    initData();
    player.addListener(_fijkValueListener);
    _currentPos = player.currentPos;
    _currentPosSubs = player.onCurrentPosUpdate.listen((v) {

        if(videoNode != v.inSeconds){

          videoNode = v.inSeconds;

           uploadData();

        }
    });



  }


  @override
  void dispose() {
    // TODO: implement dispose
    FlutterUmplus.endPageView(runtimeType.toString());
    player.removeListener(_fijkValueListener);
    player.release();
    player=null;
    _currentPosSubs?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();


  }

  ///
  ///  监听 播放器的状态接口
  ///
  void _fijkValueListener() {

    FijkValue value = player.value;

    // 准备完毕  跳转到之前的播放进度
    if (value.state == FijkState.prepared) {
          player.seekTo(_taskVideoInfo==null?0:_taskVideoInfo.playTime*1000);
    }

    // 播放完成
    if(value.state == FijkState.completed){
       completedVideo();
    }

  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if(state==AppLifecycleState.paused){
      player.pause();
    }

    if(state==AppLifecycleState.resumed){
      player.start();
    }

  }


  void initData() {
    NetUtils.requestPointsVideoTask(widget.tid)
        .then((res){

      if(res.code==200){
        _taskVideoInfo = VideoTaskInfo.fromJson(res.info);
      }
      setState(() {
         player.setDataSource(_taskVideoInfo.playUrl, autoPlay: true);
        _layoutState = loadStateByCode(res.code);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 1080, height: 1920);
    return Scaffold(

      appBar: AppBar(
        title: Text("视频任务"),
        centerTitle: true,
      ),

      body:  LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
         this.initData();
      },
      successWidget:_taskVideoInfo==null?Container(): Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
            buildVideoView(),
            cYM(ScreenUtil().setHeight(60)),
            Container(
              padding: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
              alignment: Alignment.centerRight,
              width: double.infinity,
            ),
            Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
              child: Text(_taskVideoInfo.title,style: TextStyle(fontSize: ScreenUtil().setSp(45)),),
            ),
            cYM(ScreenUtil().setHeight(100)),
            Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
              child: Html(
                data: _taskVideoInfo.desc,
              ),
            ),

        ],

      ),

      )
    );
  }

  Widget buildVideoView() {

      return   Container(
        color: Colors.black,
        height: setH(450),
        width: double.infinity,
        child:FijkView(
          color: Colors.black,
          width: double.infinity,
          height: double.infinity,
          player: player,
          panelBuilder: (FijkPlayer player,
          // 重置UI  当前是没有进度条的视频框
          FijkData data, BuildContext context, Size viewSize, Rect texturePos) {
               return CustomFijkPanel(
                    player: player,
                    buildContext: context,
                     viewSize: viewSize,
                     texturePos: texturePos);
          },
        ),
      );

  }


  ///
  ///  提交问题
  ///
  void subData() {

  }


  ///
  ///  上传视频播放的进度
  ///
  void uploadData() async{

    NetUtils.requestPointsVideoNode(widget.tid,videoNode.toString())
        .then((res){

    });

  }




  ///
  ///  当前 视频 播放完成   提交完成任务的接口
  ///
  void completedVideo() {

    NetUtils.requestPointsCompleteVideoTask(widget.tid)
        .then((res){


          if(res.code==200){

            showReceiveDialogView(res.info["points"],res.info["msg"]);

          }

    });

  }
  ///
  ///  积分领取成功弹窗
  ///
  void showReceiveDialogView(var nums,String msg) {

    showDialog(context: context,

        builder: (_)=>Material(
          color: Colors.transparent,
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(setW(40), setW(650), setW(40), setW(900)),
              child: Stack(

                children: <Widget>[
                  Image.asset(wrapAssets("task/bg_finish.png"),width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                  Positioned(left: setW(200),top: setH(260),child: Text("您已获得 "+nums.toString()+" 积分",style: TextStyle(color: Colors.white,fontSize: setSP(75),fontWeight: FontWeight.w900,fontStyle: FontStyle.italic),)),
                  Positioned(left: setW(175),bottom: setH(20),child: Container(
                    width: setW(600),
                    margin: EdgeInsets.fromLTRB(setW(20),0, 0, setW(20)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Expanded(child:  Text(msg,style: TextStyle(color: Colors.white,fontSize: setSP(40))))

                      ],

                    ),

                  ))


                ],

              )

          ),


        )
    );

    Future.delayed(Duration(seconds: 2)).then((_){

      Navigator.pop(context);
      Navigator.pop(context);

    });



  }


}
