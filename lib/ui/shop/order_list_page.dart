import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';


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
              return _videoListEntity == null ? Container() : getListItemView(
                  context, _videoListEntity.xList[index]);
            }

        ),
      ),
    );
  }

 Widget  getListItemView(BuildContext context, VideoListList xList) {

    return Container(

      height: setH(494),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

        new  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              buildText("2020-01-19  09:30:50",size: 32,color: "#FF999999"),
              buildText("已发货",size: 32,color: "#FF999999"),

            ],
          ),

         new Row(
            children: <Widget>[

              wrapImageUrl("", setW(173),  setW(173)),

              Column(

                children: <Widget>[

                  buildText("复方黄柏液涂剂护手装"),
                  buildText("50积分x2",size: 29,color: "#FF999999"),



                ],
              )

            ],
          ),

          new Container(
            alignment: Alignment.centerRight,
            child: buildText("共2件商品，合计",size: 26,color: "#FF999999"),

          ),


          new Container(
              width: double.infinity,
              alignment: Alignment.centerRight,
              child: Container(
                width: setW(288),
                height: setH(86),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(setW(43))),
                  border: Border.all(color: Color(0xFF999999),width: setW(1))
                ),
                child: buildText("查看物流 "),
              ),
          )


        ],
      ),
      


    );

  }
}
