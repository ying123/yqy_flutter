import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/shop/bean/order_detail_entity.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';


class OrderDetailPage extends StatefulWidget {

  String id ;

  OrderDetailPage(this.id);

  @override
  _OrderDetailPageState createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {


  OrderDetailInfo _detailInfo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();

  }


  @override
  Widget build(BuildContext context) {
    return  new Scaffold(

      appBar: getCommonAppBar("订单详情"),

      body:_detailInfo==null?Container(): Column(

        children: <Widget>[

          buildTopView(context),


          cYM(setH(20)),

          buildAddressView(context,_detailInfo),

          buildInfoView(context,_detailInfo),

          cYM(setH(20)),

          buildBottomView(context)


        ],
      ),


    );


  }

  buildTopView(BuildContext context) {

    return Container(
      height: setH(242),
      decoration: BoxDecoration(

        gradient: LinearGradient(colors: [Color(0xFF4AB1F2),Color(0xFF296DDD)])
        
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  buildText("订单已发货",size: 40,color: "#FFFFFFFF"),
                  cYM(setH(10)),
                  buildText("请注意查收您的包裹",size: 32,color: "#FFFFFFFF"),


                ],

              )



        ],


      ),

    );

  }


  Widget  buildInfoView(BuildContext context, OrderDetailInfo bean) {

    return InkWell(

      onTap: (){

      },
      child: new  Container(
        padding: EdgeInsets.all(setW(40)),
        margin: EdgeInsets.only(bottom: setH(30)),
        color: Colors.white,
        height: setH(494),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                buildText("2020-01-19  09:30:50",size: 34,color: "#FF999999"),
                buildText(getStatusString(bean.orderStatus),size: 34,color: "#FF999999"),

              ],
            ),

            new Row(
              children: <Widget>[

                wrapImageUrl(bean.goods.image, setW(173),  setW(173)),

                cXM(setW(40)),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    buildText(bean.goods.title),
                    buildText(bean.points??""+"积分"+"x"+bean.nums.toString(),size: 34,color: "#FF999999"),


                  ],
                )

              ],
            ),

            new Container(
              alignment: Alignment.centerRight,
              child: buildText("共"+bean.nums.toString()+"件商品，合计:"+(bean.nums*int.parse(bean.points??"0")).toString(),size: 34,color: "#FF999999"),

            ),


            Visibility(
                visible: bean.orderStatus==3?true:false,
                child: InkWell(
                  onTap: (){

                    sendOrderConfirm(context,bean.id);
                  },
                  child:  new Container(
                    width: double.infinity,
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: setW(288),
                      height: setH(86),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(setW(43))),
                          border: Border.all(color: Color(0xFF2CAAEE),width: setW(1))
                      ),
                      child: buildText("确认收货",color: "#FF2CAAEE"),
                    ),
                  ),

                ))


          ],
        ),



      ),
    );

  }

  ///
  ///  根据订单数字  返回状态字符串
  ///
  String getStatusString(int orderStatus) {

    String v;
    switch(orderStatus){
      case 0:
        v = "审核失败";
        break;
      case 1:
        v = "已下单";
        break;
      case 2:
        v = "待发货";
        break;
      case 3:
        v = "已发货";
        break;
      case 4:
        v = "已确认收货";
        break;

    }

    return v;


  }


  ///
  ///   确认收货的 请求
  ///
  void sendOrderConfirm(BuildContext context,int orderId) {

    NetUtils.requestMyOrderConfirm(orderId.toString())
        .then((res){

      if(res.code==200){

        loadData();

      }else{
        showToast(res.msg);
      }

    });

  }



  buildAddressView(BuildContext context, OrderDetailInfo bean) {

    return Container( // 显示之前填写的地址信息

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

                buildText(bean.address.name+"   "+bean.address.tel,size: 40),
                cYM(setH(5)),
                buildText(bean.address.address,size: 40),


              ],
            ),
          )),

        //  Icon(Icons.arrow_forward_ios,size: setW(50),color: Colors.black26,),

        ],
      ),

    );

  }

  buildBottomView(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(setW(60)),
      color: Colors.white,
      height: setH(288),
      child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

          new  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                buildText("订单编号",size: 34,color: "#FF999999"),
                buildText("12345678922",size: 34,color: "#FF999999"),

              ],
            ),
          new  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              buildText("下单时间",size: 34,color: "#FF999999"),
              buildText("2019-12-31  09:30:50",size: 34,color: "#FF999999"),

            ],
          ),
          new  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              buildText("发货时间",size: 34,color: "#FF999999"),
              buildText("2020-12-31  18:30:50",size: 34,color: "#FF999999"),

            ],
          )

          ],
      ),

    );


  }

  void loadData() {

    NetUtils.requestMyOrderInfo(widget.id)
        .then((res){

          if(res.code==200){


            setState(() {
              _detailInfo = OrderDetailInfo.fromJson(res.info);
            });

          }

     });

  }
}
