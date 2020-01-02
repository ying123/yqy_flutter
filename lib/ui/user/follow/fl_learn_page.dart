import 'package:flutter/material.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class FlLearnPage extends StatefulWidget {
  @override
  _FlLearnPageState createState() => _FlLearnPageState();
}

class _FlLearnPageState extends State<FlLearnPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context,index){

          return itemListView();

        }
    );
  }

  Widget itemListView() {

    return Container(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(53), 0, ScreenUtil().setWidth(59), 0),
        child: Column(

          children: <Widget>[
            new Row(

              children: <Widget>[
                new  Container(
                  width: ScreenUtil().setWidth(116),
                  height: ScreenUtil().setHeight(116),
                  color: Colors.blue,
                ),
                cXM(ScreenUtil().setWidth(29)),
                new  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Row(
                          children: <Widget>[
                            Text("中华医学会",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
                          ],

                        ),
                        Text("2269粉丝",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),)

                      ],


                    )
                ),
                cXM(ScreenUtil().setWidth(50)),
                new  Container(
                  width: ScreenUtil().setWidth(153),
                  height: ScreenUtil().setHeight(55),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Color(0xFF999999),
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(22))),
                  ),
                  child: Text("已关注",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(32)),),
                )



              ],
            ),
            cYM(ScreenUtil().setHeight(16)),
            Divider(height: ScreenUtil().setHeight(2),color: Color(0xFFEEEEEE),)


          ],
        )

    );

  }
}
