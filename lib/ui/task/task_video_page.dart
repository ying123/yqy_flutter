import 'dart:math';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/task/bean/task_video_entity.dart';
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

  Duration _duration = Duration();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    player.release();
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
          panelBuilder: (FijkPlayer player, BuildContext context, Size viewSize, Rect texturePos) {
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


}
