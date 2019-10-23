import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/bean/news_list_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:yqy_flutter/utils/margin.dart';


class TabFlfgPage extends StatefulWidget {
  @override
  _TabFlfgPageState createState() => _TabFlfgPageState();
}

class _TabFlfgPageState extends State<TabFlfgPage> with AutomaticKeepAliveClientMixin{



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
    
    NetworkUtils.requestLawsList(page)
        .then((res) {
      //   if (res.status == 200) {
      /*   print("res.toString():"+res.toString());
        print("res.info():"+res.info.toString());
        print("_videoListEntity.toString():"+_videoListEntity.toString());*/

      int statusCode = int.parse(res.status);

      if(statusCode==9999) {
        if (page > 1) {

          if (NewsListEntity
              .fromJson(res.info)
              .xList.length == 0) {
            _refreshController.loadNoData();
          } else {
            _newsListEntity.xList.addAll(NewsListEntity
                .fromJson(res.info)
                .xList);
            _refreshController.loadComplete();
          }


        } else {
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
        RRouter.push(context, Routes.flfgContentPage, {"id":xlist.lawsId,"title":xlist.title});
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




