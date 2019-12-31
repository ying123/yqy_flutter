import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/bean/news_list_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';




class SearchHomePage extends StatefulWidget {
  @override
  _SearchHomePageState createState() => _SearchHomePageState();
}

class _SearchHomePageState extends State<SearchHomePage> with SingleTickerProviderStateMixin {

  String  key;




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:  buildAppbarView(),
        elevation: 0,
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text("取消",style: TextStyle(color: Colors.black38),),
            )
          ),
          cXM(ScreenUtil().setWidth(25))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          cYM(ScreenUtil().setHeight(40)),
          buildTitleView("搜索历史"),
          buildHosListView(context),
          cYM(ScreenUtil().setHeight(40)),
          buildTitleView("热门搜索"),
          buildHosListView(context),

        ],
      )


    );
  }


  Widget  buildAppbarView() {

    return  InkWell(

      onTap: (){
       // RRouter.push(context, Routes.searchHomePage,{});

      },
      child: Container(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
        alignment: Alignment.centerLeft,
        height: ScreenUtil().setHeight(90),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(22))),
          color: Color(0xfff5f5f5),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.search,size: ScreenUtil().setWidth(70),color: Colors.black38,),
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(fontSize: ScreenUtil().setSp(40)),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "请输入您想要搜索的内容",
                        hintStyle: TextStyle(color: Colors.black38,fontSize: ScreenUtil().setSp(40)),
                        border: InputBorder.none,
                    ),
                    onChanged: (v){
                      key = v;
                    },
                    onEditingComplete: (){
                      eventBus.fire(EventBusChange(key));
                    },
                  ),

                )

            )

          ],
        )


      ),
    );

  }

  buildTitleView(String v) {


    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(27), 0, 0, 0),
      child: Text(v,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.bold),),
    );


  }


  ///
  ///  历史搜索页面
  ///
  buildHosListView(BuildContext context) {

    return GridView.count(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing:  ScreenUtil().setHeight(17),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(14),
      //GridView内边距
      padding: EdgeInsets.all(10.0),
      //一行的Widget数量
      crossAxisCount: 4,
      //子Widget宽高比例
      childAspectRatio: 2.2,
      //子Widget列表
      children: [
        itemListView(),
        itemListView(),
        itemListView(),
        itemListView(),
        itemListView(),
        itemListView(),
        itemListView()
        
      ]
    );
  }

  itemListView() {

    return Container(
      width: ScreenUtil().setWidth(173),
      height: ScreenUtil().setHeight(81),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(40))),
        color: Color(0xFFF6F6F6)
      ),
      child: Text("中医",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(32)),),

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


  String  key = "";

  StreamSubscription changeSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeSubscription =  eventBus.on<EventBusChange>().listen((event) {
      setState(() {
        key = event.url;
        loadData();
      });
    });

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    changeSubscription.cancel();
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

    print("key:"+key);

    if(key!=""){
      NetworkUtils.requestVideoListDataKey(page,key)
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
        });
      });
    }else{
      _videoListEntity =null;
    }


  }

  @override
  Widget build(BuildContext context) {
    return  _videoListEntity==null? Center(child: Text(key==""?"":"暂无内容")):AnimationLimiter(
      child:SmartRefresher(
        enablePullDown: false,
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





class TabNewsPage extends StatefulWidget {
  @override
  _TabNewsPageState createState() => _TabNewsPageState();
}

class _TabNewsPageState extends State<TabNewsPage> with AutomaticKeepAliveClientMixin{




  int page = 1;

  NewsListEntity  _newsListEntity ;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  String  key = "";

  StreamSubscription changeSubscription;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    changeSubscription =  eventBus.on<EventBusChange>().listen((event) {
      setState(() {
        key = event.url;
        loadData();
      });
    });

  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    changeSubscription.cancel();
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

    if(key!=""){

      NetworkUtils.requestNewsListDataKey(page,key)
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
        });
      });

    }else{
      _newsListEntity = null;
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:  ListView.builder(
            itemCount:_newsListEntity==null?1:_newsListEntity.xList.length+1,
            itemBuilder: (context,index) {

              return  _newsListEntity==null?Center(child: Text(key==""?"":"暂无内容")):index==0?cYMW(15):getLiveItemView(context,_newsListEntity.xList[index-1]);

            }

        ),

      ),

    );
  }

  Widget getLiveItemView(BuildContext context,NewListList xlist) {


    return GestureDetector(

      onTap: (){
        RRouter.push(context, Routes.newsContentPage, {"id":xlist.id});
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

                  getContentText("来源："+xlist.source),

                  getContentText(xlist.createTime),

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







