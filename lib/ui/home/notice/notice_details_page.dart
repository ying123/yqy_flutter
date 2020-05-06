import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/utils/DateUtils.dart';
import 'package:yqy_flutter/utils/margin.dart';


///
///   消息详情
///
class NoticeDetailsPage extends StatefulWidget {

  String id;
  String title;
  String content;
  String  date;


  NoticeDetailsPage(this.id, this.title, this.content, this.date);

  @override
  _NoticeDetailsPageState createState() => _NoticeDetailsPageState();
}

class _NoticeDetailsPageState extends State<NoticeDetailsPage> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestReadMsgData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: getCommonAppBar(context, "消息详情"),

      body: Container(

        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(50), ScreenUtil().setHeight(30), ScreenUtil().setWidth(50), 0),
        padding: EdgeInsets.all(setW(30)),
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(18))),
            color: Colors.white
        ),

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Text(widget.title,style: TextStyle(fontSize: ScreenUtil().setSp(45),color: Colors.black54),maxLines: 2,overflow: TextOverflow.ellipsis,),
            Text(widget.content,style: TextStyle(color: Colors.black12,fontSize: setSP(36)),maxLines: 1,overflow: TextOverflow.ellipsis,),

            Container(
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(25)),
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: Text(widget.date,style: TextStyle(color: Colors.black26),),
            )
          ],

        ),

      ),

    );
  }


  ///
  ///   单个消息 标记为已读的状态
  ///
  void requestReadMsgData() {


    NetUtils.requestUserSingleRead(widget.id)
        .then((res){

       if(res.code==200){
            print("消息读取成功");
       }


    });

  }


}
