import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:like_button/like_button.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/video/video_details.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

import 'bean/news_details_entity.dart';


class ZxContentPage extends StatefulWidget {



  var id;

  ZxContentPage(this.id);



  @override
  _ZxContentPageState createState() => _ZxContentPageState();


}



class _ZxContentPageState extends State<ZxContentPage> with AutomaticKeepAliveClientMixin {

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;


  NewsDetailsEntity _detailsEntity;

  String htmlStr;

  bool isCollect;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();

  }

   loadData() {

     NetworkUtils.requestPolicyDetail(widget.id)
      .then((res){

       int statusCode = int.parse(res.status);

       if(statusCode==9999) {
         _detailsEntity = NewsDetailsEntity.fromJson(res.info);
         isCollect = _detailsEntity.ifCollect=="0"?false:true;
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
           _layoutState = loadStateByCode(statusCode);
         });
       }


     });
  }

  @override
  Widget build(BuildContext context) {


    return  _detailsEntity==null?Container():WebviewScaffold(
      url: _detailsEntity.content.startsWith("http")?_detailsEntity.content:new Uri.dataFromString(getHtmlData(_detailsEntity.content), mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("政策资讯", style: TextStyle(color: Colors.black),),
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
              return onLikeButtonTap(AppRequest.Collect_ZX,isLiked,_detailsEntity.id.toString());
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



