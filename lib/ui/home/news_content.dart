import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

import 'bean/news_details_entity.dart';


class NewsContentPage extends StatefulWidget {



  var id;
  var title;

  NewsContentPage(this.id,this.title);



  @override
  _NewsContentPageState createState() => _NewsContentPageState();


}



class _NewsContentPageState extends State<NewsContentPage> {

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;


  NewsDetailsEntity _detailsEntity;

  String htmlStr;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();

  }

   loadData() {

     NetworkUtils.requestNewsDetail(widget.id)
      .then((res){

       int statusCode = int.parse(res.status);

       if(statusCode==9999) {
         _detailsEntity = NewsDetailsEntity.fromJson(res.info);
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

       print("html11111111111111========================="+htmlStr);



     });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      
      appBar: AppBar(
        title: Text("医药新闻"),
        centerTitle: true,
        
      ),
      
      
      body:  LoadStateLayout(

        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          this.loadData();
        },

        successWidget:
        _detailsEntity==null?Container():

        WebView(

          initialUrl:_detailsEntity.content.startsWith("http")? htmlStr:new Uri.dataFromString(htmlStr, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),

        ),

      ),
      
    );
  }
}


