import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yqy_flutter/common/constant.dart' show AppColors;
import 'package:yqy_flutter/net/net_utils.dart';

///
///   webView 页面
///
class CommonWebviewPage extends StatefulWidget {
  final String title;
  final String url;
  CommonWebviewPage({@required this.title, @required this.url});

  @override
  _CommonWebviewPageState createState() => _CommonWebviewPageState();
}

class _CommonWebviewPageState extends State<CommonWebviewPage>  with SingleTickerProviderStateMixin {
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

String  _html = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return   widget.url.startsWith("http")?WebviewScaffold(
      url: widget.url??"",
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title??"网页"),

      ),
      withZoom: true,
      withLocalStorage: true,
       hidden: true,
      initialChild: _loadingContainer,
    ): Scaffold(
      appBar: AppBar(

        title: Text(widget.title??"网页"),
      ),
      body: ListView(

        children: <Widget>[

        Html(
        data: _html,
        )
        ],
      ),

    );
  }

  void initData() {


    NetUtils.requestAgreements()
        .then((res){

       if(res.code==200){

         setState(() {

           _html =  res.info["content"];

         });

       }


    });


  }
}
