import 'package:flutter/material.dart';
import  'package:yqy_flutter/utils/margin.dart';



class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {




  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body:ListView(
      padding: EdgeInsets.all(0),
       children: <Widget>[

          getUserTopView(),// 顶部个人信息布局  收藏列表布局

          getRowView(Icons.android,"我的积分"),//点击的选项卡
          getRowView(Icons.android,"我的作品"),//点击的选项卡
          getRowView(Icons.android,"我的医言"),//点击的选项卡
          getRowView(Icons.android,"我的购买"),//点击的选项卡
          getRowView(Icons.android,"我的专栏"),//点击的选项卡
          getRowView(Icons.android,"我的草稿箱"),//点击的选项卡
          getRowView(Icons.android,"系统设置"),//点击的选项卡
          getRowView(Icons.android,"意见反馈"),//点击的选项卡
       ],


     ),



    );

  }

 Widget getUserTopView() => new Stack(

    children: <Widget>[

      new Column(

        children: <Widget>[

          new Container(
            height: 200,
            color: Colors.blue,
            child:  Stack(
              children: <Widget>[
                new  Container(
                  child: Icon(Icons.account_circle,size: 90,color: Colors.white,) ,
                  margin: EdgeInsets.fromLTRB(15, 40, 0, 0),
                )
                ,
                new  Container(
                  margin: EdgeInsets.fromLTRB(115, 60, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text("姓名",style: TextStyle(color: Colors.white,fontSize: 18),),
                      cXM(10),
                      Icon(Icons.android,size: 18,)
                    ],
                  ) ,

                ),
                new  Container(

                  margin: EdgeInsets.fromLTRB(115, 90, 0, 0),
                  child: Row(
                    children: <Widget>[
                      Text("关注：1",style: TextStyle(color: Colors.white,fontSize: 16),),
                      cXM(15),
                      Text("粉丝：1",style: TextStyle(color: Colors.white,fontSize: 16),),
                      cXM(15),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          width: 75,
                          height: 25,
                          color: Colors.white,
                          child: Text("待审核",style: TextStyle(color: Colors.blue,fontSize: 12),),
                          alignment: Alignment.center,
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
          new Container(
            color: Colors.white,
            height: 60,
            alignment: Alignment.bottomCenter,
          )
        ],

      ),

      new Container(
        margin: EdgeInsets.fromLTRB(30, 160, 30, 10),
        height: 90,
        decoration: new BoxDecoration(
          color: Colors.white,
           border: new Border.all(color: Colors.blue, width: 0.1), // 边色与边宽度
// 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
           boxShadow: [BoxShadow(color:Colors.blue, offset: Offset(1, 1.0),    blurRadius:10, spreadRadius:0.5)],
          borderRadius: new BorderRadius.circular((20.0)), // 圆角度
        ),


        child: new Row(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("20",style: TextStyle(color: Colors.black,fontSize: 20),),
                cYM(15),
                Text("我的收藏",style: TextStyle(color: Colors.black45,fontSize: 18),)
              ],
            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("20",style: TextStyle(color: Colors.black,fontSize: 20),),
                cYM(15),
                Text("我的足迹",style: TextStyle(color: Colors.black45,fontSize: 18),)
              ],

            ),
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("20",style: TextStyle(color: Colors.black,fontSize: 20),),
                cYM(15),
                Text("我的点赞",style: TextStyle(color: Colors.black45,fontSize: 18),)
              ],


            )

          ],



        ),




      )

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








}



