import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_buy_order_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';


class ShopBuyOrderPage extends StatefulWidget {

  String id;


  ShopBuyOrderPage(this.id);

  @override
  _ShopBuyOrderPageState createState() => _ShopBuyOrderPageState();
}

class _ShopBuyOrderPageState extends State<ShopBuyOrderPage> {

  ShopBuyOrderInfo _orderInfo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text("提交订单"),
      ),

      body: Column(

        children: <Widget>[


          Expanded(child:  ListView(
            shrinkWrap: true,
            children: <Widget>[

              // 添加地址
              buildAddAddressView(context),

              // 商品信息
              buildShopInfoView(context),
            ],

          ),),
        buildBottomView(context)  // 提交订单

        ],

      )

      
      
    );
  }


  ///
  ///  添加地址
  ///
  buildAddAddressView(BuildContext context) {


      if(_orderInfo==null){

        return Container();
      }

      // 如果id 等于null 表示之前没有添加过地址

      return _orderInfo.address.id==null? Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(setW(58), 0, setW(58),  0),
        margin: EdgeInsets.only(bottom: setH(40)),
        height: setH(173),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            buildText("您还没有收货地址，赶快添加吧！",size: 40),

            InkWell(

              onTap: (){

                RRouter.push(context ,Routes.addAddressPage,{},transition:TransitionType.cupertino);

              },

              child:   Container(
                width: setW(288),
                height: setH(86),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(setW(43))),
                    border: Border.all(color: Color(0xFF2CAAEE),width: setW(1))
                ),
                alignment: Alignment.center,
                child: buildText("添加地址",size: 40,color: "#FF2CAAEE"),
              ),

            )
          ],
        ),
      ):Container( // 显示之前填写的地址信息

        color: Colors.white,
        padding: EdgeInsets.fromLTRB(setW(58), 0, setW(58),  0),
        margin: EdgeInsets.only(bottom: setH(40)),
        height: setH(180),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[

            Icon(Icons.place,color: Colors.deepOrangeAccent,size: setW(70),),
            cXM(setW(40)),
            Expanded(child:  Container(
              alignment: Alignment.centerLeft,
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  buildText(_orderInfo.address.name+"   "+_orderInfo.address.tel,size: 40),
                  cYM(setH(5)),
                  buildText(_orderInfo.address.pro+" "+_orderInfo.address.city+" "+_orderInfo.address.area+" "+_orderInfo.address.address,size: 40),


                ],
              ),
            )),

            Icon(Icons.arrow_forward_ios,size: setW(50),color: Colors.black26,),

          ],
        ),

      );

  }


  ///
  ///  商品信息
  ///
  buildShopInfoView(BuildContext context) {

    return _orderInfo==null?Container(): Container(
        color: Colors.white,
        padding: EdgeInsets.all(setW(58)),
        child: Column(

          children: <Widget>[

          new  Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[

                wrapImageUrl(_orderInfo.image, setW(260), setH(210)),
                cXM(setW(40)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                        buildText(_orderInfo.title.toString(),size: 42),
                        cYM(20),
                        buildText(_orderInfo.points.toString()+"积分",size: 33,color: "#FF999999")

                  ],
                ),


              ],
            ),

           Container(
             margin: EdgeInsets.all(setW(32)),
             height: setH(300),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[

               new  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     buildText("购买数量",size: 38),
                     buildText("1",size: 38),
                   ],
                 ),
               new  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   buildText("配送方式",size: 38),
                   buildText(_orderInfo.sendWay??"",size: 38),
                 ],
               ),
               new  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   buildText("备注",size: 38),
                   buildText("请填写学历，例：本科",size: 38,color: "#FF999999"),
                 ],
               ),
               new  Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   buildText("共1件商品，合计",size: 38,color: "#FF999999"),
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
      mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          buildText("合计：",color: "#FF999999"),
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
               color: Color(0xFFFE6017),
             ),
             child: buildText("提交订单",color:"#FFFEFEFE"),

           ),

         ),
          cXM(setW(40))
          


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

  void initData() {

    NetUtils.requestOrderInfo(widget.id)
        .then((res){

       if(res.code==200){

         setState(() {
           _orderInfo = ShopBuyOrderInfo.fromJson(res.info);
         });

       }




    });


  }


}

