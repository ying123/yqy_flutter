import 'dart:async';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_address_list_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_buy_order_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:yqy_flutter/utils/user_utils.dart';


class ShopBuyOrderPage extends StatefulWidget {

  String id;


  ShopBuyOrderPage(this.id);

  @override
  _ShopBuyOrderPageState createState() => _ShopBuyOrderPageState();
}

class _ShopBuyOrderPageState extends State<ShopBuyOrderPage> {

  ShopBuyOrderInfo _orderInfo;

  String _name;// 姓名

  String _tel;// 电话

  String _address;// 收件人地址，省市区和详细地址拼接到一起后的地址

  String _gid;// 	产品编号

  int _nums = 1;// 	购买数量  默认为1

  String _content; // 备注

  StreamSubscription changeSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
    initEventBusListener();
  }

  @override
  void dispose() {
    super.dispose();
    changeSubscription.cancel();
  }



  ///
  ///  监听  收货地址的切换
  ///
  void initEventBusListener() {

    changeSubscription =  eventBus.on<ShopAddressListInfoList>().listen((event) {

          initData();

    });

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
              buildLine(),
              cYM(setH(40)),
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


      if(_orderInfo.address.id!=null){

        UserUtils.saveAddress(_orderInfo.address);

      }

      if(UserUtils.getAddress()!=null){

        _orderInfo.address = UserUtils.getAddress();
      }

      // 如果id 等于null 表示之前没有添加过地址
      return _orderInfo.address.id==null? Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(setW(58), 0, setW(58),  0),
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
      ):InkWell(

        onTap: (){
          RRouter.push(context ,Routes.addressListPage,{},transition:TransitionType.cupertino);

        },
        child: Container( // 显示之前填写的地址信息
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(setW(58), 0, setW(58),  0),
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

        ),

      );

  }

  buildLine() {

    return  Container(


      child: Image.asset(wrapAssets("shop/address_line.png"),width: double.infinity,height: setH(6),fit: BoxFit.fill,),
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

                wrapImageUrl(_orderInfo.image??"", setW(260), setH(210)),
                cXM(setW(40)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                        buildText(_orderInfo.title.toString()??"",size: 42),
                        cYM(20),
                        buildText((_orderInfo.points??"0")+"积分",size: 33,color: "#FF999999")
                  ],
                ),
              ],
            ),

           Container(
             margin: EdgeInsets.all(setW(32)),
             height: setH(330),
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[

               new  Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: <Widget>[
                     Expanded(child: buildText("购买数量",size: 42)),
                     Container(
                       width: setW(273),
                       height: setH(58),
                       decoration: BoxDecoration(
                         border: Border.all(color: Color(0xFFEEEEEE),width: setW(1))
                       ),
                       child: Row(


                         children: <Widget>[
                          Material(
                            color: Colors.transparent,
                            child:  InkWell(
                              onTap: (){

                                if(_nums>1){
                                  setState(() {
                                    _nums--;
                                  });
                                }else{
                                  showToast("数量最小为1");
                                }


                              },
                              child:   Container(
                                width: setW(90),
                                height: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Color(0xFFEEEEEE),width: setW(1)) ),
                                ),
                                child: Text("-",style: TextStyle(color: Color(0xFF999999),fontSize: setSP(40)),),
                              ),
                            ),
                          ),
                          Container(
                            width: setW(90),
                            height: double.infinity,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(right: BorderSide(color: Color(0xFFEEEEEE),width: setW(1)) ),
                            ),
                            child: Text(_nums.toString()??"0",style: TextStyle(color: Color(0xFF333333),fontSize: setSP(40)),),
                          ),
                          Material(
                            color: Colors.transparent,
                            child:  InkWell(
                              onTap: (){
                                setState(() {
                                  _nums++;
                                });
                              },
                              child:   Container(
                                width: setW(90),
                                height: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Color(0xFFEEEEEE),width: setW(1)) ),
                                ),
                                child: Text("+",style: TextStyle(color: Color(0xFF999999),fontSize: setSP(40)),),
                              ),
                            ),
                          ),

                         ],

                       ),

                     )


                   ],
                 ),
               cYM(setH(30)),
               new  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   buildText("配送方式",size: 42),
                   buildText(_orderInfo.sendWay??"",size: 38),
                 ],
               ),
               new  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   buildText("备注",size: 42),

                   Expanded(
                       child: TextFormField(
                     keyboardType: TextInputType.text,
                     textInputAction: TextInputAction.next,
                     textAlign: TextAlign.end,
                     maxLines: 1,
                     decoration: InputDecoration(
                       hintText: "请填写学历，例：本科",
                       hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
                       border: InputBorder.none, // 去除下划线
                     ),
                     cursorColor: Color(0xFF2CAAEE),  // 光标颜色
                     style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
                     onChanged: (v){
                       _content = v;
                     },
                   )),
                 ],
               ),
               new  Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: <Widget>[
                   buildText("共"+_nums.toString()+"件商品，合计 ",size: 38,color: "#FF999999"),
                   buildText((_nums*int.parse(_orderInfo.points??"0")).toString(),size: 46,color: "#FFFA994C",fontWeight: FontWeight.w500),
                   buildText(" 积分",size: 38,color: "#FF999999"),
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

    return _orderInfo==null?Container(): Container(
      color: Colors.white,
      height: setH(150),
      child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          buildText("合计: ",size: 38,color: "#FF999999"),
          buildText((_nums*int.parse(_orderInfo.points??"0")).toString(),size: 46,color: "#FFFA994C",fontWeight: FontWeight.w500),
          buildText(" 积分  ",size: 38,color: "#FF999999"),
         InkWell(
           onTap: (){
              uploadOrderData();
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
  ///  支付失败的弹窗
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
            child:  new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                cYM(setH(20)),

                Image.asset(wrapAssets("pay/error.png"),width: double.infinity,height:setH(127),),
                buildText("支付失败！"),
                cYM(setH(15)),
                buildText("您的积分不足，快去做任务赚取积分吧",size: 32,color: "#FF999999"),

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
                          Navigator.pop(context);
                          RRouter.push(context ,Routes.taskNewPage,{});
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


  ///
  ///  支付成功的弹窗
  ///
  void showPaySuccessDialog(BuildContext context) {


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
            child:  new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                cYM(setH(20)),

                Image.asset(
                  wrapAssets("pay/success.png"), width: double.infinity,
                  height: setH(127),),
                buildText("支付成功", color: "#FFFA994C", size: 40),
                cYM(setH(15)),
                buildText("您的订单会尽快发货，请耐心等待", size: 35, color: "#FF999999"),

              ],

            ),


          ),

        )
    );

    // 延迟两秒 关闭
     Future.delayed(Duration(seconds: 2),(){
       Navigator.pop(context);
       Navigator.pop(context);
     });


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


  ///
  ///  提交订单数据
  ///
  void uploadOrderData() {



    Map<String,String> map = new Map();

    map["name"] = _orderInfo.address.name;
    map["tel"] = _orderInfo.address.tel;
    map["address"] = _orderInfo.address.pro+" "+_orderInfo.address.city+" "+_orderInfo.address.area+" "+_orderInfo.address.address;
    map["gid"] = _orderInfo.id.toString();
    map["nums"] = _nums.toString();
    map["content"] = _content;

    NetUtils.requestAddOrder(map)
        .then((res){

        if(res.code==200){
          showPaySuccessDialog(context);
        }else if(res.code==400){

           showPayFailDialog(context);

        }else{

          EasyLoading.showError(res.msg);

        }

    });
  }


}

