import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_details_entity.dart';


class ShopDetailsPage extends StatefulWidget {

  String  id ;

  ShopDetailsPage(this.id);

  @override
  _ShopDetailsPageState createState() => _ShopDetailsPageState();
}

class _ShopDetailsPageState extends State<ShopDetailsPage> {


  ShopDetailsInfo _shopDetailsInfo;

  YYDialog _yyDialog;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();




  }



  @override
  Widget build(BuildContext context) {
    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.init(context,width: 1080, height: 1920);
    return Scaffold(

      appBar: getCommonAppBar(context, "商品详情"),

      body:Column(
        children: <Widget>[
          Expanded(child:   _shopDetailsInfo==null?Container():  ListView(

            children: <Widget>[

            buildImageView(context),

             Container(
                color: Colors.white,
                padding: EdgeInsets.all(setH(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    buildText(_shopDetailsInfo.title,size: 46),
                    cYM(setH(46)),
                    buildText(_shopDetailsInfo.points+"积分",size: 40,color: "#FFFA994C"),
                    cYM(setH(46)),
                    buildText("剩余库存："+_shopDetailsInfo.nums,size: 40,color: "#FF999999"),
                    cYM(setH(46)),
                    buildText("截止时间："+_shopDetailsInfo.closeTime.toString(),size: 40,color: "#FF999999"),
                    cYM(setH(25)),

                  ],
                ),
              ),
             buildContentTitleView(context),
             buildContentView(context),
            ],
          )),

        new  Container(
            color: Colors.white,
            height: setH(161),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
               cXM(setW(60)),
                InkWell(

                  onTap: (){

                  //  showServiceDialogView(context);

                    if(_yyDialog==null){
                      _yyDialog =  YYAlertDialogBody(context);
                    }

                    _yyDialog.show();

                  },
                  child:   Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Image.asset(wrapAssets("shop/icon_kf.png"),width: setW(65),height: setH(65),),
                      buildText("客服",size: 40,color: "#FF999999")


                    ],
                  ),
                ),
               Expanded(
                 child: Container(

                 ),
                ),
               InkWell(
                 onTap: (){
                   RRouter.push(context ,Routes.shopBuyOrderPage,{"id":_shopDetailsInfo.id.toString()},transition:TransitionType.cupertino);
                 },
                 child:   Container(
                   width: setW(340),
                   height: setH(105),
                   alignment: Alignment.center,
                   decoration: BoxDecoration(

                       color: Color(0xFFFE6017),
                       borderRadius: BorderRadius.all(Radius.circular(setW(53)))

                   ),
                   child: Text("立即兑换",style: TextStyle(color: Color(0xFFFEFEFE),fontSize: setW(40)),),
                 ),

               ),
                cXM(setW(60))

              ],

            ),


          )


        ],


      )

    );
  }



  ///
  ///  商品图片
  ///
  buildImageView(BuildContext context) {


    return wrapImageUrl(_shopDetailsInfo.image,double.infinity, ScreenUtil().setHeight(800));

  }



  buildContentTitleView(BuildContext context) {

    return  Container(

      color: Colors.white,
      height: ScreenUtil().setHeight(100),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(wrapAssets("shop_line_left.png"),width: ScreenUtil().setWidth(65),),
          cXM(ScreenUtil().setWidth(15)),
          Text("详情描述",style: TextStyle(color: Colors.black38),),
          cXM(ScreenUtil().setWidth(15)),
          Image.asset(wrapAssets("shop_line_right.png"),width: ScreenUtil().setWidth(65),),

        ],

      ),

    );

  }

  buildContentView(BuildContext context) {

    var unescape = new HtmlUnescape();
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(25), ScreenUtil().setWidth(5), ScreenUtil().setWidth(25), ScreenUtil().setWidth(25)),
      color: Colors.white,
      child: Html(data: unescape.convert(_shopDetailsInfo.content)),

    );

  }
  YYDialog YYAlertDialogBody(BuildContext context) {
    return YYDialog().build(context)
      ..width = 220
      ..borderRadius = 4.0
      ..text(
        padding: EdgeInsets.all(25.0),
        alignment: Alignment.center,
        text: "确定要拨打客服电话吗?",
        color: Colors.black,
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
      )
      ..divider()
      ..doubleButton(
        padding: EdgeInsets.only(top: 10.0),
        gravity: Gravity.center,
        withDivider: true,
        text1: "取消",
        color1: Colors.black45,
        fontSize1: 14.0,
        fontWeight1: FontWeight.bold,
        onTap1: () {
        },
        text2: "确定",
        color2: Colors.orange,
        fontSize2: 14.0,
        fontWeight2: FontWeight.bold,
        onTap2: () {
          _launchPhone();
        },
      );
  }

  ///
  ///  客服弹窗
  ///
  void showServiceDialogView(BuildContext context) {






  /*  showDialog(context: context,

      builder: (_)=>Material(
        color: Colors.transparent,
        child: Container(
          alignment: Alignment.center,
          
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(setW(12)))
          ),
          margin: EdgeInsets.fromLTRB(setW(100), setW(800), setW(100), setW(950)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              cYM(setH(40)),
            new  Row(
                children: <Widget>[
                  cXM(setW(220)),
                  Icon(Icons.phone,color: Color(0xFF4AB1F2),),
                  cXM(setW(40)),
                  Column(
                    children: <Widget>[
                      buildText("拨打客服电话",size: 40),
                      cYM(setH(10)),
                      buildText("0531-62308369",size: 35)
                    ],
                  ),

                ],

              ),

            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: setH(40)),
              height: setH(150),
              child:   new  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(child: InkWell(
                    child:  Container(
                      alignment: Alignment.center,
                      child: buildText("确定"),
                    ),
                    onTap: (){
                      Navigator.pop(_);
                      // 前去拨打电话
                      _launchPhone();
                    },
                  )),
                  Expanded(child: InkWell(
                    child:  Container(
                      alignment: Alignment.center,
                      child: buildText("取消"),
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
*/
  }

  void initData() {

    NetUtils.requestGoodsInfo(widget.id)
        .then((res){

        if(res.code==200){

         setState(() {
           _shopDetailsInfo =   ShopDetailsInfo.fromJson(res.info);
         });

        }


    });


  }


}

_launchPhone() async {
  const url = 'tel:0531-62308369';

  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}