import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/utils/margin.dart';
///
///  员工列表
///
class StaffListPage extends StatefulWidget {
  @override
  _StaffListPageState createState() => _StaffListPageState();
}

class _StaffListPageState extends State<StaffListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("员工列表"),
        centerTitle: true,
      ),

      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context,index){
            return Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(95)),
                height: ScreenUtil().setHeight(146),
                color: Colors.white,
                width: double.infinity,
                child:  Column(

                  children: <Widget>[

                    new  Container(
                      height: ScreenUtil().setHeight(145),
                      child:  new Row(
                        children: <Widget>[
                          Image.asset(
                            wrapAssets("icon_home_s.png"), width: ScreenUtil().setWidth(81),
                            height: ScreenUtil().setWidth(81),),
                            cXM(ScreenUtil().setWidth(21)),
                            Expanded(
                              child: Text("张小燕", style: TextStyle(
                                  color: Color(0xFF333333),
                                  fontSize: ScreenUtil().setSp(40)))
                           ),

                        ],
                      ),
                    ),

                    Divider(height: ScreenUtil().setHeight(1),color: Color(0xFFF2F2F2),)

                  ],

                )

            );
          },

      ),

    );
  }
}
