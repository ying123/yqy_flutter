import 'package:flutter/material.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class FlDoctorPage extends StatefulWidget {
  @override
  _FlDoctorPageState createState() => _FlDoctorPageState();
}

class _FlDoctorPageState extends State<FlDoctorPage> {
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
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(27), 0, ScreenUtil().setWidth(59), 0),
      child: Column(

        children: <Widget>[
          new Row(

            children: <Widget>[
              new  Container(
                width: ScreenUtil().setWidth(196),
                height: ScreenUtil().setHeight(196),
                color: Colors.blue,
              ),
              cXM(ScreenUtil().setWidth(62)),
              new  Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Text("李英爱",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
                          cXM(ScreenUtil().setWidth(56)),
                          Text("主任医师",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w400),),
                          cXM(ScreenUtil().setWidth(32)),
                          Container(
                            width: ScreenUtil().setWidth(153),
                            height: ScreenUtil().setHeight(43),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xFF4AB1F2),
                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(22))),
                            ),
                            child: Text("呼吸内科",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(32)),),
                          )


                        ],

                      ),
                      cYM(ScreenUtil().setHeight(16)),
                      Text("山东省第二人民医院第三附属医院",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),)





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
