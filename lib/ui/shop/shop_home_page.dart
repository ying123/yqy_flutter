import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';

class ShopHomePage extends StatefulWidget {
  @override
  _ShopHomePageState createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  IntegralInfo _integralInfo;

  ShopHomeEntity _shopHomeEntity;

  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData () async{

    Future.wait([
      NetworkUtils.requestScores(UserUtils.getUserInfo().userId),
      NetworkUtils.requestShopList(),

    ]).then((ress){

      _integralInfo = IntegralInfo.fromJson(ress[0].info);

      _shopHomeEntity = ShopHomeEntity.fromJson(ress[1].toJson());

      setState(() {
      });



    });




  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: new SmartRefresher(
        enablePullDown: false,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: null,
        onLoading: (){
          _refreshController.loadNoData();
        },
        child: new  CustomScrollView(

          slivers: <Widget>[
            new  SliverAppBar(
              title: Text("积分兑换活动"),
              centerTitle: true,
              leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios,color: Colors.white,),
              ),
              pinned: true,
              bottom: PreferredSize(child: buildTitle(context), preferredSize: Size.fromHeight(40)),
              expandedHeight: 240.0,
              flexibleSpace: new FlexibleSpaceBar(
                  background: Container(

                    child: new Stack(
                      children: <Widget>[
                        Image.asset(wrapAssets("shop_bg.jpg"),width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                        Container(
                          alignment: Alignment.center,
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(height: 30,),
                              Text("积分余额",style: TextStyle(color: Colors.white,fontSize: 18),),
                              SizedBox(height: 15,),
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

                      return _shopHomeEntity==null?Container():buildListItem(context,_shopHomeEntity.info[index]);
                    }, childCount:_shopHomeEntity==null?0:_shopHomeEntity.info.length)

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
      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Text("商品列表"),

          FlatButton(
              onPressed: (){
                RRouter.push(context ,Routes.myIntegralPage,{},transition:TransitionType.cupertino);
              },
              child: Row(

                children: <Widget>[
                  Text("积分明细"),
                  Icon(Icons.arrow_forward_ios,size: 16,color: Colors.black26,)
                ],

              )
          )





        ],

      ),


    );


  }

  Widget buildListItem(BuildContext context,ShopHomeInfo bean) {

    return InkWell(

      onTap: (){

      },

      child: Container(

        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(


          crossAxisAlignment: CrossAxisAlignment.start,

          children: <Widget>[

            wrapImageUrl(bean.image, double.infinity, 140,),

            Text(bean.title,style: TextStyle(fontSize: 14),textAlign: TextAlign.start,),

            Row(
              children: <Widget>[

                getTitleText(bean.points),

                cXM(5),

                Expanded(child: getContentText("积分")),


                FlatButton(
                    onPressed: (){

                      showDialogWidget(context,bean);

                    },
                    child: Container(
                      alignment: Alignment.center,

                      height: 35,
                      width: 85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: Colors.blue
                      ),
                      child: Text("立即兑换",style: TextStyle(color: Colors.white,fontSize: 14),),


                    )
                )



              ],

            )
          ],
        ),
      ),
    );


  }

  void showDialogWidget(BuildContext context,ShopHomeInfo bean) {

    String _name;
    String _phone;
    String _address;

    GlobalKey _key = new GlobalKey();

    showDialog(
      // 传入 context
      context: context,
      // 构建 Dialog 的视图
      builder: (_) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                alignment: Alignment.centerLeft,
                child:  Form(
                  key: _key,
                  child: new Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[

                            Container(

                              child:   Text('兑换商品',
                                  style: TextStyle(
                                      fontSize: 20,
                                      decoration: TextDecoration.none)),
                              width: double.infinity,
                              alignment: Alignment.center,
                            ),


                            Positioned(
                                right: 1,
                                child:  InkWell(
                                  onTap: (){
                                    Navigator.pop(_);
                                  },
                                  child: Icon(Icons.close,size: 30,),
                                )
                            )



                          ],

                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: TextFormField(
                          decoration: InputDecoration(
                              hintText: "收货姓名"
                          ),
                          validator: (String value) {
                            if(value.length==0){
                              return "请输入收货姓名";
                            }
                            return null;
                          },
                          onSaved: (v){
                            _name = v;
                          },

                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: TextFormField(
                          // obscureText: _isObscure,
                          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
                          keyboardType: TextInputType.number,
                          maxLength: 11,
                          decoration: InputDecoration(
                              hintText: "联系方式"
                          ),
                          validator: (String value) {
                            if(value.length==0){
                              return "请输入联系方式";
                            }
                            return null;
                          },
                          onSaved: (v){
                            _phone = v;
                          },
                        )
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 8),
                        child: TextFormField(
                          maxLines: 3,
                          decoration: InputDecoration(
                              hintText: "收货地址（ 例：山东省济南市历下区明湖东路789号保利大名湖B区3-603 ）"
                          ),
                          validator: (String value) {
                            if(value.length==0){
                              return "请输入收货地址";
                            }
                            return null;
                          },
                          onSaved: (v){
                            _address = v;
                          },
                        )
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: 15, bottom: 8),
                      child: FlatButton(
                          onPressed: () {

                            if((_key.currentState as FormState).validate()){

                              (_key.currentState as FormState).validate();
                              // 关闭 Dialog
                              Navigator.pop(_);

                              requestExchangeShop(_name,_phone,_address,bean.id);

                            }

                          },
                          child: Text('确定')),
                    )
                  ],
                ),)
              )
            ],
          ),
        ),

      )
    );


  }


  ///
  ///  发起兑换商品的请求
  ///
  void requestExchangeShop(String name, String phone, String address, int id) {


    NetworkUtils.requestShopExchange(id.toString(),name,phone,address)
        .then((res){

        showToast(res.message);


    });


  }


}

