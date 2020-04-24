import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/banner_router.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_special_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';

class TabSpecialPage extends StatefulWidget {
  @override
  _TabSpecialPageState createState() => _TabSpecialPageState();
}

class _TabSpecialPageState extends State<TabSpecialPage> with AutomaticKeepAliveClientMixin {


  Info _tabSpecialInfo;

  List<String> bgImageList =  ["bg_special.png","bg_special2.png","bg_special3.png","bg_special4.png"];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initData();

  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(

      backgroundColor: Colors.white,
      body: _tabSpecialInfo==null?Container():ListView.builder(
        shrinkWrap: true,
        itemCount: _tabSpecialInfo.typeList.length+1,
        itemBuilder: (context,index){

         return  index==0? buildBanner(context): _tabSpecialInfo.typeList[index-1].lists.length==0?Container():buildItemView(_tabSpecialInfo.typeList[index-1]);

        },
      ),

    );
  }

  buildBanner(BuildContext context) {

    return Container(
        height: setH(403),
        width: double.infinity,
        child:new Swiper(
          itemBuilder: (BuildContext context,int index){
            return new Image.network(_tabSpecialInfo.bannerList[index].img,fit: BoxFit.fill,);
          },
          itemCount: _tabSpecialInfo.bannerList.length,
          autoplay: true,
          autoplayDelay: 5000,
          layout: SwiperLayout.DEFAULT,
          onTap: (index){
            BannerRouter.push(context,300, _tabSpecialInfo.bannerList[index].artId);
          },
        )
    );
    
    
  }

  buildItemView(TypeList typeList) {

    return  Padding(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(26), ScreenUtil().setHeight(50), ScreenUtil().setWidth(26),  ScreenUtil().setHeight(30)),
      child: Column(

        children: <Widget>[
          Container(
            height: ScreenUtil().setHeight(95),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[

                Image.asset(wrapAssets(bgImageList[Random().nextInt(bgImageList.length)]),width: double.infinity,height:setH(95),fit: BoxFit.fill,),
                Text(typeList.title,style: TextStyle(fontSize: setSP(50),color: Colors.white,fontWeight: FontWeight.bold),)

              ],

            ),
          ),

          Column(

            children:  typeList.lists.map((e)=>getLiveItemView(e)).toList()
          )


        ],

      ),
    );


  }

    Widget getLiveItemView(Lists bean){

      return  GestureDetector(

        onTap: (){
          RRouter.push(context ,Routes.specialDetailPage,{"id":bean.id});
        },

        child: new Container(
          margin: EdgeInsets.only(top: setH(20)),
          height: ScreenUtil().setHeight(250),
          width: double.infinity,
          color: Colors.white,
          child: Row(
            children: <Widget>[
              wrapImageUrl(bean.image, ScreenUtil().setWidth(500),  ScreenUtil().setHeight(250)),
              cXM(ScreenUtil().setHeight(40)),
              new Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(bean.title,style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(40)),maxLines: 2,overflow: TextOverflow.ellipsis,),

                      ),
                      Container(
                        child:   Text(bean.descs==null?"":bean.descs.toString(),style: TextStyle(color: Color(0xFF7E7E7E),fontSize:  ScreenUtil().setSp(32)),maxLines: 2,overflow: TextOverflow.ellipsis,),
                      )

                    ],

                  )

              )


            ],


          ),

        ),


      );

    }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void initData() {

    NetUtils.requestSpecialIndex()
        .then((res){

       if(res.code==200){


         setState(() {
            _tabSpecialInfo  =    Info.fromJson(res.info);


         });


       }



    });

  }
}
