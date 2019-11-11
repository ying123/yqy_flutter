import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';


class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {


  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  int page = 1;
  VideoListEntity  _videoListEntity ;


  void _onRefresh() async{
    // monitor network fetch
    //   await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    page = 1;
    loadData();
  }

  void _onLoading() async{
    page ++;
    loadData();
  }
  loadData () async{
   /* NetworkUtils.requestVideoListData(page)
        .then((res) {
      //   if (res.status == 200) {
      *//*   print("res.toString():"+res.toString());
        print("res.info():"+res.info.toString());
        print("_videoListEntity.toString():"+_videoListEntity.toString());*//*
      int statusCode = int.parse(res.status);

      if(statusCode==9999){
        if(page>1){
          if (VideoListEntity .fromJson(res.info).xList.length == 0){
            _refreshController.loadNoData();
          } else {
            _refreshController.loadNoData();
            _videoListEntity.xList.addAll(VideoListEntity
                .fromJson(res.info)
                .xList);
          }
        }else{
          _videoListEntity = VideoListEntity.fromJson(res.info);
          _refreshController.refreshCompleted();
          _refreshController.resetNoData();
        }
      }

      setState(() {
        _layoutState = loadStateByCode(statusCode);
      });
    });*/

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        centerTitle: true,

        title: Text("兑换记录"),

      ),

      body:  SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:  ListView.builder(
            itemCount: _videoListEntity==null?1:_videoListEntity.xList.length,
            itemBuilder: (context,index) {
              return _videoListEntity == null ? Container() : getLiveItemView(
                  context, _videoListEntity.xList[index]);
            }

        ),
      ),
    );
  }

 Widget  getLiveItemView(BuildContext context, VideoListList xList) {


  }
}
