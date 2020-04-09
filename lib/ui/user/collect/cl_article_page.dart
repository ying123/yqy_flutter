import 'package:flutter/material.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClArticlePage extends StatefulWidget {
  @override
  _ClArticlePageState createState() => _ClArticlePageState();
}

class _ClArticlePageState extends State<ClArticlePage> {
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: Colors.white,

      body: Center(

        child: Text("暂无数据"),

      )
    );
  }

  Widget itemListView() {

    return Container(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29), ScreenUtil().setWidth(49), ScreenUtil().setWidth(40), 0),
        child: Column(

          children: <Widget>[
            new Row(

              children: <Widget>[
                new  Container(
                  width: ScreenUtil().setWidth(90),
                  height: ScreenUtil().setHeight(90),
                  color: Colors.blue,
                ),
                cXM(ScreenUtil().setWidth(16)),
                Text("孙黄力",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35)),),
                cXM(ScreenUtil().setWidth(16)),
                Text("2019-12-30  16:59:33",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),)

              ],
            ),
            cYM(ScreenUtil().setHeight(29)),
            new   Container(
             padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(88), 0, ScreenUtil().setWidth(88), 0),
             child:    Text("案例分析案例分析案例分析案例分析案例分析案例分析",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35)),),
           ),
            new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton.icon(onPressed: (){}, icon: Icon(Icons.add_circle,size: ScreenUtil().setWidth(50),), label: Text("558",style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Color(0xFF999999)),),padding: EdgeInsets.all(0),),
              FlatButton.icon(onPressed: (){}, icon: Icon(Icons.add_circle,size: ScreenUtil().setWidth(50),), label: Text("558",style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Color(0xFF999999)),),padding: EdgeInsets.all(0),),
              FlatButton.icon(onPressed: (){}, icon: Icon(Icons.add_circle,size: ScreenUtil().setWidth(50),), label: Text("558",style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Color(0xFF999999)),),padding: EdgeInsets.all(0),),
           //   FlatButton.icon(onPressed: (){}, icon: Icon(Icons.add_circle,size: ScreenUtil().setWidth(50),), label: Text("558",style: TextStyle(fontSize: ScreenUtil().setSp(35),color: Color(0xFF999999)),),padding: EdgeInsets.all(0),),

            ],

          ),
            Divider(height: 2,color: Color(0xFFEEEEEE),)


          ],
        )

    );

  }

}
