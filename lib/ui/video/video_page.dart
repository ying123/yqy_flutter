import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:oktoast/oktoast.dart';


class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}


final _tabDataList = <_TabData>[
  _TabData(tab: Center(child: Text("视频会议"),), body: VideoMeetingPage()),
  _TabData(tab:  Center(child: Text("音频会议")), body:  Center(child: Text("暂无内容"),)),
  _TabData(tab:  Center(child: Text("图文会议")), body: Center(child: Text("暂无内容"),)),
];


class VideoHomePage extends StatefulWidget {
  @override
  _VideoHomePageState createState() => _VideoHomePageState();
}

class _VideoHomePageState extends State<VideoHomePage> with SingleTickerProviderStateMixin{


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
        title: Text("往期会议",style: TextStyle(color: Colors.black),),
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


///
///   会议直播页面
///
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
    NetworkUtils.requestVideoListData(page)
        .then((res) {
   //   if (res.status == 200) {
     /*   print("res.toString():"+res.toString());
        print("res.info():"+res.info.toString());
        print("_videoListEntity.toString():"+_videoListEntity.toString());*/
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

      _videoListEntity==null?Container():AnimationLimiter(
        child:SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
              itemCount: _videoListEntity.xList.length,
              itemBuilder: (context,index){
                return  AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1000),
                  child: FadeInAnimation(
                    child: getLiveItemView(context,_videoListEntity.xList[index]),
                  ),

                );


              }
          ),

        ),
      ),

    );
  }
}



///
///   列表item
///
Widget getLiveItemView(context,VideoListList listBean){

  return  GestureDetector(

    onTap: (){
      RRouter.push(context, Routes.videoDetailsPage,{"reviewId":listBean.id});
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