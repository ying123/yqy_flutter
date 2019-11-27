import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/bean/live_list_entity.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';


class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}


final _tabDataList = <_TabData>[
  _TabData(tab: Center(child: Text("学术会议"),), body: LiveMeetingPage()),
  _TabData(tab:  Center(child: Text("互动会议")), body: LiveInteractionPage()),
];


class LiveHomePage extends StatefulWidget {

  String type;

  LiveHomePage(this.type);

  @override
  _LiveHomePageState createState() => _LiveHomePageState();
}

class _LiveHomePageState extends State<LiveHomePage> with TickerProviderStateMixin{





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
    FlutterUmplus.beginPageView('直播列表页面');
  }

  @override
  void dispose() {
      FlutterUmplus.endPageView('直播列表页面');
    // FIXME 这个最好放在最后，iOS有效，Android无论如何都无效。
    _tabController.dispose();
    super.dispose();
  }


  




  @override
  Widget build(BuildContext context) {
      return Scaffold(

        appBar: AppBar(
          titleSpacing: 0,
          leading:widget.type==null?Container():GestureDetector(
            child: Icon(Icons.arrow_back,color: Colors.black,),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text("会议直播",style: TextStyle(color: Colors.black),),
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
class LiveMeetingPage extends StatefulWidget {
  @override
  _LiveMeetingPageState createState() => _LiveMeetingPageState();
}


class _LiveMeetingPageState extends State<LiveMeetingPage> with AutomaticKeepAliveClientMixin{

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  int page = 1;

  LiveListInfo _liveListEntity;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }

  loadData () async{


    NetworkUtils.requestHosListData(page)
          .then((res){
      int statusCode = int.parse(res.status);

      if(statusCode==9999){

        if(page>1){
          if (LiveListInfo .fromJson(res.info) .xList.length == 0){
            _refreshController.loadNoData();
          } else {
            _liveListEntity.xList.addAll(LiveListInfo
                .fromJson(res.info)
                .xList);
            _refreshController.loadComplete();
          }
        }else{
          _liveListEntity = LiveListInfo.fromJson(res.info);
          _refreshController.refreshCompleted();
          _refreshController.resetNoData();
        }

      }
      setState(() {
        _layoutState = loadStateByCode(statusCode);
      });
    });
  }


  void _onRefresh() async{
    page = 1;
    loadData();
  }

  void _onLoading() async{
    page ++;
    loadData();
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
      _liveListEntity==null?Container():AnimationLimiter(
      child:SmartRefresher(
    enablePullDown: true,
    enablePullUp: true,
    controller: _refreshController,
    onRefresh: _onRefresh,
    onLoading: _onLoading,
    child: ListView.builder(
          itemCount: _liveListEntity.xList.length,
          itemBuilder: (context,index){
            return  AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 1000),
              child: FadeInAnimation(
                child: getLiveItemView(_liveListEntity.xList[index],context	),
              ),

            );


          }
      ),

    ),
      ),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}




///
///   互动直播页面
///
class LiveInteractionPage extends StatefulWidget {
  @override
  _LiveInteractionPageState createState() => _LiveInteractionPageState();
}

class _LiveInteractionPageState extends State<LiveInteractionPage> with AutomaticKeepAliveClientMixin {


  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  int page = 1;

  LiveListInfo _liveListEntity;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }

  loadData () async{


    NetworkUtils.requestInteractListData(page)
        .then((res){
      int statusCode = int.parse(res.status);

      if(statusCode==9999){

        if(page>1){

          if (LiveListInfo .fromJson(res.info) .xList.length == 0){
            _refreshController.loadNoData();
          } else {
            _refreshController.loadNoData();
            _liveListEntity.xList.addAll(LiveListInfo
                .fromJson(res.info)
                .xList);
          }
        }else{
          _liveListEntity = LiveListInfo.fromJson(res.info);
          _refreshController.refreshCompleted();
          _refreshController.resetNoData();
        }

      }
      setState(() {
        _layoutState = loadStateByCode(statusCode);
      });
    });
  }


  void _onRefresh() async{
    page = 1;
    loadData();
  }

  void _onLoading() async{
    page ++;
    loadData();
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
      _liveListEntity==null?Container():SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:ListView.builder(
            itemCount: _liveListEntity.xList.length,
            itemBuilder: (context,index){

              return getLiveItemView2(_liveListEntity.xList[index],context);
            }
        ),

      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}



///
///   直播列表item
///
Widget getLiveItemView(	LiveListInfoList  bean,BuildContext context){

  return  GestureDetector(

    onTap: (){
      bean.review_id==null||bean.review_id==""?RRouter.push(context ,Routes.liveDetailsPage,{"broadcastId":bean.id},transition:TransitionType.cupertino):RRouter.push(context ,Routes.videoDetailsPage,{"reviewId":bean.review_id},transition:TransitionType.cupertino);
    },
    child: new Container(
      height: 100,
      color: Colors.white,
      child: Row(

        children: <Widget>[
          cXM(5),
         CachedNetworkImage(imageUrl: bean.image,fit: BoxFit.fill,height: 90,width:110,),
          cXM(8),
         Expanded(
             child:
             new Container(
              padding: EdgeInsets.only(right: 10),
             decoration: new BoxDecoration(
                 border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
             ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                 Container(
                   padding: EdgeInsets.only(top: 15),
                   child: Text(bean.title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),
                 ),
                 cYM(10),
                 new Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     new  Row(
                       children: <Widget>[
                         Icon(Icons.access_time,size: 16,color: Colors.black45,),
                         cXM(5),
                         Text(bean.startTime,style: TextStyle(color: Colors.black45,fontSize: 14),),

                       ],

                     ),

                     getTextType(bean)

                   ],
                 ),


               ],

             )
         ))


        ],


      ),

    ),

  );

}

