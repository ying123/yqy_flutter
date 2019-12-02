import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:like_button/like_button.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/live/bean/live_details_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_details_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('会议介绍'), body: Text("")),
  _TabData(tab: Text('会议日程'), body: Text(""))
];




class LiveDetailsPage extends StatefulWidget {

   var id;
  LiveDetailsPage(this.id);


  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<LiveDetailsPage>  with SingleTickerProviderStateMixin{

  final FijkPlayer player = FijkPlayer();

  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  List<Widget> tabBarViewList = _tabDataList.map((item) => item.body).toList();

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  TabController _tabController;

  String url1,url2;

  LiveDetailsInfo  _liveDetailsInfo;
  bool isCollect;

  StreamSubscription changeSubscription;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabBarList.length);
    loadData();
    FlutterUmplus.beginPageView(runtimeType.toString());
    changeSubscription =  eventBus.on<EventBusChange>().listen((event) {
      setState(() {
        player.reset().then((_){
          player.setDataSource(event.url, autoPlay: true);
        });

      });
    });
  }

  @override
  void dispose() {
    FlutterUmplus.endPageView(runtimeType.toString());
    super.dispose();
    _tabController.dispose();
    player.release();
    changeSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        brightness: Brightness.light,
        titleSpacing: 0,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("会议直播", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        actions: <Widget>[

          LikeButton(
            isLiked: isCollect,
            likeBuilder: (bool isLike){

              return  !isLike?Icon(Icons.star_border,color:Colors.black45,size: 30,):
              Icon(Icons.star,color:Colors.amber,size: 30,);
            },
            onTap: (bool isLiked)
            {
              return onLikeButtonTap(isLiked,widget.id);
            },

          ),
          cXM(10),
         new GestureDetector(
            
            child: Icon(Icons.share,color: Colors.black45,size: 26,),
            onTap: (){
              if(_liveDetailsInfo!=null){
                Share.share(_liveDetailsInfo.title+"\r\n"+"直播观看地址：\r\n"+APPConfig.SHARE_LIVE_START+_liveDetailsInfo.id+APPConfig.SHARE_LIVE_END);
              }
            },
          ),
         cXM(10),
        ],
        
      ),

      body:
      LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        this.loadData();
      },
     successWidget:_liveDetailsInfo==null?Container():new Column(
       children: <Widget>[
         Container(
           color: Colors.black,
           height: 220,
           width: double.infinity,
           /// 如果 isPlay = 1 正在直播状态   其他状态显示封面图和文字
           child: _liveDetailsInfo.isPlay==1||_liveDetailsInfo.isPlay=="1"?FijkView(
             color: Colors.black,
             width: double.infinity,
             height: double.infinity,
             player: player,
           ): getOtherStatusView(_liveDetailsInfo.isPlay,_liveDetailsInfo.image)
         ),


         Visibility(

            visible: _liveDetailsInfo==null?false:_liveDetailsInfo.liveList.length>1&&_liveDetailsInfo.isPlay!=0?true:false,
             child: buildMultiVenueView(context,_liveDetailsInfo),

         ),


         Container(
           height: 45,
           color: Colors.white,
           child:  TabBar(
             controller: _tabController,
             tabs: tabBarList,
             indicatorColor: Colors.blueAccent, //指示器颜色 如果和标题栏颜色一样会白色
             labelColor: Colors.blueAccent ,
             unselectedLabelColor: Colors.black,
             indicatorSize: TabBarIndicatorSize.label,
             unselectedLabelStyle: TextStyle(fontSize: 16),
             labelStyle: TextStyle(fontSize: 16),
             indicatorPadding: EdgeInsets.only(top: 5),
           ),

         ),
         Expanded(
             child: TabBarView(
               controller: _tabController,
               children: tabBarViewList,
             )
         )

       ],

     ),

    )


    );
  }

  void loadData() async{

    NetworkUtils.requestLiveDetails(widget.id)
        .then((res) {
      int statusCode = int.parse(res.status);

      if(statusCode==9999){

        _liveDetailsInfo = LiveDetailsInfo.fromJson(res.info);
      }
      setState(() {
        isCollect = _liveDetailsInfo.ifCollect=="0"?false:true;
        tabBarViewList = [WebPage(_liveDetailsInfo.introduces),WebPage(_liveDetailsInfo.contents)];
        player.setDataSource(_liveDetailsInfo.broadcast.info.channelUrl.urlRtmp, autoPlay: true);
        _layoutState = loadStateByCode(statusCode);
      });
    });

  }




}




