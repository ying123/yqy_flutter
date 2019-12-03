import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';


class ShopDetailsPage extends StatefulWidget {

  String  id;

  ShopDetailsPage(this.id);

  @override
  _ShopDetailsPageState createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {


  ShopHomeInfo _shopHomeInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    NetworkUtils.requestShopInfo(widget.id)
            .then((res){

            if(res.status==9999||res.status=="9999"){

              setState(() {
                _shopHomeInfo = ShopHomeInfo.fromJson(res.info);

              });

            }

      });

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("商品详情"),
      ),

      body:_shopHomeInfo==null?Container():ListView(

        children: <Widget>[

          buildImageView(context),
          buildText(context),
          cYM(ScreenUtil().setHeight(25)),
          buildContentTitleView(context),
          buildContentView(context)


        ],

      )



    );
  }


  buildImageView(BuildContext context) {

      return wrapImageUrl(_shopHomeInfo.image,double.infinity,ScreenUtil().setHeight(500));


  }

  buildText(BuildContext context) {

    return Container(

      color: Colors.white,

      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), 0, ScreenUtil().setWidth(40), 0),

      height: ScreenUtil().setHeight(120),
      
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[

          Expanded(child:  Text(_shopHomeInfo.title,maxLines: 1,overflow: TextOverflow.ellipsis,)),

          cXM(ScreenUtil().setWidth(20)),

          Text(_shopHomeInfo.points+" "+"积分",style: TextStyle(color: Colors.blue),)

        ],


      ),




    );

  }

  buildContentTitleView(BuildContext context) {

    return  Container(

      color: Colors.white,
      height: ScreenUtil().setHeight(100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(wrapAssets("shop_line_left.png"),width: ScreenUtil().setWidth(65),),
          cXM(ScreenUtil().setWidth(15)),
          Text("详情描述",style: TextStyle(color: Colors.black38),),
          cXM(ScreenUtil().setWidth(15)),
          Image.asset(wrapAssets("shop_line_right.png"),width: ScreenUtil().setWidth(65),),

        ],

      ),



    );

  }

  buildContentView(BuildContext context) {

    var unescape = new HtmlUnescape();
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(25), ScreenUtil().setWidth(5), ScreenUtil().setWidth(25), ScreenUtil().setWidth(25)),
      color: Colors.white,
      child: Html(data: unescape.convert(_shopHomeInfo.content)),

    );




  }





}
