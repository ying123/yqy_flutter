import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/task/bean/integral_list_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
///   积分明细列表
///
class IntegralListPage extends StatefulWidget {
  @override
  _IntegralListPageState createState() => _IntegralListPageState();
}

class _IntegralListPageState extends State<IntegralListPage> {

  RefreshController    _refreshController  = RefreshController(initialRefresh: false);

  IntegralListEntity _integralListEntity;

  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initData();

  }

  void _onRefresh() async{
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    page = 1;
    initData();
  }

  void _onLoading() async{
    page++;
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("积分明细"),

      ),

      body: _integralListEntity==null?Container():  SmartRefresher(
    enablePullDown: true,
    enablePullUp: true,
    controller: _refreshController,
    onRefresh: _onRefresh,
    onLoading: _onLoading,
    child: ListView.builder(
      padding: EdgeInsets.only(top: setH(20)),
        shrinkWrap: true,
        itemCount: _integralListEntity.info.data.length+1,
        itemBuilder: (context,index){
          return index==0?buildTopView(context): buildItemView(context,_integralListEntity.info.data[index-1]);
        })

      )



    );
  }


  ///
  ///  顶部
  ///
  buildTopView(BuildContext context) {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(setW(30), 0, setW(30), 0),
      height: setH(200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildText("积分明细",color: "#FF333333",size: 40,fontWeight: FontWeight.bold),
              cYM(setH(12)),
              buildText("本月新增 ${_integralListEntity.info.add} 积分，扣除 ${_integralListEntity.info.minus} 积分",size: 36,color: "#FF999999")
            ],
          ),

        ],



      ),



    );

  }


  buildItemView(BuildContext context,Data bean) {


    return Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(setW(30), 0, setW(30), 0),
        height: setH(140),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Expanded(child:    new  Row(

              children: <Widget>[

                Container(
                  width: setW(120),
                  height: setW(120),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(

                      gradient: LinearGradient(colors: [Color(0xFF87C8FE),Color(0xFF65B2FA),Color(0xFF66A6FF)]),
                      borderRadius: BorderRadius.all(Radius.circular(30))

                  ),
                  child: Text(bean.userMoney.toString(),style: TextStyle(color: Colors.white,fontSize: setSP(37),fontWeight: FontWeight.bold),),
                ),
                cXM(setW(30)),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        buildText(bean.remark,size: 37,color: "#FF333333"),

                        buildText(bean.createTime,size: 32,color: "#FF999999"),
                      ],
                    )

                ),

                buildText(getMType(bean.payType)+bean.money.toString(),size: 46,color: "#FFFE6017"),

              ],
            ),),
            new Container(
              margin: EdgeInsets.only(left: setW(110),right: setW(27) ),
              color: Color(0xFFEEEEEE),
              height: setH(2),

            )


          ],
        )


    );

  }



  void initData() {

    NetUtils.requestPointsDetailList(page)
        .then((res){
      if(page>1){
        if (IntegralListEntity
            .fromJson(res.toJson())
            .info.data.length == 0||IntegralListEntity
            .fromJson(res.toJson())
            .info==null) {
          _refreshController.loadNoData();
        } else {
          _integralListEntity.info.data.addAll(IntegralListEntity.fromJson(res.toJson()).info.data);
          _refreshController.loadComplete();
        }

      }else{
        _integralListEntity = IntegralListEntity.fromJson(res.toJson());
        _refreshController.refreshCompleted();
        _refreshController.resetNoData();
      }

      setState(() {
      });



    });
  }

  String getMType(int type) {
    // 0:充值,1:提现,3:收入,4:消费,5提现冻结
    String value = "";
    switch(type){

      case 0:
      case 3:
      case 7:
        value = "+";
        break;
      case 1:
      case 4:
        value = "-";
        break;
      case 5:
        value = "冻结 ";
        break;
    }

    return value;

  }
}