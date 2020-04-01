import 'package:flui/flui.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/ui/shop/bean/order_list_entity.dart';

class OrderListPage extends StatefulWidget {
  @override
  _OrderListPageState createState() => _OrderListPageState();
}

class _OrderListPageState extends State<OrderListPage> {


  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  int page = 1;
  OrderListInfo  _listInfo ;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }

  void _onRefresh() async{
    // monitor network fetch
    //   await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    page = 1;
    loadData();
  }

  void _onLoading() async{
    page ++;
    loadData();
  }
  loadData () async{

      NetUtils.requestMyOrderLists(page.toString())
          .then((res){

        if (res.code == 200) {

          if(page>1){
            if (OrderListInfo .fromJson(res.info).lists.length == 0){
              _refreshController.loadNoData();
            } else {
              _refreshController.loadNoData();
              _listInfo.lists.addAll(OrderListInfo
                  .fromJson(res.info)
                  .lists);
            }
          }else{
            _listInfo = OrderListInfo.fromJson(res.info);
            _refreshController.refreshCompleted();
            _refreshController.resetNoData();

            if(_listInfo.lists.length==0){

              FLToast.info(text: "当前订单列表为空");

            }

          }

        }
           setState(() {
           });
      });
    

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        centerTitle: true,

        title: Text("我的订单"),

      ),

      body:  SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:  ListView.builder(
          shrinkWrap: true,
          itemCount: _listInfo==null?1:_listInfo.lists.length,
            itemBuilder: (context,index) {
              return _listInfo == null ? Container() : getListItemView(
                  context, _listInfo.lists[index]);
            }

        ),
      ),
    );
  }

 Widget  getListItemView(BuildContext context, OrderListInfoList bean) {

    return InkWell(

      onTap: (){
         RRouter.push(context ,Routes.orderDetailPage,{"id":bean.id},transition:TransitionType.cupertino);
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

                buildText(" ",size: 34,color: "#FF999999"),
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
                    buildText(bean.points.toString()+"积分"+"x"+bean.nums.toString(),size: 34,color: "#FF999999"),


                  ],
                )

              ],
            ),

            new Container(
              alignment: Alignment.centerRight,
              child: buildText("共"+bean.nums.toString()+"件商品，合计:"+(bean.nums*int.parse(bean.points??"0")).toString()+"积分",size: 34,color: "#FF999999"),

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
}
