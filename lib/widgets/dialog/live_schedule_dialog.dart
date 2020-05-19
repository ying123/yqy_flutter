import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/margin.dart';
///
///  会议日程的弹窗
///
void requestSchedule(BuildContext context,String html) async {
  //网络请求
  ScreenUtil.init(context,width: 1080, height: 1920);
  // 发起弹窗
  showDialog(context: context,
      builder: (_)=>  Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.fromLTRB(setW(40), setH(350), setW(40),  setH(500)),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(setW(23))),
            color: Colors.white,
          ),

          child: new Column(
            children: <Widget>[


              Expanded(child:  ListView(
                children: <Widget>[
                  Html(

                    data: html,

                  ),
                ],

              ),),


              new InkWell(
                onTap: (){
                  Navigator.pop(_);
                },
                child:   Container(
                    width: setW(400),
                    height: setH(80),
                    margin: EdgeInsets.symmetric(vertical: setH(20)),
                  //  margin: EdgeInsets.only(bottom: setH(20)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(

                      gradient: LinearGradient(colors: [Color(0xFF68E0CF),Color(0xFF209CFF)]),
                      borderRadius: BorderRadius.all(Radius.circular(setW(58))),
                    ),
                    child: Text("关闭",style: TextStyle(color: Colors.white),)
                ),
              )

            ],

          )

        ),
      )
  );




}