Widget getTextType(LiveListInfoList bean) {


  if(bean==null){

    return Container();
  }


  // 1：直播中，2:未开始，0:已结束
  if(bean.isPlay=="1"){

   return   Text("直播中",style: TextStyle(color: Colors.redAccent));

  }else if(bean.isPlay=="2"){


    return  Text("未开始",style: TextStyle(color: Colors.blueAccent));

  }else if(bean.isPlay=="0"){


    return  Text(bean.review_id==null||bean.review_id==""?"已结束":"看录播",style: TextStyle(color: bean.review_id==null||bean.review_id==""?Colors.black12:Colors.greenAccent));

  }else{

    return  Text("已结束",style: TextStyle(color: Colors.black12));

  }




}


///
///   互动直播列表item
///
Widget getLiveItemView2(LiveListInfoList  bean,BuildContext context){

  return  GestureDetector(
    onTap: (){
      bean.review_id==null||bean.review_id==""?RRouter.push(context ,Routes.hdDetailsPage,{"interactId":bean.id},transition:TransitionType.cupertino):RRouter.push(context ,Routes.videoDetailsPage,{"reviewId":bean.review_id},transition:TransitionType.cupertino);
    },
    child: new Container(
      height: 100,
      color: Colors.white,
      child: Row(

        children: <Widget>[
          cXM(5),
          CachedNetworkImage(imageUrl: bean.image,fit: BoxFit.fill,height: 90,width:110,),
          cXM(8),
          Expanded(
              child:
              new Container(
                  padding: EdgeInsets.only(right: 10),
                  decoration: new BoxDecoration(
                      border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
                  ),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[

                 Container(
                   padding: EdgeInsets.only(top: 15),
                   child: Text(bean.title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),

                 ),
                 cYM(10),
                 new Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     new  Row(
                       children: <Widget>[
                         Icon(Icons.access_time,size: 16,color: Colors.black45,),
                         cXM(5),
                         Text(bean.start_time??"",style: TextStyle(color: Colors.black45,fontSize: 14),),
                       ],

                     ),
                     getTextType(bean)

                   ],
                 ),


               ],

             )





         ))


        ],


      ),

    ),


  );

}