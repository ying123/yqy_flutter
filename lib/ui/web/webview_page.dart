import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yqy_flutter/common/constant.dart' show AppColors;

///
///   webView 页面
///
class WebviewPage extends StatefulWidget {
  final String title;
  final String url;
  WebviewPage({@required this.title, @required this.url});

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
      url: widget.url??"",
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title??"网页"),

      ),
      withZoom: true,
      withLocalStorage: true,
       hidden: true,
      initialChild: _loadingContainer,
    );
  }
}
