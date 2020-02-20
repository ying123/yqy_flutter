import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/bean/news_list_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_news_index_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/local_storage_utils.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabZxPage extends StatefulWidget {
  @override
  _TabZxPageState createState() => _TabZxPageState();
}

class _TabZxPageState extends State<TabZxPage> with AutomaticKeepAliveClientMixin{



  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  int page = 1;

  TabNewsIndexInfo  _newsIndexInfo ;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  StreamSubscription changeSubscription;

  String _seleID;  // 筛选新闻类型的ID

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    initEventBusListener();
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
    loadMoreData();
  }

  loadData () async{
    
    NetUtils.requestNewsIndex()
        .then((res){

       if(res.code==200){

         setState(() {
           _newsIndexInfo = TabNewsIndexInfo.fromJson(res.info);
           // 保存筛选数据到本地 用来提供给上级页面实现功能
            LocalStorage.putObject("TabNewsIndexInfoCateList", _newsIndexInfo.toJson());
           _refreshController.refreshCompleted();
           _refreshController.resetNoData();
           _layoutState = loadStateByCode(res.code);

           // 通知上级页面  重置数据 显示全部分类
           eventBus.fire(new EventBusChangeNew(null));
         });




       }

    });


  }
  loadMoreData () async{

    NetUtils.requestNewsLists(page: page.toString(),id:_seleID )
        .then((res){

      if(res.code==200){
        if (TabNewsIndexInfo
            .fromJson(res.info)
            .newsLists.length == 0) {
          _refreshController.loadNoData();
        } else {
          _newsIndexInfo.newsLists.addAll(TabNewsIndexInfo.fromJson(res.info).newsLists);
          _refreshController.loadComplete();
        }
        setState(() {

        });

      }

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
            shrinkWrap: true,
            itemCount:_newsIndexInfo==null?0:_newsIndexInfo.newsLists.length+1,
            itemBuilder: (context,index) {
              return index==0?bannerListView(context,_newsIndexInfo.adList): getLiveItemView(context,_newsIndexInfo.newsLists[index-1]);
            }
        ),

      ),

    ),


    );
  }



  Widget getLiveItemView(BuildContext context,TabNewsIndexInfoNewsList xlist) {
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

                           getContentText(xlist.createTime),

                           cXM(setW(100)),

                           getContentText(xlist.pv.toString()+"次阅读"),

                         ],


                       ),
                     ),

                   ],
                   crossAxisAlignment: CrossAxisAlignment.start,
                 ),
                 ),

                xlist.image.isEmpty?Container():wrapImageUrl(xlist.image, setW(200), setH(120))

              ],
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

 Widget buildBannerView(BuildContext context,List<TabNewsIndexInfoAdList> list) {

   return Container(
     child: new Swiper(
       itemBuilder: (BuildContext context, int index) {
         return new Image.network(
           list[index].img,
           fit: BoxFit.fill,
         );
       },
       itemCount: list.length,
       viewportFraction: 0.8,
       scale: 0.9,
     ),
   );

  }

  ///
  ///   轮播图布局
  ///
  bannerListView(BuildContext context, List<TabNewsIndexInfoAdList> adList) {

   return Container(
     height: setH(400),
     child: new Swiper(
       itemBuilder: (BuildContext context, int index) {
         return new Image.network(
           adList[index].img,
           fit: BoxFit.fill,
         );
       },
       itemCount: adList.length,
       viewportFraction: 0.8,
       scale: 0.9,
     ),


   );

  }

  void initEventBusListener() {

    changeSubscription =  eventBus.on<EventBusChangeNew>().listen((event) {

      if(event==null){
        _seleID = null;
      }else{
        _seleID = event.v;
      }


      _newsIndexInfo.newsLists.clear();
      loadMoreData();

    });

  }

}




