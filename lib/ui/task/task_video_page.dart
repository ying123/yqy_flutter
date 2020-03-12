import 'dart:async';
import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/task/bean/task_video_entity.dart';
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

class _TaskVideoPageState extends State<TaskVideoPage> {

  final FijkPlayer player = FijkPlayer();

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  TaskVideoInfo _taskVideoInfo;

  StreamSubscription _currentPosSubs;
  Duration _currentPos;

  int videoNode = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
    super.dispose();
    player.removeListener(_fijkValueListener);
    player.release();
    _currentPosSubs?.cancel();
  }

  ///
  ///  监听 播放器的状态接口
  ///
  void _fijkValueListener() {

    FijkValue value = player.value;


    // 准备完毕  跳转到之前的播放进度
    if (value.state == FijkState.prepared) {
         player.seekTo(_taskVideoInfo==null?0:int.parse(_taskVideoInfo.playTime)*1000);
    }


    // 播放完成
    if(value.state == FijkState.completed){
       completedVideo();
    }


  }

  void initData() {
    NetworkUtils.requestTaskVideo(widget.tid)
        .then((res){

      int statusCode = int.parse(res.status);
      if(statusCode==9999){
        _taskVideoInfo = TaskVideoInfo.fromJson(res.info);
      }
      setState(() {
         player.setDataSource(_taskVideoInfo.playUrl, autoPlay: true);
        _layoutState = loadStateByCode(statusCode);
      });

    });
  }

  @override
  Widget build(BuildContext context) {
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
            /*  child: InkWell(
                onTap: (){
                  subData();
                },
                child:  Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(200),
                  height: ScreenUtil().setHeight(90),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12))),
                  ),
                  child: Text("答题",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(40)),),

                ),
              ),*/
            ),
            Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
              child: Text(_taskVideoInfo.title,style: TextStyle(fontSize: ScreenUtil().setSp(45)),),
            ),
            cYM(ScreenUtil().setHeight(100)),
            Container(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
              child: Text(_taskVideoInfo.content),
            ),

        ],

      ),

      )
    );
  }

  Widget buildVideoView() {

      return   Container(
        color: Colors.black,
        height: 220,
        width: double.infinity,
        child:FijkView(
          color: Colors.black,
          width: double.infinity,
          height: double.infinity,
          player: player,
         /* panelBuilder: (FijkPlayer player, BuildContext context, Size viewSize, Rect texturePos) {
            return CustomFijkPanel(
                player: player,
                buildContext: context,
                viewSize: viewSize,
                texturePos: texturePos);
          },*/
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


    NetworkUtils.requestTaskVideoNode(widget.tid,videoNode.toString())
        .then((res){


    });


  }

  void completedVideo() {

    NetworkUtils.requestTaskVideoComplete(widget.tid)
        .then((res){

         if(res.status=="9999"){
           showToast(res.message);
         }

         eventBus.fire(new EventBusChange(res.message));

         Navigator.pop(context);



     });
  }


}
