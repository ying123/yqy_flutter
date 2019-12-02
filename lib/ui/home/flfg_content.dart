import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/home/bean/laws_deails_entity.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

import 'bean/news_details_entity.dart';


class FLFGContentPage extends StatefulWidget {



  var id;
  var title;

  FLFGContentPage(this.id,this.title);



  @override
  _FLFGContentPageState createState() => _FLFGContentPageState();

}


class _FLFGContentPageState extends State<FLFGContentPage> with AutomaticKeepAliveClientMixin {

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;


  LawsDeailsInfo _detailsEntity;

  String htmlStr;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();

  }

   loadData() {

     NetworkUtils.requestLawsDetail(widget.id)
      .then((res){

       int statusCode = int.parse(res.status);

       if(statusCode==9999) {
         _detailsEntity = LawsDeailsInfo.fromJson(res.info);
         String subTitle = "<h1 style=\"margin:auto\">" + _detailsEntity.title + "<\/h1>";
         


         StringBuffer stringBuffer = new StringBuffer();
         
         for(var LawsDeailsInfoChapter in  _detailsEntity.chapter){

                var chapter = LawsDeailsInfoChapter.chapter;

                String t = "<h5>" + chapter + "<\/h5> <br\/>";

                stringBuffer.write(t);


                for(var c in LawsDeailsInfoChapter.regulations){
                  String p = "<p><span style=\"float:left;font-size:14px;color:#999999\">" +
                        c.content +
                      "<\/span></p> <br>";
                  stringBuffer.write(p);
                }

                stringBuffer.write("<br>");
                stringBuffer.write("<br>");
                stringBuffer.write("<br>");
         }

         String head = "\<meta name=\"viewport\" content=\"width=100%; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\" /><head><style>* {font-size:15px}{color:#212121;}img{display:block;width:100%;height:auto;}</style></head>";
         String resultStr = "<html>" + head + "<body>" +
             stringBuffer.toString() + "<\/body></html>";
         htmlStr = subTitle  + resultStr;

       }
       setState(() {
         _layoutState = loadStateByCode(statusCode);
       });

     });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(widget.title, style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,

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

          initialUrl: new Uri.dataFromString(htmlStr, mimeType: 'text/html', encoding: Encoding.getByName('utf-8')).toString(),

        ),

      ),

    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;




}


