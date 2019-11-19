import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';
///
///
///  企业主页
///
class EnterpriseHomePage extends StatefulWidget {
  @override
  _EnterpriseHomePageState createState() => _EnterpriseHomePageState();
}

class _EnterpriseHomePageState extends State<EnterpriseHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text("企业主页"),
        centerTitle: true,
      ),
      body: Column(

        children: <Widget>[


          buildTopView(context),//顶部企业信息
          cYM(ScreenUtil().setHeight(30)),
          Expanded(
              child:  buildDepartmentAndCount(context),// 部门分类和人数
          )


        ],


      ),


    );
  }

  buildTopView(BuildContext context) {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(100), ScreenUtil().setHeight(65),ScreenUtil().setWidth(43), 0),
      width: double.infinity,
      height: ScreenUtil().setHeight(370),
      child: Column(

        children: <Widget>[

         new Row(
            children: <Widget>[
              Image.asset(
                wrapAssets("icon_home_s.png"), width: ScreenUtil().setWidth(81),
                height: ScreenUtil().setWidth(81),),
              cXM(ScreenUtil().setWidth(23)),
              Expanded(
                  child: Text("山东汉方制药有限公司", style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: ScreenUtil().setSp(46)))
              ),
              Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(164),
                height: ScreenUtil().setHeight(57),
                decoration: BoxDecoration(
                  
                  border: Border.all(color: Color(0xFF0072EE),width: ScreenUtil().setWidth(1)),
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12))),
                  color: Colors.white
                ),
                child: Text("企业详情",style: TextStyle(color: Color(0xFF0072EE),fontSize: ScreenUtil().setSp(35)),),

              )

            ],
          ),

         cYM(ScreenUtil().setHeight(55)),

         new Row(

           children: <Widget>[
             Text("我的部门：",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),),
             cXM(ScreenUtil().setWidth(23)),
             Text("临床事业部 > 临床一部",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40)),),

           ],

         ),
         cYM(ScreenUtil().setHeight(35)),
         new Row(

           children: <Widget>[
             Text("我的角色：",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),),
             cXM(ScreenUtil().setWidth(23)),
             Text("医学产品经理",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40)),),

           ],

         ),
        ],

      ),


    );



  }

  buildDepartmentAndCount(BuildContext context) {

    return  ListView(

      shrinkWrap: true,

      children: <Widget>[

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return itemDepartment();
            },
            itemCount: 5,
        ),
        cYM(ScreenUtil().setHeight(29)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return itemOtherCount();
          },
          itemCount: 2,
        )



      ],


    );


  }

  itemDepartment() {
    return Column(
      
      children: <Widget>[

       InkWell(
         onTap: (){
           RRouter.push(context ,Routes.staffListPage,{},transition:TransitionType.cupertino);
         },
         child:   Container(
           padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(99), 0, ScreenUtil().setWidth(43), 0),
           height: ScreenUtil().setHeight(146),
           width: double.infinity,
           color: Colors.white,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Text("市场部（15）",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40)),),
               Icon(Icons.arrow_forward_ios,size: 20,color: Color(0xFFC8C8C8),)

             ],


           ),

         ),
       ),
        Divider(height: ScreenUtil().setHeight(1),color: Color(0xFFF2F2F2),)

        
      ],

    );


  }

  itemOtherCount() {

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

  }
}
