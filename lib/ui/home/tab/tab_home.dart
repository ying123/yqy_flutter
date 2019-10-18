import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/home/bean/home_data_entity.dart';
import 'package:yqy_flutter/ui/home/bean/live_list_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/route_handlers.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:yqy_flutter/widgets/marquee_view.dart';

class TabHomePage extends StatefulWidget {

  @override
  _TabHomePageState createState() => _TabHomePageState();
}


class _TabHomePageState extends State<TabHomePage> with AutomaticKeepAliveClientMixin {


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => false;



  //页面加载状态，默认为加载中
  LoadState _layoutState ;


  RefreshController _refreshController ;

  List<String> marqueeList ;


  HomeDataEntity _homeDataEntity;

  LiveListInfo _liveListEntity;

  VideoListEntity _videoListEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _layoutState = LoadState.State_Loading;
    _refreshController  = RefreshController(initialRefresh: false);
    loadData();
  }



  loadData () async{

    Future.wait([

    NetworkUtils.requestHomeData(), //轮播图 新闻
    NetworkUtils.requestHosListData(1), // 热门
    NetworkUtils.requestVideoListData(1),  // 往期

    ]).then((results){

      int statusCode = int.parse(results[0].status);


      _homeDataEntity = HomeDataEntity.fromJson(results[0].info);

      _liveListEntity = LiveListInfo.fromJson(results[1].info);

      _videoListEntity = VideoListEntity.fromJson(results[2].info);


      setState(() {
        _layoutState = loadStateByCode(statusCode);
      });
    }).catchError((e){
      setState(() {
        _layoutState = loadStateByCode(-2);
      });
    });



  }

  void _onRefresh() async{
    // monitor network fetch
   // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    loadData();
    _refreshController.refreshCompleted();
    _refreshController.resetNoData();
  }

  void _onLoading() async{
    // monitor network fetch
    //await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
  //  items.add((items.length+1).toString());
  /*  if(mounted){
      setState(() {
      });
    }*/
    _refreshController.loadNoData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
      setState(() {
        _layoutState = LoadState.State_Loading;
      });
      this.loadData();
    },
    successWidget:
    _homeDataEntity==null?Container():SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
        header: BezierCircleHeader(),
           child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[

            cYMW(15),

            getBannerView(_homeDataEntity.banner), //轮播图


           getMarqueeView(_homeDataEntity.medicalNews),//跑马灯

            getGridBtnView(), //图片按钮

            getRowTextView("热门会议"),//热门会议标题栏
            getHotVideo(_liveListEntity.xList??new List()),//热门会议视频横向列表
            cYM(10),
            getRowTextView("往期会议"),//热门会议标题栏
            getHisVideoView(_videoListEntity.xList??new List(),0),
            getHisVideoView(_videoListEntity.xList??new List(),1),
            cYM(10),
            getRowTextView("名医分享"),//往期会议标题栏
            getDocView(_homeDataEntity.user??new List(),0),
            getDocView(_homeDataEntity.user??new List(),1)

          ],

        ),
      )
    ),
    );
  }


  Widget getBannerView(List<HomeDataBanner> data) {


    print("getBannerView:"+data.length.toString());

    if(data==null){

      return Container();
    }

    return BannerSwiper(
      //width  和 height 是图片的高宽比  不用传具体的高宽   必传
      height: 108,
      width: 54,
      //轮播图数目 必传
      length: data.length??1,
      //轮播的item  widget 必传
      getwidget: (index) {
        return new GestureDetector(
            child:  Image.network(
              data[index % data.length].adFile,
              fit: BoxFit.fill,
            ),
            onTap: () {
              //点击后todo
            });
      },
    );
  }

  Widget   getMarqueeView(List<HomeDatamedicalNews> data){

    if(data==null){

      return Container();

    }else{
      return  new Container(
        padding: EdgeInsets.all(20),
        height: 60,
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Icon(Icons.notifications,size: 22,color: Colors.blueAccent,),
            cXM(5),
            Container(
              width: 310,
              height:60,
              child:  MyNoticeVecAnimation(duration: const Duration(milliseconds: 6000),messages: data.map((e)=>(e.title)).toList()),
            ),

          ],

        ),

      );
    }


  }





  Widget getGridBtnView(){
    return Container(
      height: 80,
      color: Colors.white,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: <Widget>[


          new GestureDetector(

            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               // Icon(Icons.android,size: 30,),
                Image.asset(
                  wrapAssets("icon_streaming.png"),
                  width: 45,
                  height: 45,
                  fit: BoxFit.fill,
                ),
                cYM(2),
                Text("会议直播")

              ],
            ),
            onTap: (){
              RRouter.push(context, Routes.liveMeeting,{"title":"11"});
            },

          ),

          new GestureDetector(

            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Icon(Icons.android,size: 30,),
                Image.asset(
                  wrapAssets("icon_past.png"),
                  width: 45,
                  height: 45,
                  fit: BoxFit.fill,
                ),
                cYM(2),
                Text("往期会议")

              ],
            ),
            onTap: (){
              RRouter.push(context, Routes.videoListPage,{});
            },

          ),
         new GestureDetector(
              onTap: (){
                RRouter.push(context, Routes.specialPage,{"type":"act"});
              },
             child: new Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 Image.asset(
                   wrapAssets("icon_mission.png"),
                   width: 45,
                   height: 45,
                   fit: BoxFit.fill,
                 ),
                 cYM(2),
                 Text("专题视频")
               ],

    ),

         ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                wrapAssets("icon_garden.png"),
                width: 45,
                height: 45,
                fit: BoxFit.fill,
              ),
              cYM(2),
              Text("医学园")

            ],


          )


        ],


      ),


    );
  }


  Widget getRowTextView(String type){


    return Container(
      color: Colors.white,
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          
        new  Row(
            children: <Widget>[
              Text(type,style: TextStyle(color: Colors.black,fontSize: 18),),
              cXM(3),
              Visibility(
                visible: type=="热门会议"?true:false,
                  child:  Icon(Icons.whatshot,color: Colors.red,size: 18,)
              )
              
            ],
            
          ),

        new GestureDetector(

          child: Row(
            children: <Widget>[
              Text("更多",style: TextStyle(color: Colors.black26,fontSize: 14),),
              cXM(2),
              Icon(Icons.arrow_forward_ios,color: Colors.black12,size: 16,),

            ],

          ),

          onTap: (){
            type=="热门会议"?RRouter.push(context, Routes.liveMeeting,{"title":"11"}):
            RRouter.push(context, Routes.videoListPage,{});
          },

        ),



          
          
        ],
        
        
      ),

    );

  }

  Widget getHotVideo(List<LiveListInfoList>  list){

    print("list:"+list.length.toString());

    return list==null?Container(): InkWell(
      child: Container(
        color: Colors.white,
        height: 120,
        child: list.length==1?Image.network(list[0].image):Row(
          children: <Widget>[
            cXM(10),
            new  Expanded(
              child: Image.network(
                list[0].image,
                height: 120,
                fit: BoxFit.fill,
              ),

            )  ,
            cXM(10),
            new   Expanded(
              child: Image.network(
                list[1].image,
                height: 120,
                fit: BoxFit.fill,
              ),

            )  ,
            cXM(10),

          ],

        ),


      ),


    );
  }


  Widget getHisVideoView(List<VideoListList> list,int pos){

     if(pos>list.length-1){

       return Container();
      }

    return list==null?Container(): InkWell(
      onTap: (){
        RRouter.push(context, Routes.videoDetailsPage,{"reviewId":list[pos].id});
      },
      child: Container(
        height: 100,
        color: Colors.white,
        child: Row(

          children: <Widget>[
            cXM(10),
            Image.network(list[pos].image,width: 110,height: 90,fit: BoxFit.fill,),
            cXM(8),
            new Container(
                decoration: new BoxDecoration(
                    border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.only(top: 15),
                      child: Text(list[pos].title,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      width: 240,
                    ),
                    cYM(10),
                    new Row(
                      children: <Widget>[
                        Icon(Icons.access_time,size: 16,color: Colors.black45,),
                        cXM(10),
                        Text((list[pos].startTime),style: TextStyle(color: Colors.black45,fontSize: 14),),
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


  Widget getDocView(List<HomeDataUser> list,int pos){

    if(list==null||pos>list.length-1){

      return Container();
    }

    return Container(
      color: Colors.white,
      height: 100,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        children: <Widget>[

          Image.network(list[pos].userPhoto,width: 90,fit: BoxFit.fill,),

          cXM(15),
          Container(
            width: 240,
            decoration: new BoxDecoration(
                border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
            ),
            child:   new  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                cYM(15),
                Text(list[pos].realname,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),),
                cYM(5),
                Text(list[pos].userInfo??"该用户尚未填写简介....",style: TextStyle(color: Colors.black45,fontSize: 14),),
                cYM(5),
                new Row(
                  children: <Widget>[
                    Icon(Icons.person,size: 16,color: Colors.black45,),
                    cXM(10),
                    Text(list[pos].jName+list[pos].hName,style: TextStyle(color: Colors.black45,fontSize: 14),),

                  ],

                ),
              ],

            ),

          )


          
          
        ],
        
        
      ),
      
      
    );
    
  }






  

}


