import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
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
  _TabData(tab: Center(child: Text("会议直播"),), body: LiveMeetingPage()),
  _TabData(tab:  Center(child: Text("互动直播")), body: LiveInteractionPage()),
];


class LiveHomePage extends StatefulWidget {
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
          title: Text("直播",style: TextStyle(color: Colors.black),),
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
          _refreshController.loadNoData();
          _liveListEntity.xList.addAll(LiveListInfo.fromJson(res.info).xList);
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

            return getLiveItemView(_liveListEntity.xList[index]	);
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
///   互动直播页面
///
class LiveInteractionPage  extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: 5,
        itemBuilder: (context,index){

          return getLiveItemView2(2);
        }
    );
  }
}


///
///   直播列表item
///
Widget getLiveItemView(	LiveListInfoList  bean){

  return  GestureDetector(
    child: new Container(
      height: 100,
      color: Colors.white,
      child: Row(

        children: <Widget>[

            cXM(5),
          Image.network(bean.image,fit: BoxFit.fill,height: 90,width: setW(310),),

          cXM(8),
          new Container(
              width: setW(700),
              decoration: new BoxDecoration(
                  border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
              ),
              child: Column(
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

                      Text("看录播",style: TextStyle(color: Colors.greenAccent),)

                    ],
                  ),


                ],

              )





          )


        ],


      ),

    ),
    onTap: (){
        showToast("点击会议直播");

    },

  );

}


///
///   互动直播列表item
///
Widget getLiveItemView2(int type){

  return  GestureDetector(
    child: new Container(
      height: 100,
      color: Colors.white,
      child: Row(

        children: <Widget>[

          Icon(Icons.apps,size: 110,color: Colors.blueAccent,),
          cXM(8),
          new Container(
              width: 265,
              decoration: new BoxDecoration(
                  border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[

                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Text("山东省肛肠专业科室管理交流暨2019年济南医学会钢厂专业委员会学术会议",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),

                  ),
                  cYM(10),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new  Row(
                        children: <Widget>[
                          Icon(Icons.access_time,size: 16,color: Colors.black45,),
                          cXM(5),
                          Text("2019-07-20 08:30",style: TextStyle(color: Colors.black45,fontSize: 14),),

                        ],

                      ),

                      Text("看录播",style: TextStyle(color: Colors.greenAccent),)

                    ],
                  ),


                ],

              )





          )


        ],


      ),

    ),
    onTap: (){

      if(type==1){
        showToast("点击会议直播");
      }else{
        showToast("点击互动直播");
      }

    },

  );

}