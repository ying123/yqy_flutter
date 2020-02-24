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
///   任务列表
///
class TaskListPage extends StatefulWidget {
  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("任务列表"),

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
                    buildText("视频任务（2 / 5 ）",color: "#FF333333",size: 40,fontWeight: FontWeight.bold),
                    cYM(setH(12)),
                    buildText("完成全部视频观看任务即可领取350积分",size: 32,color: "#FF999999")
                  ],
                ),
            
                buildText("显示未完",color: "#FF999999",size: 32)
            
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
              Expanded(child: buildText("复方黄柏液使用说明",size: 37,color: "#FF333333")),


              Container(
                width: setW(190),
                height: setH(52),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(26)),
                    border: Border.all(color: Color(0xFF4AB1F2),width: setW(1))

                ),
                child: Text("观看视频",style: TextStyle(color: Color(0xFF4AB1F2),fontSize: setSP(35)),),

              )




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
