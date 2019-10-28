import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import  'package:yqy_flutter/utils/margin.dart';



class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {



@override
  void initState() {
    // TODO: implement initState
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return Scaffold(
     body:ListView(
      padding: EdgeInsets.all(0),
       children: <Widget>[

          getUserTopView(),// 顶部个人信息布局  收藏列表布局
          cYM(5),
          getTopGridView(),
          getOtherGridView(),


       ],


     ),

    );

  }
  
  Widget getItemGridView(String v,IconData iconData,Color colorr){
    
    
    return  Container(

      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Icon(iconData,size:40,color:colorr??Colors.black),
          cYM(5),
          Text(v,style: TextStyle(color: Colors.black,fontSize: 15),)

        ],

      ),

    );
    
  }
  
  

 Widget getUserTopView() => new Stack(

    children: <Widget>[

      new Column(
        children: <Widget>[
          new Container(
            height:setH(600),
            color: Colors.blue,
            child:  Stack(
              children: <Widget>[
                new  Container(
                  child: Icon(Icons.account_circle,size: 90,color: Colors.white,) ,
                  margin: EdgeInsets.fromLTRB(15, 80, 0, 0),
                )
                ,

                new  Container(
                  margin: EdgeInsets.fromLTRB(115, 90, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text("姓名",style: TextStyle(color: Colors.white,fontSize: 18),),
                      cXM(10),
                      Icon(Icons.android,size: 18,)
                    ],
                  ) ,

                ),
                new  Container(
                  margin: EdgeInsets.fromLTRB(115, 130, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text("关注：1",style: TextStyle(color: Colors.white,fontSize: 16),),
                      cXM(15),
                      Text("粉丝：1",style: TextStyle(color: Colors.white,fontSize: 16),),
                      cXM(15),
                      InkWell(
                        onTap: (){
                          RRouter.push(context, Routes.realNamePage,{},transition:TransitionType.cupertino);
                        },
                        child:  ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Container(
                            width: 75,
                            height: 25,
                            color: Colors.white,
                            child: Text("待审核",style: TextStyle(color: Colors.blue,fontSize: 12),),
                            alignment: Alignment.center,
                          ),
                        ),

                      )
                    ],

                  ),
                ),

                new Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(right: 10),
                  child:   Icon(Icons.arrow_forward_ios,size: 20,color: Colors.white,),

                ),
              ],
            ),
          ),
        ],

      ),

    ],


  );

  Widget getRowView(IconData iconData,String v) => new Container(

    color: Colors.white,
    height: 55,

    child:  new Row(

      children: <Widget>[
        cXM(15),
        Icon(Icons.android,size: 26,),
        cXM(25),
        Expanded(
          child: Container(
            decoration: new BoxDecoration(
                border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(v,style: TextStyle(fontSize: 18,color: Colors.black),),
                Container(
                  margin: EdgeInsets.only(right: 15),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.arrow_forward_ios,size: 20,color: Colors.black26,),

                )

              ],

            ),

          )

        )

      ],

    ),

  );

 Widget getTopGridView() {

   return
     Container(
       height:140,
       padding: EdgeInsets.all(5),
       child: Card(
         elevation: 0.3, //设置阴影
         shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))), //设置圆角
         child: Row(
             crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: <Widget>[
             getItemGridView("积分",Icons.monetization_on,Colors.blueAccent),
             getItemGridView("分享",Icons.share,Colors.green),
             getItemGridView("消息",Icons.message,Colors.deepOrange)

           ],
         ),

       )

     );




 }

Widget  getOtherGridView() {

   return Container(
    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
     height: 280,
     child: Card(
       elevation: 0.3, //设置阴影
       shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6.0))), //设置圆角

       child: GridView(
         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
             crossAxisCount: 3,
           //子组件宽高长度比例
         ),
         padding: EdgeInsets.all(0),
         physics: new NeverScrollableScrollPhysics(),
         children: <Widget>[
           getItemGridView("我的收藏",Icons.collections,Colors.blueAccent),
           getItemGridView("我的足迹",Icons.apps,Colors.green),
           getItemGridView("我的点赞",Icons.favorite,Colors.deepOrange),
           getItemGridView("系统设置",Icons.settings,Colors.blueAccent),
           getItemGridView("意见反馈",Icons.feedback,Colors.green),
         ],
       ),


     ),

   );

}








}



