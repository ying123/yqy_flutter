import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:like_button/like_button.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/ui/guide/bean/guide_info_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_news_info_entity.dart';
import 'package:yqy_flutter/ui/video/video_details.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yqy_flutter/widgets/pdf/MyPDFViewer.dart';


class GuideContentPage extends StatefulWidget {



  var id;

  GuideContentPage(this.id);


  @override
  _GuideContentPageState createState() => _GuideContentPageState();


}


class _GuideContentPageState extends State<GuideContentPage> with AutomaticKeepAliveClientMixin{


  GuideInfoInfo _detailsEntity;

  String htmlStr;

  bool isCollect;

  int _type; // 1 PDF  0 html

  ///
  ///   PDF相关
  ///
   PDFDocument document;
   bool _isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();

  }

   loadData() {

     NetUtils.requestDocumentInfo(widget.id)
      .then((res) async {

       if(res.code==200) {

         _detailsEntity = GuideInfoInfo.fromJson(res.info);
         _type = _detailsEntity.type;


           if(_type==0){

             String subTitle = "<h3>" + _detailsEntity.title + "<\/h3>";
             String soure = "<p><span style=\"float:left;font-size:12px;color:#999999\">" +
                 "来源:  " +
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

           }else{

             document = await PDFDocument.fromURL(
                 _detailsEntity.filepath);
             _isLoading = false;

           }

         setState(() {


         });
       }


     });
  }

  @override
  Widget build(BuildContext context) {


    return  _detailsEntity==null?Container():Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back, color: Colors.black,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text("文献指南", style: TextStyle(color: Colors.black),),
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
              return onLikeButtonTap(AppRequest.Collect_News,isLiked,_detailsEntity.id);
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
      body:_type==0? Container(
        padding: EdgeInsets.all(setW(20)),
        child: ListView(
          children: <Widget>[
            Html(
              data:getHtmlData(htmlStr) ,
            ),
          ],
        )

      ): Container(
        child: _isLoading?Center(child: CircularProgressIndicator()):MyPDFViewer(
          document: document,
        ),

      ),

    );
  }

  String getHtmlData(String bodyHTML) {
 //   String subTitle = "\<h3 align=\"center\">" + widget.bean.title + "<\/h3><br/>";
  //  String content = subTitle + bodyHTML;
    String head = "\<meta name=\"viewport\" content=\"width=100%; initial-scale=1.0; maximum-scale=1.0; user-scalable=0;\" /><head><style>* {font-size:15px}{color:#212121;}img{display:block;width:100%;height:auto;}</style></head>";
    String resultStr = "<html>" + head + "<body>"+
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

