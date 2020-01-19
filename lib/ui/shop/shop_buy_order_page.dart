import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';


class ShopBuyOrderPage extends StatefulWidget {
  @override
  _ShopBuyOrderPageState createState() => _ShopBuyOrderPageState();
}

class _ShopBuyOrderPageState extends State<ShopBuyOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text("提交订单"),
      ),

      body: Stack(

       children: <Widget>[

         // 添加地址
         buildAddAddressView(context),

         // 商品信息
         buildShopInfoView(context),

         // 提交订单
         buildBottomView(context)




       ],

      ),

      
      
    );
  }


  ///
  ///  添加地址
  ///
  buildAddAddressView(BuildContext context) {

      return Container(
        margin: EdgeInsets.fromLTRB(setW(58), 0, setW(58), 0),
        height: setH(173),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            buildText("您还没有收货地址，赶快添加吧！",size: 40),

            Container(

              width: setW(288),
              height: setH(86),
              decoration: BoxDecoration(

                borderRadius: BorderRadius.all(Radius.circular(setW(43))),
                border: Border.all(color: Color(0xFF2CAAEE),width: setW(1))
              ),
              alignment: Alignment.center,
              child: buildText("添加地址",size: 40,color: "#FF2CAAEE"),
            )
          ],
        ),


      );

  }


  ///
  ///  商品信息
  ///
  buildShopInfoView(BuildContext context) {

    return Container(

        margin: EdgeInsets.all(setW(58)),
        child: Column(

          children: <Widget>[

          new  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                wrapImageUrl("", setW(173), setH(173)),
                cXM(setW(26)),
                Column(
                  children: <Widget>[
                        buildText("复方黄柏液涂剂护手装",size: 40),
                        buildText("50积分",size: 29,color: "#FF999999")

                  ],
                ),


              ],
            ),

           Container(
             margin: EdgeInsets.all(setW(32)),
             child: Column(

               children: <Widget>[

               new  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     buildText("购买数量",size: 35),
                     buildText("2",size: 35),
                   ],
                 ),
               new  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   buildText("配送方式",size: 35),
                   buildText("快递",size: 35),
                 ],
               ),
               new  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   buildText("备注",size: 35),
                   buildText("请填写学历，例：本科",size: 35,color: "#FF999999"),
                 ],
               ),
               new  Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   buildText("共2件商品，合计",size: 35,color: "#FF999999"),
                 ],
               )

               ],
             ),


           )


          ],
        ),


    );

  }


  buildBottomView(BuildContext context) {


    return Container(
      color: Colors.white,
      height: setH(150),
      child: Row(

        children: <Widget>[
         InkWell(
           onTap: (){

              showPayFailDialog(context);
           },
           child: new  Container(
             width: setW(334),
             height: setH(105),
             alignment: Alignment.center,
             decoration: BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(setW(53))),

             ),
             child: buildText("提交订单",color:"#FFFEFEFE"),

           ),

         ),
          
        buildText("合计：",color: "#FF999999")

        ],
      ),


    );

  }


  ///
  ///
  ///
  void showPayFailDialog(BuildContext context) {

    showDialog(context: context,
        builder: (_)=>Material(
          color: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(setW(12)))
            ),
            margin: EdgeInsets.fromLTRB(setW(100), setW(800), setW(100), setW(850)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                cYM(setH(40)),

                wrapImageUrl("", setW(127), setH(127)),

                buildText("支付失败！"),

                buildText("您的积分不足，快去做任务赚取积分吧",size: 29,color: "#FF999999"),

                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(top: setH(40)),
                  height: setH(150),
                  child:   new  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(child: InkWell(
                        child:  Container(
                          alignment: Alignment.center,
                          child: buildText("取消"),
                        ),
                        onTap: (){
                          Navigator.pop(_);
                          // 前去拨打电话
                        },
                      )),
                      Expanded(child: InkWell(
                        child:  Container(
                          alignment: Alignment.center,
                          child: buildText("做任务",color: "#FFFA994C"),
                        ),
                        onTap: (){
                          Navigator.pop(_);
                        },
                      )),


                    ],

                  ),

                )

              ],

            ),


          ),


        )
    );
    
  }


}

