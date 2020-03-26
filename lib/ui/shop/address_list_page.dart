import 'package:flui/flui.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_address_list_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_buy_order_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:yqy_flutter/utils/user_utils.dart';


class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {


  // 之前存储的默认地址
  ShopBuyOrderInfoAddress _address;

  ShopAddressListInfo _addressListInfo;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();

    _address =  UserUtils.getAddress();

  }


  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    initData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("地址管理"),
      ),

      body:  Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          buildDefaultAddress(context),
          buildLine(),
          _addressListInfo==null?Container():buildAddressListView(context),
          cYM(setH(20)),
          buildAddTextView(context)

        ],

      )

    );
  }

  void initData() {

      NetUtils.requestAddressLists()
          .then((res){

            if(res.code==200){


              if(mounted){

                setState(() {
                  _addressListInfo =   ShopAddressListInfo.fromJson(res.info);
                });

              }



            }

      });

  }


  ///
  ///  默认地址的布局
  ///
  buildDefaultAddress(BuildContext context) {

      return Container( // 显示之前填写的地址信息

        color: Colors.white,
        padding: EdgeInsets.fromLTRB(setW(58), 0, setW(58),  0),
        height: setH(200),
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

                  buildText(_address.name+"   "+_address.tel,size: 42,fontWeight: FontWeight.w500),
                  cYM(setH(5)),
                  buildText(_address.pro+" "+_address.city+" "+_address.area+" "+_address.address,size: 42,fontWeight: FontWeight.w500),


                ],
              ),
            )),


          ],
        ),

      );


  }

  ///
  ///  列表布局
  ///
  buildAddressListView(BuildContext context) {

      return ListView.builder(
          itemCount: _addressListInfo.lists.length,
          padding: EdgeInsets.all(0),
          shrinkWrap: true,
          itemBuilder: (context,index){

              return itemView(_addressListInfo.lists[index]);

      });
  }

  itemView(ShopAddressListInfoList list) {

     return   InkWell(

       onTap: (){

            // 发送消息   更换收货地址
            getUpdateAddressData(context,list);


       },

       child: new Container( // 显示之前填写的地址信息
         color: Colors.white,
         padding: EdgeInsets.fromLTRB(setW(58), 0, setW(58),  0),
         margin: EdgeInsets.only(bottom: setH(15)),
         height: setH(200),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: <Widget>[

             Container(
               width: setW(25),
               height: setW(25),
               margin: EdgeInsets.only(left: setW(30)),
               decoration: BoxDecoration(

                   border: Border.all(color: Color(0xFF999999),width: setW(1)),
                   borderRadius: BorderRadius.all(Radius.circular(30))

               ),


             ),
             cXM(setW(40)),
             Expanded(child:  Container(
               alignment: Alignment.centerLeft,
               child:  Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[

                   buildText(list.name+"   "+list.tel,size: 40,color: "#FF999999"),
                   cYM(setH(5)),
                   buildText(list.pro+" "+list.city+" "+list.area+" "+list.address,size: 40,color: "#FF999999"),


                 ],
               ),
             )),

             InkWell(

               onTap: (){

                  RRouter.push(context ,Routes.updateAddressPage,{"id":list.id.toString()},transition:TransitionType.cupertino);

               },
               child: buildText("编辑",size: 42,color: "#FFFB7D39"),
             )

           ],
         ),

       ),

     );


  }

  ///
  ///  添加地址的按钮
  ///
  buildAddTextView(BuildContext context) {

      return InkWell(
        onTap: (){
          RRouter.push(context ,Routes.addAddressPage,{},transition:TransitionType.cupertino);
        },
        child: buildText("+  添加新地址",size: 50,color: "#FF999999"),
      );

  }

  void getUpdateAddressData(BuildContext context,ShopAddressListInfoList bean) {


    var dismiss = FLToast.loading();
    NetUtils.requestSetDefaultAddress(bean.id.toString())
          .then((res){

            if(res.code==200){
              eventBus.fire(bean);
              dismiss();
              Navigator.pop(context);
            }else{

              FLToast.error(text:res.msg);

            }

    }).catchError((){
      dismiss();
    });



  }

  buildLine() {

    return  Container(


      child: Image.asset(wrapAssets("shop/address_line.png"),width: double.infinity,height: setH(6),fit: BoxFit.fill,),
    );


  }
}