Future<bool> onLikeButtonTap(bool isLike,var  id) {

  final Completer<bool> completer = new Completer<bool>();

  if(!isLike){

    NetworkUtils.requestCollectAdd(AppRequest.Collect_live_broadcast,id)
        .then((res){
      int statusCode = int.parse(res.status);
      completer.complete(statusCode==9999?true:false);
      showToast(res.message);
    });
  }else{

    NetworkUtils.requestCollectDel(AppRequest.Collect_live_broadcast,id)
        .then((res){
      int statusCode = int.parse(res.status);
      completer.complete(statusCode==9999?false:true);
      showToast(res.message);
    });
  }
  return completer.future;
}

Widget  getOtherStatusView(isPlay,imgUrl) {

  String value;


  if(isPlay==0||isPlay=="0"){
    value = "已结束";
  }else if(isPlay==2||isPlay=="2"){
    value = "未开始";
  }



  return Container(
    height: 220,
    child: Stack(

      alignment: Alignment.center,
      children: <Widget>[

        Image.network(imgUrl,fit: BoxFit.fill,width: double.infinity,height: double.infinity,),

        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black54,
        ),

        Container(
          width: 90,
          height: 40,
          child: Card(
            color: Colors.blueAccent,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))), //设置圆角
            child: Center(

              child: Text(value??"未开始",style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),

            )
          ),

        )


      ],
    ),
  );


}



///
///   多会场切换的布局
///
Widget  buildMultiVenueView(BuildContext context,LiveDetailsInfo detailsInfo) {

  return Container(
    height: ScreenUtil().setHeight(260),
    width: double.infinity,
    color: Colors.white,
    child: Row(

      children: <Widget>[

        Container(
          width: ScreenUtil().setWidth(100),
          height: double.infinity,
          child: Text("会场列表",style: TextStyle(color: Colors.white),),
          color: Colors.black38,
          alignment: Alignment.center,
        ),

       cXM(ScreenUtil().setWidth(35)),

       Expanded(
           child:  ListView.builder(
             //   //设置横向排列，不设置就是默认的垂直排列
               itemCount: detailsInfo.liveList.length,
               scrollDirection: Axis.horizontal,
               itemBuilder: (c,index){
                 return itemMultiVenueView(detailsInfo.liveList[index]);
               })
       )


      ],

    ),





  );


}



Widget itemMultiVenueView(LiveDetailsInfoLiveList bean) {


  return InkWell(
    onTap: (){

      String is_play = bean.isPlay;
      switch (is_play) {
        case "1":
          if(bean.play_url==null){
            showToast("直播地址不存在");
          }else{
            eventBus.fire(new EventBusChange(bean.play_url.url_rtmp));
          }
          break;
        case "2":
          showToast("当前会场直播还未开始");
          break;
        case "0":
          showToast("当前会场直播已经结束");
          break;
      }


    },
    child: Container(
      margin: EdgeInsets.fromLTRB(0, 5, ScreenUtil().setWidth(40), 5),
      height: double.infinity,
      width: ScreenUtil().setWidth(400),
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[

          Container(
            child: wrapImageUrl(bean.image,double.infinity,double.infinity),
          ),

          Positioned(
              bottom: 0,
              child:  Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(400),
                height: ScreenUtil().setHeight(100),
                child: Text(bean.title,style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(36)),textAlign: TextAlign.center,),
                color: Colors.black38,
              )
          ),
          Container(
            color: bean.isPlay=="1"?Colors.red:Colors.blue,
            alignment: Alignment.center,
            width: ScreenUtil().setWidth(150),
            height: ScreenUtil().setHeight(50),
            child: Text(buildMultiVenueTip(bean.isPlay),style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Colors.white),),
          ),


        ],

      ),


    ),
  );

}

String buildMultiVenueTip(var isPlay) {

  String value;

  if(isPlay==0||isPlay=="0"){
    value = "已结束";
  }else if(isPlay==1||isPlay=="1"){
    value = "直播中";
  }else if(isPlay==2||isPlay=="2"){
    value = "未开始";
  }

  return value;


}




class WebPage extends StatefulWidget {

  String  url;

  WebPage(this.url);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> with AutomaticKeepAliveClientMixin{



  @override
  Widget build(BuildContext context) {
    
    
    return ListView(

      children: <Widget>[

           Html(data: getHtmlData(widget.url)),

      ],
    );


  /*  return  new WebView(
      initialUrl: widget.url.startsWith("http")?widget.url:new Uri.dataFromString(getHtmlData(widget.url), mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
    );*/
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
    


  String getHtmlData(String content) {
    String head = "\<meta name=\"viewport\" content=\"width=100%; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\" /><head><style>* {font-size:15px}{color:#212121;}img{display:block;width:100%;height:auto;}</style></head>";
    String resultStr = "<html>" + head + "<body>" +
        content + "<\/body></html>";
    return resultStr;
  }



}



