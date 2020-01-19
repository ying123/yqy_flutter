import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';


class OrderDetailPage extends StatefulWidget {
  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: getCommonAppBar("订单详情"),

      body: Column(

        children: <Widget>[

          buildTopView(context),

          buildAddressView(context),

          buildInfoView(context),

          buildBottomView(context)



        ],
      ),


    );


  }

  buildTopView(BuildContext context) {

    return Container(

      height: setH(242),
      color: Colors.blue,
    );

  }

  buildInfoView(BuildContext context) {

    return Container(

      height: setH(494),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          new  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              buildText("2020-01-19  09:30:50",size: 32,color: "#FF999999"),
              buildText("已发货",size: 32,color: "#FF999999"),

            ],
          ),

          new Row(
            children: <Widget>[

              wrapImageUrl("", setW(173),  setW(173)),

              Column(

                children: <Widget>[

                  buildText("复方黄柏液涂剂护手装"),
                  buildText("50积分x2",size: 29,color: "#FF999999"),



                ],
              )

            ],
          ),

          new Container(
            alignment: Alignment.centerRight,
            child: buildText("共2件商品，合计",size: 26,color: "#FF999999"),

          ),


          new Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: Container(
              width: setW(288),
              height: setH(86),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(setW(43))),
                  border: Border.all(color: Color(0xFF999999),width: setW(1))
              ),
              child: buildText("查看物流 "),
            ),
          )


        ],
      ),



    );
  }

  buildAddressView(BuildContext context) {

    return Container(

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
          Icon(Icons.edit_location),

          Column(
            children: <Widget>[

              buildText("张晓晓  155****6666"),

              buildText("山东省 济南市 历下区 明湖东路保利大名湖C座605",size: 35)

            ],
          )
          


        ],

      ),
    );

  }

  buildBottomView(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(setW(60)),
      color: Colors.white,
      height: setH(288),
      child: Column(

          children: <Widget>[

          new  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                buildText("订单编号",size: 32,color: "#FF999999"),
                buildText("12345678922",size: 32,color: "#FF999999"),

              ],
            ),
          new  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              buildText("下单时间",size: 32,color: "#FF999999"),
              buildText("2019-12-31  09:30:50",size: 32,color: "#FF999999"),

            ],
          ),
          new  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              buildText("发货时间",size: 32,color: "#FF999999"),
              buildText("2020-12-31  18:30:50",size: 32,color: "#FF999999"),

            ],
          )

          ],
      ),

    );



  }
}
