import 'package:cached_network_image/cached_network_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:oktoast/oktoast.dart';
import  'package:yqy_flutter/utils/margin.dart';

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

  final String id;
  VideoDetailsPage({@required this.id});


  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetailsPage>  with SingleTickerProviderStateMixin{

  final FijkPlayer player = FijkPlayer();

  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  List<Widget> tabBarViewList = _tabDataList.map((item) => item.body).toList();


  TabController _tabController;

  String url1,url2;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabBarList.length);
    player.setDataSource("http://cdn1.yaoqiyuan.com/sv/337fc4e8-16cd5f49844/337fc4e8-16cd5f49844.mp4", autoPlay: true);
    loadData();

  }

  @override
  void dispose() {
    player.release();
    _tabController.dispose();
    super.dispose();
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
        title: Text("视频回顾", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        actions: <Widget>[

          new GestureDetector(
            child: Icon(Icons.star_border,color: Colors.black45,size: 30,),
            onTap: (){
              showToast("点击收藏");
            },
          ),
          cXM(10),
         new GestureDetector(
            
            child: Icon(Icons.share,color: Colors.black45,size: 26,),
            
            onTap: (){
              showToast("点击分享");
            },
          ),
         cXM(10),

          
        ],
        
      ),


      body: new Column(

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


    );
  }

  void loadData() async{


    await Future.delayed(Duration(milliseconds: 1000));

    url1 = "https://www.baidu.com/";
    setState(() {
      tabBarViewList = [WebPage(url1),WebPage(url1)];
    });

  }
}



class WebPage extends StatefulWidget {


  String url;

  WebPage(this.url);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> with AutomaticKeepAliveClientMixin{



  @override
  Widget build(BuildContext context) {
    return  new WebView(
      initialUrl: widget.url,
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}




