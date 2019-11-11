import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/user/bean/integral_details_entity.dart';
import 'package:yqy_flutter/utils/user_utils.dart';


class MyIntegralDetailPage extends StatefulWidget {

  String id;


  MyIntegralDetailPage(this.id);

  @override
  _MyIntegralDetailPageState createState() => _MyIntegralDetailPageState();
}

class _MyIntegralDetailPageState extends State<MyIntegralDetailPage> {


  IntegralDetailsEntity _detailsEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }



  loadData () async{

    NetworkUtils.requestScoresDetail(UserUtils.getUserInfo().userId,widget.id)
        .then((res){
      int statusCode = int.parse(res.status);
      if(statusCode==9999){

        _detailsEntity = IntegralDetailsEntity.fromJson(res.info);

        setState(() {

        });

      }
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        centerTitle: true,
        title: Text("明细详情"),
      ),

      body: Column(

        children: <Widget>[

          buildTypeView(context,"流水号",_detailsEntity==null?"":_detailsEntity.xList.tradeNo),
          Divider(height: 1,),
          //payType 0:充值,1:提现,2:收入,3:消费
          buildTypeView(context,"类型",_detailsEntity==null?"":_detailsEntity.xList.moneyType=="0"?"收入":"消费"),
          Divider(height: 1,),
          buildTypeView(context,"积分",_detailsEntity==null?"":_detailsEntity.xList.moneyType=="0"?"+"+_detailsEntity.xList.money:"-"+_detailsEntity.xList.money),
          Divider(height: 1,),
          buildTypeView(context,"时间",_detailsEntity==null?"":_detailsEntity.xList.createTime),
          Divider(height: 1,),
          buildTypeView(context,"积分余额",_detailsEntity==null?"":_detailsEntity.xList.userMoney),
          Divider(height: 1,),
          buildTypeView(context,"说明",_detailsEntity==null?"":_detailsEntity.xList.remark)

        ],

      ),
    );

  }


  Widget  buildTypeView(BuildContext context,String t,String v) {

    return InkWell(
      onTap: (){
      },
      child:  Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Text(t,style: TextStyle(color: Colors.black87,fontSize: 16),),
            new Expanded(
                child: Container(
                    padding: EdgeInsets.only(right: 5),
                    alignment: Alignment.centerRight,
                    child: Text(v,style: TextStyle(color: Colors.black87,fontSize: 15),)
                )

            ),

            //    Icon(Icons.keyboard_arrow_right,size: 30,color: Colors.black26,),


          ],
        ),

      ),
    );

  }

 String getTextStatus() {


  }



}
