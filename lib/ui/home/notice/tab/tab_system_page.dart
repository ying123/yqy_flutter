import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';



class TabSystemPage extends StatefulWidget {
  @override
  _TabSystemPageState createState() => _TabSystemPageState();
}

class _TabSystemPageState extends State<TabSystemPage> {
  @override
  Widget build(BuildContext context) {
    return  ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[

        getNoticeItemView(context),
        getNoticeItemView(context),
        getNoticeItemView(context),


      ],
    );
  }


  getNoticeItemView(BuildContext context) {

    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(50), ScreenUtil().setHeight(30), ScreenUtil().setWidth(50), 0),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(25), 0, 0, ScreenUtil().setWidth(25)),
      width: double.infinity,
      height: ScreenUtil().setHeight(400),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(18))),
          color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("标题",style: TextStyle(fontSize: ScreenUtil().setSp(45),color: Colors.black54),),
          Text("内容"),
          Container(
            margin: EdgeInsets.only(right: ScreenUtil().setWidth(25)),
            alignment: Alignment.centerRight,
            width: double.infinity,
            child: Text("创建的时间",style: TextStyle(color: Colors.black26),),

          )
        ],

      ),



    );


  }

}
