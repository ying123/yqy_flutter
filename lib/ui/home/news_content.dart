import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:like_button/like_button.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_news_info_entity.dart';
import 'package:yqy_flutter/ui/video/video_details.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'bean/news_details_entity.dart';
import 'package:fluttertoast/fluttertoast.dart';


class NewsContentPage extends StatefulWidget {



  var id;

  NewsContentPage(this.id);



  @override
  _NewsContentPageState createState() => _NewsContentPageState();


}



class _NewsContentPageState extends State<NewsContentPage> with AutomaticKeepAliveClientMixin{


  TabNewsInfoInfo _detailsEntity;

  String htmlStr;

  bool isCollect;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();

  }

   loadData() {


    NetUtils.requestCollectCheckStatus(AppRequest.PAGE_ROUTE_DOCTOR_NEWS_INFO, widget.id)
    .then((res){

      if(res.code==200){

        setState(() {
          res.info["status"]==1?isCollect = true:isCollect = false;
        });

      }


    });


     NetUtils.requestNewsInfo(widget.id)
      .then((res){

       if(res.code==200) {
         _detailsEntity = TabNewsInfoInfo.fromJson(res.info);
         String subTitle = "<h3>" + _detailsEntity.title + "<\/h3>";
         String soure = "<p><span style=\"float:left;font-size:12px;color:#999999\">" +
             "来源:  " + _detailsEntity.source +
             "<\/span> <span style=\"float:right;font-size:12px;color:#999999\">" +
             _detailsEntity.createTime + "<\/span></p> <br/>";
         if (_detailsEntity.content.startsWith("http")) {
           htmlStr = _detailsEntity.content;
         } else {
           String head = "\<meta name=\"viewport\" content=\"width=100%; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\" /><head><style>* {font-size:15px}{color:#212121;}img{display:block;width:100%;height:auto;}</style></head>";
           String resultStr = "<html>" + head + "<body>" +
               _detailsEntity.content + "<\/body></html>";
           htmlStr = subTitle + soure + resultStr;
         }

         setState(() {
         });
       }
     });
  }

  @override
  Widget build(BuildContext context) {


    return  _detailsEntity==null?Container():WebviewScaffold(
      url: _detailsEntity.content.startsWith("http")?_detailsEntity.content:new Uri.dataFromString(getHtmlData(htmlStr), mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("医药新闻", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        actions: <Widget>[

          LikeButton(
            isLiked: isCollect,
            likeBuilder: (bool isLike){

              return  !isLike?Image.asset(wrapAssets("icon_collect_cancel.png")):
              Image.asset(wrapAssets("icon_collect.png"));
            },
            onTap: (bool isLiked)
            {
              return onLikeButtonTap(AppRequest.PAGE_ROUTE_DOCTOR_NEWS_INFO,isLiked,_detailsEntity.id.toString());
            },

          ),

          cXM(10),
       /*   new GestureDetector(

            child: Icon(Icons.share,color: Colors.black45,size: 26,),

            onTap: (){
              showToast("点击分享");
            },
          ),*/
          cXM(10),

        ],

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
 //   String subTitle = "\<h3 align=\"center\">" + widget.bean.title + "<\/h3><br/>";
  //  String content = subTitle + bodyHTML;
    String head = "\<meta name=\"viewport\" content=\"width=100%; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\" /><head><style>* {font-size:15px}{color:#212121;}img{display:block;width:100%;height:auto;}</style></head>";
    String resultStr = "<html>" + head + "<body>" +
        bodyHTML + "<\/body></html>";
    return resultStr;
  }



  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}


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

