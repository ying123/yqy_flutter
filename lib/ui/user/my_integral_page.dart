import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/user/bean/integral_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_list_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
///
///  我的积分页面
///
class MyIntegralPage extends StatefulWidget {
  @override
  _MyIntegralPageState createState() => _MyIntegralPageState();
}

class _MyIntegralPageState extends State<MyIntegralPage> {


  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  IntegralInfo _integralInfo;

  IntegralListInfo _integralList;

  int page = 1;

  String type = "all";

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
    loadDataMore();
  }




  loadDataMore () async{

    NetworkUtils.requestScoresList(userId: UserUtils.getUserInfo().userId,page: page.toString(),payType:type)
          .then((res){
      int statusCode = int.parse(res.status);
      if(statusCode==9999){

          if (IntegralListInfo
              .fromJson(res.info)
              .xList.rows.length== 0) {
            _refreshController.loadNoData();
          } else {
            _integralList.xList.rows.addAll(IntegralListInfo.fromJson(res.info).xList.rows);
            _refreshController.loadComplete();
          }
          setState(() {

          });

      }
    });

  }

  loadData () async{

    Future.wait([
      NetworkUtils.requestScores(UserUtils.getUserInfo().userId),
      NetworkUtils.requestScoresList(userId: UserUtils.getUserInfo().userId,page: page.toString(),payType:type),

    ]).then((ress){


      _integralInfo = IntegralInfo.fromJson(ress[0].info);

      _integralList = IntegralListInfo.fromJson(ress[1].info);

      setState(() {

      });



    });




  }


  @override
  Widget build(BuildContext context) {

    return Material(

      child:new SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: new  CustomScrollView(

          slivers: <Widget>[
            new  SliverAppBar(
              title: Text("我的积分"),
              centerTitle: true,
              leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios,color: Colors.white,),
              ),
              pinned: true,
              bottom: PreferredSize(child: buildTitle(context), preferredSize: Size.fromHeight(40)),
              expandedHeight: ScreenUtil().setHeight(750),
              flexibleSpace: new FlexibleSpaceBar(
                  background: Container(

                    child: new Stack(
                      children: <Widget>[
                        Image.asset(wrapAssets("bg_wallet.png"),width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                        Container(
                          alignment: Alignment.center,
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 10,),
                              Text("积分余额",style: TextStyle(color: Colors.white,fontSize: 18),),
                              SizedBox(height: 30,),
                              Text(_integralInfo==null?"0.00":_integralInfo.userMoney,style: TextStyle(color: Colors.white,fontSize: 32,fontWeight: FontWeight.bold),),

                            ],

                          ),

                        )

                      ],
                    ),
                  )

              ),
            ),

            SliverList(
                delegate: SliverChildBuilderDelegate(
                        (BuildContext content, int index) {

                      return _integralList==null?Container():buildListItem(context,_integralList.xList.rows[index]);
                    }, childCount:_integralList==null?0:_integralList.xList.rows.length)

            )

          ],
        ) ,




      ),
    );

  }

 Widget buildTitle(BuildContext context) {
    
    return Container(
      color: Colors.white,
      height: 40,
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: 10),
      child: Text("积分明细"),
      
      
    );
    
    
  }

  Widget buildListItem(BuildContext context,IntegralListInfoListRow bean) {

    return InkWell(

      onTap: (){

        RRouter.push(context, Routes.myIntegralDetailPage,{"id":bean.id});

      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(bean.moneyType=="0"?wrapAssets("icon_integralr.png"):wrapAssets("icon_withdraw.png"),width: 50,height: 50,fit: BoxFit.fill,),
                SizedBox(width: 10,),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(bean.moneyType=="0"?"收入":"消费",style: TextStyle(color: Colors.black87,fontSize: 15,decoration: TextDecoration.none,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    SizedBox(height: 5,),
                    Text(bean.createTime,style: TextStyle(color: Colors.black45,fontSize: 13,decoration: TextDecoration.none,),maxLines: 2,overflow: TextOverflow.ellipsis,),
                  ],
                )),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Text(bean.moneyType=="0"?"+"+bean.money:"-"+bean.money,style: TextStyle(color:bean.moneyType=="0"?Colors.red: Colors.purple,fontSize: 14,decoration: TextDecoration.none,),),
                    SizedBox(height: 5,),
                    Text(bean.userMoney,style: TextStyle(color: Colors.black,fontSize: 14,decoration: TextDecoration.none),),

                  ],


                )
              ],

            ),
            Divider(height: 1,)
          ],
        ),
      ),

    );


  }
}
