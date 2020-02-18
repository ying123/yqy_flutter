import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';


class TabHDPage extends StatefulWidget {
  @override
  _TabHDPageState createState() => _TabHDPageState();
}

class _TabHDPageState extends State<TabHDPage> {
  @override
  Widget build(BuildContext context) {
    return  ListView(
      padding: EdgeInsets.all(0),
      children: <Widget>[

        buildBtnView(context,"评论我的"),
        buildBtnView(context,"我的关注"),
        buildBtnView(context,"点赞/收藏"),


      ],
    );
  }

  ///
  ///  跳转布局
  ///
  buildBtnView(BuildContext context,String value) {

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: (){

          switch(value){

            case"评论我的":
              RRouter.push(context ,Routes.feedBackPage,{},transition:TransitionType.cupertino);
              break;
            case"我的关注":
              RRouter.push(context ,Routes.taskNewPage,{});
              break;
            case"点赞/收藏":
              RRouter.push(context ,Routes.taskNewPage,{});
              break;

          }

        },
        child: Container(
          height: ScreenUtil().setHeight(140),
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(58), 0, ScreenUtil().setWidth(43), 0),
          child: Column(

            children: <Widget>[

              Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Icon(Icons.account_balance,size: ScreenUtil().setWidth(70),),
                      cXM(ScreenUtil().setWidth(23)),
                      Expanded(child:  Text(value,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40)),)),
                      Icon(Icons.arrow_forward_ios,color: Colors.black12,size: ScreenUtil().setWidth(46),),
                    ],
                  )
              ),
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(60)),
                color: Color(0xFFF2F2F2),
                height: ScreenUtil().setHeight(2),

              )



            ],


          ),


        ),
      ),
    );

  }



}
