import 'dart:async';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_bus/event_bus.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:like_button/like_button.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

import 'bean/video_details_entity.dart';

class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('会议介绍'), body: Text("")),
  _TabData(tab: Text('会议日程'), body: Text(""))
];






class VideoDetailsPage extends StatefulWidget {

   var id;
  VideoDetailsPage({@required this.id});


  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetailsPage>  with SingleTickerProviderStateMixin{

  final FijkPlayer player = FijkPlayer();

  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  List<Widget> tabBarViewList = _tabDataList.map((item) => item.body).toList();

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  TabController _tabController;

  String url1,url2;

  VideoDetailsInfo  _videoDetailsEntity;

  bool isCollect;

  StreamSubscription changeSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterUmplus.beginPageView(runtimeType.toString());
    _tabController = TabController(vsync: this, length: tabBarList.length);
    loadData();
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
        title: Text("视频回顾", style: TextStyle(color: Colors.black),),
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
                return onLikeButtonTap(AppRequest.Comment_video_meeting,isLiked,widget.id);
              },

            ),
          cXM(10),
         new GestureDetector(
            
            child: Icon(Icons.share,color: Colors.black45,size: 26,),
            onTap: (){
              if(_videoDetailsEntity!=null){
                Share.share(_videoDetailsEntity.title+"\r\n"+"观看地址：\r\n"+APPConfig.Share_meeting_video+_videoDetailsEntity.id);
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

     successWidget:_videoDetailsEntity==null?Container():new Column(

       children: <Widget>[

         Container(
           color: Colors.black,
           height: 220,
           width: double.infinity,
           child:FijkView(
             color: Colors.black,
             width: double.infinity,
             height: double.infinity,
             player: player,
           ),
         /*  child: new Chewie(
             controller: chewieController,
           ),*/
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

    NetworkUtils.requestReviewVideo(widget.id)
        .then((res) {
      int statusCode = int.parse(res.status);

      if(statusCode==9999){
        _videoDetailsEntity = VideoDetailsInfo.fromJson(res.info);
        setState(() {
          isCollect = _videoDetailsEntity.ifCollect=="0"?false:true;
          tabBarViewList = [WebPage(_videoDetailsEntity.introduces),getNodeList(_videoDetailsEntity.playList)];
          player.setDataSource(_videoDetailsEntity.playUrl, autoPlay: true);
          _layoutState = loadStateByCode(statusCode);
        });
      }

    });

  }



  }

  Future<bool> onLikeButtonTap(String type ,bool isLike,var  id) {

    final Completer<bool> completer = new Completer<bool>();

    if(!isLike){

      NetworkUtils.requestCollectAdd(type,id)
          .then((res){
        int statusCode = int.parse(res.status);
        completer.complete(statusCode==9999?true:false);
        Fluttertoast.showToast(msg: res.message,gravity: ToastGravity.CENTER);
      });
    }else{

      NetworkUtils.requestCollectDel(type,id)
          .then((res){
        int statusCode = int.parse(res.status);
        completer.complete(statusCode==9999?false:true);
        Fluttertoast.showToast(msg: res.message,gravity: ToastGravity.CENTER);
      });
     }
    return completer.future;
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
          //    EventBusUtil.getDefault().post(widget.playList[index].url);//发送EnentBus消息
              eventBus.fire(new EventBusChange(widget.playList[index].url));
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


 final String  url;

  WebPage(this.url);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> with AutomaticKeepAliveClientMixin{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

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



