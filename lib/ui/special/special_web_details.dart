import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/common/constant.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

import 'bean/special_video_entity.dart';


class SpecialWebDetailsPage extends StatefulWidget {


  final String id;
  SpecialWebDetailsPage(this.id);


  @override
  _VideoDetailsState createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<SpecialWebDetailsPage>  with SingleTickerProviderStateMixin{


  //页面加载状态，默认为加载中
  LoadState _layoutState;

  SpecialVideoEntity _specialVideoEntity;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _layoutState = LoadState.State_Loading;
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

      });
    });


  }




  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

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
     WebviewPage(_specialVideoEntity)
    )

    );
  }


}



class WebPage extends StatefulWidget {


  SpecialVideoEntity  bean;

  WebPage(this.bean);

  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> with AutomaticKeepAliveClientMixin{



  @override
  Widget build(BuildContext context) {
    return  new WebView(
      initialUrl: widget.bean.content.startsWith("http")?widget.bean.content:new Uri.dataFromString(widget.bean.content, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  String getHtmlData(String bodyHTML) {
    String subTitle = "<h3 align=\"center\" >" + widget.bean.title + "<\/h3><br/>";
    String content = subTitle + bodyHTML;
    String head = "\<meta name=\"viewport\" content=\"width=100%; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\" /><head><style>* {font-size:15px}{color:#212121;}img{display:block;width:100%;height:auto;}</style></head>";
    String resultStr = "<html>" + head + "<body>" +
        content + "<\/body></html>";
    return resultStr;
  }

}



class WebviewPage extends StatefulWidget {
  SpecialVideoEntity  bean;

  WebviewPage(this.bean);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage>  with SingleTickerProviderStateMixin {
  final _loadingContainer = Container(
    color: Colors.white,
    constraints: BoxConstraints.expand(),
    child: Center(
      child: Opacity(
        opacity: 0.9,
        child: SpinKitRing(
          color: AppColors.PrimaryColor,
          size: 50.0,
        ),
      ),
    ),
  );


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url:  widget.bean.content.startsWith("http")?widget.bean.content:new Uri.dataFromString(widget.bean.content, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
    appBar: AppBar(
        centerTitle: true,
        title: Text( widget.bean.title??"网页"),
      ),
      withZoom: true,
      withLocalStorage: true,
      useWideViewPort:false,
      hidden: true,
      localUrlScope:"javascript:(function(){" +
          "var objs = document.getElementsByTagName('img'); " +
          "for(var i=0;i<objs.length;i++)  " +
          "{"
          + "var img = objs[i];   " +
          "    img.style.maxWidth = '100%'; img.style.height = 'auto';  " +
          "}" +
          "})()",
      initialChild: _loadingContainer,
    );
  }

  String getHtmlData(String bodyHTML) {
    String subTitle = "<h3 align=\"center\" >" + widget.bean.title + "<\/h3><br/>";
    String content = subTitle + bodyHTML;
    String head = "\<meta name=\"viewport\" content=\"width=100%; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\" /><head><style>* {font-size:15px}{color:#212121;}img{display:block;width:100%;height:auto;}</style></head>";
    String resultStr = "<html>" + head + "<body>" +
        content + "<\/body></html>";
    return resultStr;
  }
}






