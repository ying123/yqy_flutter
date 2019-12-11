import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';

class TabSpecialPage extends StatefulWidget {
  @override
  _TabSpecialPageState createState() => _TabSpecialPageState();
}

class _TabSpecialPageState extends State<TabSpecialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: ListView(
        
        
        children: <Widget>[
          
          buildBanner(context),
          
          buildItemView(context),
          buildItemView(context),
          buildItemView(context),
          buildItemView(context)


          
          
        ],
      ),

    );
  }

  buildBanner(BuildContext context) {
    
    return Container(
      
      height: ScreenUtil().setHeight(403),
      child: Image.asset(wrapAssets("tab/tab_live_banner.png")),

    );
    
    
  }

  buildItemView(BuildContext context) {

    return  Padding(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(26), ScreenUtil().setHeight(50), ScreenUtil().setWidth(26),  ScreenUtil().setHeight(30)),
      child: Column(

        children: <Widget>[
          Container(
            color: Colors.red,
            height: ScreenUtil().setHeight(95),
          ),

          Column(

            children: <Widget>[

              getLiveItemView(),
              getLiveItemView(),
              getLiveItemView(),

            ],
          )


        ],

      ),
    );


  }

    Widget getLiveItemView(){

      return  GestureDetector(

        onTap: (){
          RRouter.push(context ,Routes.specialDetailPage,{});
        },

        child: new Container(
          height: ScreenUtil().setHeight(250),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Image.asset(wrapAssets("tab/tab_live_img.png"),fit: BoxFit.fill,height: ScreenUtil().setHeight(215),width:ScreenUtil().setWidth(288)),
              cXM(ScreenUtil().setHeight(20)),
              new Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text("北京妇科专家协会",style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(40)),maxLines: 2,overflow: TextOverflow.ellipsis,),

                      ),
                      Container(
                        width: ScreenUtil().setWidth(700),
                        child:   Text("北京妇科专家学会由98名北京"*2,style: TextStyle(color: Color(0xFF7E7E7E),fontSize:  ScreenUtil().setSp(32)),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      )

                    ],

                  )

              )


            ],


          ),

        ),


      );

    }
}
