import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/bean/news_list_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';


///
///   我的足迹页面
///
class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}


final _tabDataList = <_TabData>[
  _TabData(tab: Center(child: Text("学术会议"),), body: VideoMeetingPage()),
  _TabData(tab:  Center(child: Text("文章资讯")), body: TabNewsPage()),
  _TabData(tab:  Center(child: Text("学术专区")), body: Center(child: Text("暂无内容"),)),
];



class MyFootPage extends StatefulWidget  {
  @override
  _MyFootPageState createState() => _MyFootPageState();
}

class _MyFootPageState extends State<MyFootPage>  with SingleTickerProviderStateMixin  {

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  final tabBarViewList = _tabDataList.map((item) => item.body).toList();

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabBarList.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back,color: Colors.black,),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("我的足迹",style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        bottom: new TabBar(
          controller: _tabController,
          tabs: tabBarList,
          indicatorColor: Colors.blueAccent, //指示器颜色 如果和标题栏颜色一样会白色
          labelColor: Colors.blueAccent ,
          labelPadding: EdgeInsets.fromLTRB(0,0,0,15),
          unselectedLabelColor: Colors.black,
          unselectedLabelStyle: TextStyle(fontSize: 16),
          labelStyle: TextStyle(fontSize: 16),
        ),

      ),

      body: TabBarView(
          controller: _tabController,
          children: tabBarViewList
      ),

    );
  }
}




class VideoMeetingPage extends StatefulWidget {
  @override
  _VideoMeetingPageState createState() => _VideoMeetingPageState();
}


class _VideoMeetingPageState extends State<VideoMeetingPage> with AutomaticKeepAliveClientMixin{

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  int page = 1;

  VideoListEntity  _videoListEntity ;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }

  void _onRefresh() async{
    page = 1;
    loadData();
  }

  void _onLoading() async{
    page ++;
    loadData();
  }


  loadData () async{
    NetworkUtils.requestFootOne(page.toString())
        .then((res) {
      int statusCode = int.parse(res.status);

      if(statusCode==9999){
        if(page>1){
          if (VideoListEntity .fromJson(res.info).xList.length == 0){
            _refreshController.loadNoData();
          } else {
            _videoListEntity.xList.addAll(VideoListEntity
                .fromJson(res.info)
                .xList);
            _refreshController.loadComplete();
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
    });

  }

  @override
  Widget build(BuildContext context) {
    return LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        this.loadData();
      },
      successWidget:

      SmartRefresher(
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


}


///
///   会议列表item
///
Widget getLiveItemView(context,VideoListList listBean){

  return  GestureDetector(


    onTap: (){
      //4-会议预告，5-会议直播，6-视频回顾，7-音频回顾，8-图文回顾
      switch(listBean.type){
        case "5":
          RRouter.push(context, Routes.liveDetailsPage,{"broadcastId":listBean.click_id});
          break;
        case "6":
          RRouter.push(context, Routes.videoDetailsPage,{"reviewId":listBean.click_id});
          break;
      }
    },

    child: new Container(
      height: 100,
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          // Icon(Icons.apps,size: 110,color: Colors.blueAccent,),
          //  wrapImageUrl(listBean.image,110.0, 110.0),
          CachedNetworkImage(imageUrl: listBean.image,fit: BoxFit.fill,height: 90,width:110,),
          //  new Image(image: new CachedNetworkImageProvider("http://via.placeholder.com/350x150"),width: 110,height: 110,color: Colors.black,),
          cXM(8),
          new Container(
              width: 255,
              decoration: new BoxDecoration(
                  border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text(listBean.title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),

                  ),
                  cYM(10),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new  Row(
                        children: <Widget>[
                          Icon(Icons.access_time,size: 16,color: Colors.black45,),
                          cXM(5),
                          Text(listBean.startTime,style: TextStyle(color: Colors.black45,fontSize: 14),),
                        ],

                      ),

                      //       Text("看录播",style: TextStyle(color: Colors.greenAccent),)

                    ],
                  ),


                ],

              )

          )


        ],


      ),

    ),


  );

}




///
///   收藏的新闻列表页面
///
class TabNewsPage extends StatefulWidget {
  @override
  _TabNewsPageState createState() => _TabNewsPageState();
}

class _TabNewsPageState extends State<TabNewsPage> with AutomaticKeepAliveClientMixin{



  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  int page = 1;

  NewsListEntity  _newsListEntity ;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }



  void _onRefresh() async{
    page = 1;
    loadData();
  }

  void _onLoading() async{
    page ++;
    loadData();
  }

  loadData () async{
    NetworkUtils.requestFootThree(page.toString())
        .then((res) {
      int statusCode = int.parse(res.status);
      if(statusCode==9999){
        if(page>1){
          if (NewsListEntity
              .fromJson(res.info)
              .xList.length == 0) {
            _refreshController.loadNoData();
          } else {
            _newsListEntity.xList.addAll(NewsListEntity.fromJson(res.info).xList);
            _refreshController.loadComplete();
          }

        }else{
          _newsListEntity = NewsListEntity.fromJson(res.info);
          _refreshController.refreshCompleted();
          _refreshController.resetNoData();
        }
      }
      setState(() {
        _layoutState = loadStateByCode(statusCode);
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          this.loadData();
        },
        successWidget:
        SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child:  ListView.builder(
              itemCount:_newsListEntity==null?1:_newsListEntity.xList.length+1,
              itemBuilder: (context,index) {

                return  _newsListEntity==null?Container():index==0?cYMW(15):getLiveItemView(context,_newsListEntity.xList[index-1]);

              }

          ),

        ),

      ),


    );


  }





  Widget getLiveItemView(BuildContext context,NewListList xlist) {


    return GestureDetector(

      onTap: (){
        //4-会议预告，5-会议直播，6-视频回顾，7-音频回顾，8-图文回顾
        switch(xlist.type){
          case "11":
            RRouter.push(context, Routes.newsContentPage,{"id":xlist.click_id});
            break;
          case "12":
            RRouter.push(context, Routes.zxContentPage,{"id":xlist.click_id});
            break;
          case "13":
            RRouter.push(context, Routes.gfContentPage,{"id":xlist.click_id});
            break;
        }

      },
      child: new Container(

        color: Colors.white,

        height: 90,

        child: new Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: <Widget>[

            new   Container(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child:   getTitleText(xlist.title),
            ),

            new  Container(

              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

              child:  new  Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: <Widget>[

                  getContentText("来源："+xlist.source.toString()),

                  getContentText(xlist.time.toString()),

                ],


              ),
            ),
            Divider(height: 1,color: Colors.black26,)
          ],


        ),

      ),
    );



  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
