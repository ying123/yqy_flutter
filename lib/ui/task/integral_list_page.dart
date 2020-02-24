import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
///   积分明细列表
///
class IntegralListPage extends StatefulWidget {
  @override
  _IntegralListPageState createState() => _IntegralListPageState();
}

class _IntegralListPageState extends State<IntegralListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("积分明细"),

      ),

      body: Column(

        children: <Widget>[


          buildTopView(context),
          buildTaskListView(context)


        ],




      ),




    );
  }

  buildTopView(BuildContext context) {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(setW(30), 0, setW(30), 0),
      height: setH(200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildText("积分明细",color: "#FF333333",size: 40,fontWeight: FontWeight.bold),
              cYM(setH(12)),
              buildText("本月新增 100 积分，扣除 0 积分",size: 32,color: "#FF999999")
            ],
          ),

        ],



      ),



    );

  }

  buildTaskListView(BuildContext context) {

    return ListView.builder(
        shrinkWrap: true,
        itemCount: 6,
        itemBuilder: (context,index){
          return buildItemView(context);

        });


  }

  buildItemView(BuildContext context) {


    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(setW(30), 0, setW(30), 0),
        height: setH(140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Expanded(child:    new  Row(

              children: <Widget>[

                Container(
                  width: setW(80),
                  height: setW(80),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(

                      gradient: LinearGradient(colors: [Color(0xFF87C8FE),Color(0xFF65B2FA),Color(0xFF66A6FF)]),
                      borderRadius: BorderRadius.all(Radius.circular(30))

                  ),
                  child: Text("100",style: TextStyle(color: Colors.white,fontSize: setSP(37),fontWeight: FontWeight.bold),),
                ),
                cXM(setW(30)),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        buildText("礼品兑换",size: 37,color: "#FF333333"),

                        buildText("2019-12-05  16:30:44",size: 32,color: "#FF999999"),
                      ],
                    )

                ),

                buildText("+100积分",size: 46,color: "#FFFE6017"),

              ],
            ),),
            new Container(
              margin: EdgeInsets.only(left: setW(110),right: setW(27) ),
              color: Color(0xFFEEEEEE),
              height: setH(2),

            )


          ],
        )


    );

  }
}