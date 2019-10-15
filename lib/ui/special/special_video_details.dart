import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:oktoast/oktoast.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

import 'bean/special_video_entity.dart';
class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('专题介绍'), body: Text("")),
];




class SpecialVideoDetailsPage extends StatefulWidget {


  final String id;
  SpecialVideoDetailsPage(this.id);


  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<SpecialVideoDetailsPage>  with SingleTickerProviderStateMixin{


  //页面加载状态，默认为加载中
  LoadState _layoutState;

  final FijkPlayer player = FijkPlayer();

  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  List<Widget> tabBarViewList = _tabDataList.map((item) => item.body).toList();


  TabController _tabController;


  SpecialVideoEntity _specialVideoEntity;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _layoutState = LoadState.State_Loading;
    _tabController = TabController(vsync: this, length: tabBarList.length??1);
    loadData();

  }


  void loadData() async{


    //await Future.delayed(Duration(milliseconds: 1000));


    NetworkUtils.requestSpecialArticle(widget.id)
        .then((res){

      setState(() {
        _specialVideoEntity = SpecialVideoEntity.fromJson(res.info);
        int statusCode = res.status;
        _layoutState = loadStateByCode(statusCode);
        if(res.status==9999){
          tabBarViewList = [WebPage(_specialVideoEntity.content)];
          player.setDataSource(_specialVideoEntity.playUrl, autoPlay: true);
        }

      });
    });


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
        title: Text(_specialVideoEntity==null?"":_specialVideoEntity.title, style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
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
    successWidget:
      new Column(

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
    )

    );
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
      initialUrl: widget.url.startsWith("http")?widget.url:new Uri.dataFromString(widget.url, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


 String getHtmlData(String bodyHTML) {
   String head = "\<meta name=\"viewport\" content=\"width=100%; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\" /><head><style>* {font-size:15px}{color:#212121;}img{display:block;width:100%;height:auto;}</style></head>";
   String resultStr = "<html>" + head + "<body>" +
       bodyHTML + "<\/body></html>";
   return resultStr;
}


