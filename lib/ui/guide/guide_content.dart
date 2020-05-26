import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flui/flui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluwx/fluwx.dart';
import 'package:like_button/like_button.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_jk/pdf_viewer_jk.dart';
import 'package:permission_handler/permission_handler.dart';
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


class _GuideContentPageState extends State<GuideContentPage> with AutomaticKeepAliveClientMixin {


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

    NetUtils.requestCollectCheckStatus(AppRequest.PAGE_ROUTE_DOCTOR_GUIDE_INFO, widget.id)
        .then((res){

      if(res.code==200){

        setState(() {
          res.info["status"]==1?isCollect = true:isCollect = false;
        });

      }


    });

    NetUtils.requestDocumentInfo(widget.id)
        .then((res) async {
      if (res.code == 200) {
        _detailsEntity = GuideInfoInfo.fromJson(res.info);
        _type = _detailsEntity.filepath.toString().endsWith("pdf")?0:1;


        if (_type == 1) {
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
        } else {
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
    return Scaffold(
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

              return  !isLike?Image.asset(wrapAssets("icon_collect_cancel.png"),width: setW(60),height: setW(60)):
              Image.asset(wrapAssets("icon_collect.png"),width: setW(60),height: setW(60));
            },
            onTap: (bool isLiked)
            {
              return onLikeButtonTap(AppRequest.PAGE_ROUTE_DOCTOR_GUIDE_INFO,isLiked,_detailsEntity.id.toString());
            },

          ),
          cXM(10),

          Visibility(
            visible:  _type==0?true:false ,
            child:     new GestureDetector(

            child: Image.asset(wrapAssets("guide_download.png"),width: setW(80),height: setW(80),),

            onTap: () {

            //  showShareView(context);
              if(Platform.isAndroid){

                requestPermission();// 下载pdf文件

              }else{

                FLToast.info(text: "目前仅支持安卓设备下载文件到本地");

              }

            },
          ),),

          cXM(10),

        ],
      ),
      body:_detailsEntity == null ? Container() :  _type == 1 ? Container(
          padding: EdgeInsets.all(setW(20)),
          child: ListView(
            children: <Widget>[
              Html(
                data: getHtmlData(htmlStr),
              ),
            ],
          )

      ) : Container(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : MyPDFViewer(
          document: document,
        ),

      ),

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

  void showShareView(BuildContext context) {
    showFLBottomSheet(context: context, builder: (BuildContext context){
      return  new  FLCupertinoOperationSheet(
        backgroundColor: Colors.white,
        sheetStyle: FLCupertinoActionSheetStyle.filled,
        cancelButton: CupertinoActionSheetAction(
          child: const Text('取消'),
          isDefaultAction: true,
          onPressed: () {
            Navigator.pop(context, '取消');
          },
        ),
        header: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Text('分享', style: TextStyle(color: Colors.blueGrey, fontSize: 18)),
        ),
        itemList: [
          [
            FLCupertinoOperationSheetItem(
              imagePath: wrapAssets("wx_logo.png"),
              title: '微信',
              onPressed: () {
              //  Navigator.pop(context, 'Google');
                _shareText("测试分享的文本", WeChatScene.SESSION);
              },
            ),
            FLCupertinoOperationSheetItem(
              imagePath: wrapAssets("wx_pyq.png"),
              title: '朋友圈',
              onPressed: () {
                Navigator.pop(context, 'Wechat');
                _shareText("测试分享的文本", WeChatScene.TIMELINE);
              },
            ),
            FLCupertinoOperationSheetItem(
              imagePath: wrapAssets("qq_logo.png"),
              title: 'QQ',
              onPressed: () {
                Navigator.pop(context, 'Google');
              },
            ),
            FLCupertinoOperationSheetItem(
              imagePath: wrapAssets("weibo_logo.png"),
              title: '微博',
              onPressed: () {
                Navigator.pop(context, 'Wechat');
              },
            ),
          ],

        ],
      );


    });

  }


  void _shareText(String _text,WeChatScene scene) {
    shareToWeChat(WeChatShareTextModel(_text,title: _text, scene: scene)).then((data) {
    });

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
  
  
  ///
  ///  下载pdf文件  到本地
  /// 
  Future<void> downloadPdfFile() async {


    if(_detailsEntity==null||!_detailsEntity.filepath.toString().endsWith("pdf")){
      FLToast.error(text: "文件不存在");
      return;
    }

    var loading = FLToast.loading(text: "下载中..");
     Dio dio = new Dio();

    //final filepath = await getExternalStorageDirectory(); 获取sd卡路径

    //print("filepath"+filepath.path);

    var file = Directory("/storage/emulated/0/"+"药企源");
    try {
      bool exists = await file.exists();
      if (!exists) {
        await file.create();
      }
    } catch (e) {
      print(e);
    }
     await dio.download(_detailsEntity.filepath,file.path+"/${_detailsEntity.title}.pdf").then((res){
       loading();
       FLToast.showSuccess(text: "下载完成 \r\n 保存路径为：文件管理/药企源/",showDuration: Duration(seconds: 3));

     });

  }


  ///
  ///
  ///
  Future requestPermission() async {

    // 申请权限

    Map<PermissionGroup, PermissionStatus> permissions =

    await PermissionHandler().requestPermissions([PermissionGroup.storage]);

    // 申请结果

    PermissionStatus permission =

    await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);

    if (permission == PermissionStatus.granted) {

      //  Fluttertoast.showToast(msg: "权限申请通过");
      downloadPdfFile();
    } else {

      FLToast.error(text: "权限被拒绝，不能使用当前功能");

      //  Fluttertoast.showToast(msg: "权限申请被拒绝");

    }

  }

}