import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/home/bean/home_data_entity.dart';
import 'package:yqy_flutter/ui/home/bean/live_list_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_home_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/route_handlers.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:yqy_flutter/widgets/marquee_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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


  HomeIndexInfo _homeIndexInfo;

  ScrollController _scrollController = new ScrollController(); // 解决嵌套滑动冲突  设置统一滑动

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _layoutState = LoadState.State_Loading;
    _refreshController  = RefreshController(initialRefresh: false);
    loadData();
  }



  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  loadData () async{

      NetUtils.requestIndexIndex()
          .then((res){

            if(res.code==200){

              _homeIndexInfo = HomeIndexInfo.fromJson(res.info);

            }

        setState(() {
          _layoutState = loadStateByCode(res.code);
        });

      }).catchError((err){

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

    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
      setState(() {
        _layoutState = LoadState.State_Loading;
      });
      this.loadData();
    },
    successWidget:
    _homeIndexInfo==null?Container():SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
        header: BezierCircleHeader(),
           child: ListView(
          controller: _scrollController,
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[


            cYM(ScreenUtil().setHeight(25)),

            getBannerView(_homeIndexInfo.bannerList), //轮播图
            getMarqueeView(new List()),//跑马灯
            cYM(ScreenUtil().setHeight(80)),
            getGridBtnView(), //图片按钮
            cYM(ScreenUtil().setHeight(90)),
            getRowTextView("热门视频"),//热门会议标题栏
            getHotVideo(_homeIndexInfo.hotVideo),//热门会议视频横向列表
            cYM(ScreenUtil().setHeight(12)),
            getRowTextView("特约专家"),//往期会议标题栏
            cYM(ScreenUtil().setHeight(12)),
            getDocViews(_homeIndexInfo.recomDoctor),
            cYM(ScreenUtil().setHeight(12)),
            getRowTextView("最新资讯"),//往期会议标题栏
            cYM(ScreenUtil().setHeight(12)),
            getNewsListView()

          ],

        ),
      )
    ),
    );
  }


  Widget getBannerView(List<HomeIndexInfoBannerList> data) {


  //  print("getBannerView:"+data.length.toString());

    if(data==null){

      return Container();
    }

    return BannerSwiper(
      //width  和 height 是图片的高宽比  不用传具体的高宽   必传
      height: 1080,
      width: 518,
      //轮播图数目 必传
      length: data.length??1,
      //轮播的item  widget 必传
      getwidget: (index) {
        return new GestureDetector(
            child:  Image.network(
              data[index % data.length].img,
              fit: BoxFit.fill,
            ),

            onTap: () {
              switch(data[index % data.length].advType){
                case 1:  //会议直播
               //   RRouter.push(context ,Routes.liveDetailsPage,{"broadcastId": data[index % data.length].art_id},transition:TransitionType.cupertino);
                  break;
                case 0:  //视频会议
               //   RRouter.push(context, Routes.videoDetailsPage,{"reviewId": data[index % data.length].art_id});
                  break;
              }


            });
      },
    );
  }


  Widget   getMarqueeView(List<HomeDatamedicalNews> data){


    if(data==null){
      return Container();
    }else{
      return  new Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(75),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
              cXM(ScreenUtil().setWidth(26)),
             Image.asset(wrapAssets("home/icon_iv1.png"),width: ScreenUtil().setWidth(43),height:  ScreenUtil().setWidth(43),),
              cXM(ScreenUtil().setWidth(27)),
             Container(
               width: ScreenUtil().setWidth(452),
             child: Text("2019年国际皮肤性病学论...",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
             ),
              cXM(ScreenUtil().setWidth(40)),
            Text("2019-11-23 08:30:00",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
              cXM(ScreenUtil().setWidth(33)),
            Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(107),
              height: ScreenUtil().setHeight(50),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(14))),
                border: Border.all(color: Color(0xFFFB7D39))
              ),
              child: Text("预约",style: TextStyle(color: Color(0xFFFB7D39),fontSize: ScreenUtil().setSp(32)),textAlign: TextAlign.center,),


            )
            
          ],
        ),


      );
    }

  }



  Widget getGridBtnView(){
    return Container(
        height: ScreenUtil().setHeight(260),
        width: double.infinity,
        child: Row(
          children: <Widget>[
            cXM(ScreenUtil().setWidth(27)),
            Expanded(
                child: InkWell(
                  onTap: (){
                      RRouter.push(context ,Routes.doctorVideoListPage,{});
                  },
                  child: Image.asset(wrapAssets("home/bg_doctor_video.png"),width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                )
            ),
            cXM(ScreenUtil().setWidth(17)),

            Expanded(
                child: InkWell(
                  onTap: (){
                   RRouter.push(context ,Routes.taskNewPage,{});
                  },
                  child: Image.asset(wrapAssets("home/bg_integral.png"),width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                )
            ),
            cXM(ScreenUtil().setWidth(27)),
          ],

        ),


    );
  }


  Widget getRowTextView(String type){


    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(55),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(27), 0, ScreenUtil().setWidth(27), 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(type,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w800),),
        new GestureDetector(
          child: Container(
            child: Row(
              children: <Widget>[
                Text(type=="最新资讯"?"更多资讯":type=="热门视频"?"更多视频":"更多专家",style: TextStyle(color:Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
                cXM(ScreenUtil().setWidth(4)),
                Icon(Icons.arrow_forward_ios,color: Colors.black12,size: ScreenUtil().setWidth(35),),
              ],

            ),
          ),
          onTap: (){
            type=="热门视频"?RRouter.push(context, Routes.liveMeeting,{"title":"11"}):
            RRouter.push(context, Routes.videoListPage,{});
          },

        ),

        ],
        
        
      ),

    );

  }

  Widget getHotVideo(List<HomeIndexInfoHotVideo>  list){

    return list==null?Container(): GridView.count(
      controller: _scrollController,
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(10),
      //GridView内边距
      padding: EdgeInsets.all(ScreenUtil().setWidth(29)),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: list.getRange(0,list.length).map((item) => itemVideoView(item)).toList(),
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


  Widget getDocView(HomeIndexInfoRecomDoctor bean){
    return InkWell(

      onTap: (){
       // RRouter.push(context, Routes.doctorHomePage,{"userId":bean.userId});
      },
      child: new Container(
            child: Row(
              children: <Widget>[
                wrapImageUrl(bean.recomImage, ScreenUtil().setWidth(220), ScreenUtil().setHeight(245)),
                cXM(ScreenUtil().setWidth(29)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    Text(bean.realName??"",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w500),),
                    Text(bean.departs==null?"":bean.departs.name,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35)),),
                    Text(bean.job==null?"":bean.job.name,style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),)


                  ],

                )


              ],
            ),


      ),
    );
    
  }



  ///
  ///  热门视频 item
  ///
  Widget itemVideoView(HomeIndexInfoHotVideo bean) {



    return  InkWell(
      onTap: (){
     //   RRouter.push(context, Routes.livePaybackPage, {});
        RRouter.push(context, Routes.doctorVideoInfoPage,{"id": bean.id.toString()});
      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            wrapImageUrl(bean.image, ScreenUtil().setWidth(501), ScreenUtil().setHeight(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(bean.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(bean.createTime,style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  Text(bean.pv.toString()+"次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                ],
              ),
            )

          ],
        ),

      ),
    );


  }


  ///
  ///  特约专家布局
  ///
 Widget getDocViews(List<HomeIndexInfoRecomDoctor> list) {

   return list==null?Container(): GridView.builder(
       controller: _scrollController,
       itemCount: list.length,
       shrinkWrap: true ,
       padding: EdgeInsets.all(ScreenUtil().setWidth(27)),
       physics: new NeverScrollableScrollPhysics(),

       //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
         //横轴元素个数
           crossAxisCount: 2,
           //纵轴间距
           mainAxisSpacing: ScreenUtil().setHeight(42),
           //横轴间距
           crossAxisSpacing: ScreenUtil().setHeight(25),
           //子组件宽高长度比例
           childAspectRatio: 2),
       itemBuilder: (BuildContext context, int index) {
         //Widget Function(BuildContext context, int index)
         return getDocView(list[index]);
       });


  }




 Widget getNewsListView() {

    return  ListView.builder(
        controller: _scrollController,
        shrinkWrap: true ,
        physics: new NeverScrollableScrollPhysics(),
        itemCount:_homeIndexInfo.newsList.length,
        itemBuilder: (context,index) {

          return  getNewsItemView(context,_homeIndexInfo.newsList[index]);

        }

    );

  }

  ///
  ///  资讯布局
  ///
  Widget getNewsItemView(BuildContext context,HomeIndexInfoNewsList xlist) {
    return GestureDetector(

      onTap: (){
        RRouter.push(context, Routes.newsContentPage, {"id":xlist.id});
      },
      child: new Container(

        color: Colors.white,

        height: setH(200),

        child: new Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: <Widget>[


            Row(

              children: <Widget>[

                Expanded(child:   Column(

                  children: <Widget>[

                    new   Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(xlist.title,style: TextStyle(color: Color(0xFF333333),fontSize: setSP(42),fontWeight: FontWeight.w500),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    ),

                    cYM(setH(20)),

                    new  Container(

                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                      child:  new  Row(


                        children: <Widget>[

                          getContentText(xlist.createTime??""),

                          xlist.createTime==null?Container():cXM(setW(100)),

                          getContentText(xlist.pv.toString()+"次阅读"),

                        ],

                      ),
                    ),

                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                ),

                xlist.image==null?Container():wrapImageUrl(xlist.image, setW(200), setH(120))

              ],
            ),
            Divider(height: 1,color: Colors.black26,)



          ],


        ),

      ),
    );

  }

}


