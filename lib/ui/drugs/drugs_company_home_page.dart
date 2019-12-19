import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';

class DrugsCompanyHomePage extends StatefulWidget {
  @override
  _DrugsState createState() => _DrugsState();
}

class _DrugsState extends State<DrugsCompanyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(

          title: Text("药品企业"),
          centerTitle: true,

      ),

      body: ListView(

        children: <Widget>[
          buildBanner(context),
          cYM(ScreenUtil().setHeight(60)),
          //热门产品
          buildHotView(context),
          cYM(ScreenUtil().setHeight(60)),
          //公司广告
          buildNotice(context),
          cYM(ScreenUtil().setHeight(55)),
          buildAdView(context),
          buildTip(context),
          buildRecommendView(context)


        ],
      ),




    );
  }

  buildBanner(BuildContext context) {


    return Container(
      height: ScreenUtil().setHeight(550),
      width: double.infinity,
      child: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.asset(
            wrapAssets("tab/tab_live_img.png"),
            fit: BoxFit.fill,
          );
        },
        itemCount: 10,
        viewportFraction: 0.8,
        scale: 0.9,
        autoplay: true,
        autoplayDelay: 8000,
      ),
    );

  }

  buildHotView(BuildContext context) {

    return Container(
      padding:  EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
      child: Stack(
      alignment: Alignment.topCenter,
        children: <Widget>[
              Positioned(
                  child: Container(
                    margin: EdgeInsets.only(top: ScreenUtil().setHeight(80)),
                      width: double.infinity,
                      height: ScreenUtil().setHeight(521),
                      decoration: BoxDecoration(

                        gradient: const LinearGradient(
                            colors: [Color(0xFFF2AC61), Color(0xFFF9894B)]),
                      ),

                   )
              ),
              Image.asset(wrapAssets("drugs/top_bg.png"),width: ScreenUtil().setWidth(723),height: ScreenUtil().setHeight(150),fit: BoxFit.fill,),
              Positioned(
                bottom: ScreenUtil().setHeight(29),
                child: Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
                child: Row(
                  children: <Widget>[
                    // item
                    new Container(
                      width: ScreenUtil().setWidth(297),
                      height: ScreenUtil().setHeight(374),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(14)))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset(wrapAssets("drugs/drugs.png"),
                            width: ScreenUtil().setWidth(230),
                            height: ScreenUtil().setHeight(240),
                            fit: BoxFit.fill,),
                          Text("复方黄柏液涂剂", style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: ScreenUtil().setSp(35)),)
                        ],
                      ),
                    ),
                    cXM(ScreenUtil().setWidth(30)),
                    new Container(
                      width: ScreenUtil().setWidth(297),
                      height: ScreenUtil().setHeight(374),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(14)))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset(wrapAssets("drugs/drugs.png"),
                            width: ScreenUtil().setWidth(230),
                            height: ScreenUtil().setHeight(240),
                            fit: BoxFit.fill,),
                          Text("复方黄柏液涂剂", style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: ScreenUtil().setSp(35)),)
                        ],
                      ),
                    ),
                    cXM(ScreenUtil().setWidth(30)),
                    new Container(
                      width: ScreenUtil().setWidth(297),
                      height: ScreenUtil().setHeight(374),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(ScreenUtil().setWidth(14)))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Image.asset(wrapAssets("drugs/drugs.png"),
                            width: ScreenUtil().setWidth(230),
                            height: ScreenUtil().setHeight(240),
                            fit: BoxFit.fill,),
                          Text("复方黄柏液涂剂", style: TextStyle(
                              color: Color(0xFF333333),
                              fontSize: ScreenUtil().setSp(35)),)
                        ],
                      ),
                    )


                  ],
                ),
              ))

        ],
      ),
    );

  }

  buildNotice(BuildContext context) {

    return Container(
      padding: EdgeInsets.fromLTRB(
          ScreenUtil().setWidth(29), 0, ScreenUtil().setWidth(29), 0),
        child: Row(

          children: <Widget>[

            new Container(
              width: ScreenUtil().setWidth(501),
              decoration: BoxDecoration(
                  color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset(wrapAssets("drugs/notice.png"),
                    width: ScreenUtil().setWidth(501),
                    height: ScreenUtil().setHeight(288),
                    fit: BoxFit.fill,),
                  Text("制药公司", style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: ScreenUtil().setSp(37)),)
                ],
              ),
            ),
            cXM(ScreenUtil().setWidth(19)),
            new Container(
              width: ScreenUtil().setWidth(501),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image.asset(wrapAssets("drugs/notice.png"),
                    width: ScreenUtil().setWidth(501),
                    height: ScreenUtil().setHeight(288),
                    fit: BoxFit.fill,),
                  Text("制药公司", style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: ScreenUtil().setSp(37)),)
                ],
              ),
            )
          ],
        ),
    );

  }

  buildAdView(BuildContext context) {

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: ScreenUtil().setHeight(173),
      child: Image.asset(wrapAssets("ad_bg.png"),width: ScreenUtil().setWidth(1022),height: ScreenUtil().setHeight(173),fit: BoxFit.fill,),

    );

  }

  buildTip(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(27)),
      height: ScreenUtil().setHeight(100),
      child: Text("推荐产品",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(39)),),
    );

  }

  buildRecommendView(BuildContext context) {
    return Container(

      child: GridView.count(

        shrinkWrap: true ,
        physics: new NeverScrollableScrollPhysics(),
        //水平子Widget之间间距
        crossAxisSpacing: ScreenUtil().setWidth(20),
        //垂直子Widget之间间距
        mainAxisSpacing: ScreenUtil().setHeight(10),
        //GridView内边距
        padding: EdgeInsets.all(ScreenUtil().setWidth(29)),
        //一行的Widget数量
        crossAxisCount: 3,
        //子Widget宽高比例
          childAspectRatio: 0.8,
        //子Widget列表
        children:[
          new Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(wrapAssets("drugs/drugs.png"),
                  width: ScreenUtil().setWidth(288),
                //  height: ScreenUtil().setHeight(288),
                  fit: BoxFit.fill,),
                Text("制药公司", style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: ScreenUtil().setSp(37)),)
              ],
            ),
          ),
          new Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(wrapAssets("drugs/drugs.png"),
                  width: ScreenUtil().setWidth(288),
                  //  height: ScreenUtil().setHeight(288),
                  fit: BoxFit.fill,),
                Text("制药公司", style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: ScreenUtil().setSp(37)),)
              ],
            ),
          ),
          new Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(wrapAssets("drugs/drugs.png"),
                  width: ScreenUtil().setWidth(288),
                  //  height: ScreenUtil().setHeight(288),
                  fit: BoxFit.fill,),
                Text("制药公司", style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: ScreenUtil().setSp(37)),)
              ],
            ),
          ),
          new Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Image.asset(wrapAssets("drugs/drugs.png"),
                  width: ScreenUtil().setWidth(288),
                  //  height: ScreenUtil().setHeight(288),
                  fit: BoxFit.fill,),
                Text("制药公司", style: TextStyle(
                    color: Color(0xFF333333),
                    fontSize: ScreenUtil().setSp(37)),)
              ],
            ),
          ),
        ]


      ),
    );

  }
}

