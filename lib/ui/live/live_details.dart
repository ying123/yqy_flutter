import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:like_button/like_button.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/live/bean/live_details_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_details_entity.dart';
import 'package:yqy_flutter/utils/event_bus_util.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';


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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabBarList.length);
    loadData();
    EventBusUtil.getDefault().register((String i) { //注册
        setState(() {
          player.reset().then((_){
            player.setDataSource(i, autoPlay: true);
          });

        });
    });
  }


  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    EventBusUtil.getDefault().unregister();  //销毁
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    player.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
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
        tabBarViewList = [WebPage(_liveDetailsInfo.introduce),WebPage(_liveDetailsInfo.content)];
        player.setDataSource(_liveDetailsInfo.broadcast.info.channelUrl.urlRtmp, autoPlay: true);
        _layoutState = loadStateByCode(statusCode);
      });
    });

  }


}




Future<bool> onLikeButtonTap(bool isLike,var  id) {

  final Completer<bool> completer = new Completer<bool>();

  if(!isLike){

    NetworkUtils.requestCollectAdd(AppRequest.Comment_video_meeting,id)
        .then((res){
      int statusCode = int.parse(res.status);
      completer.complete(statusCode==9999?true:false);
      showToast(res.message);
    });
  }else{

    NetworkUtils.requestCollectDel(AppRequest.Comment_video_meeting,id)
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
///  回放视频节点列表
///
class getNodeList extends StatefulWidget {

  List<VideoDetailsInfoPlayList> playList;


  getNodeList(this.playList);

  @override
  _getNodeListState createState() => _getNodeListState();
}

class _getNodeListState extends State<getNodeList> {
  @override
  Widget build(BuildContext context) {
    return  new ListView.builder(
        itemCount: widget.playList.length,
        itemBuilder: (content,index){
          return InkWell(
            onTap: (){
              EventBusUtil.getDefault().post(widget.playList[index].url);//发送EnentBus消息
            },
            child: Container(
              padding: EdgeInsets.all(10),
              height: 110,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Image.network(widget.playList[index].image,width: 130,height: 90,fit: BoxFit.fill,),
                  Expanded(child: Container(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Text(widget.playList[index].title,textAlign:TextAlign.center,),
                        Text(widget.playList[index].author),
                        Divider(height: 1,color: Colors.black12,)

                      ],

                    ),

                  ))

                ],

              ),
            ),

          );
        }
    );
  }
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
    return  new WebView(
      initialUrl: widget.url.startsWith("http")?widget.url:new Uri.dataFromString(widget.url, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
    );
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



