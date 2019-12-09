import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabLivePage extends StatefulWidget {
  @override
  _TabLivePageState createState() => _TabLivePageState();
}

class _TabLivePageState extends State<TabLivePage> {

  int viewTypeMy = 0;// 当前的排列方式  我的预约排列   0 gridview  1  listview
  int viewTypeLive = 0;// 当前的排列方式  直播预告排列   0 gridview  1  listview
  @override
  Widget build(BuildContext context) {
    return  Scaffold(


      backgroundColor: Colors.white,
      body: ListView(

        children: <Widget>[
          cYM(ScreenUtil().setHeight(22)),
          buildBanner(context),
          cYM(ScreenUtil().setHeight(80)),
          getRowTextView("我的预约"),
          buildLiveNoticeView(new List(),viewTypeMy),
          getRowTextView2("直播预告"),
          buildLiveNoticeView(new List(),viewTypeLive),
        ],

      ),
    );
  }

 Widget buildBanner(BuildContext context) {

    return Image.asset(wrapAssets("tab/tab_live_banner.png"),width: double.infinity,height: ScreenUtil().setHeight(403),fit: BoxFit.fill,);


  }


  Widget getRowTextView(String type){

    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(55),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(42), 0, ScreenUtil().setWidth(42), 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(type,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w800),),
          new GestureDetector(
            child: Container(
              child: Row(
                children: <Widget>[
                  InkWell(
                    child:  Image.asset(wrapAssets(viewTypeMy==0?"tab/tab_live_iv1.png":"tab/tab_live_iv11.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                    onTap: (){
                      setState(() {
                        viewTypeMy==0?viewTypeMy=1:viewTypeMy=0;
                      });

                    },
                  ),

                  cXM(ScreenUtil().setWidth(63)),
                  Text("更多预约",style: TextStyle(color:Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
                  Icon(Icons.arrow_forward_ios,color: Colors.black12,size: ScreenUtil().setWidth(35),),
                ],

              ),
            ),
            onTap: (){
              type=="热门视频"?RRouter.push(context, Routes.liveMeeting,{"title":"11"}):
              RRouter.push(context, Routes.videoListPage,{});
            },

          ),

        ],


      ),

    );

  }

  ///
  ///  直播预告布局
  ///
  Widget buildLiveNoticeView(List<String> list,int viewType){

    list.add("1");
    list.add("1");
    list.add("1");
    return list==null?Container():viewType==0?GridView.count(
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(10),
      //GridView内边距
      padding: EdgeInsets.all(ScreenUtil().setWidth(29)),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: list.getRange(0,2).map((item) => itemVideoView(item)).toList(),
    ): ListView.builder(
        shrinkWrap: true ,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context,index){
          return getLiveItemView(context,list);
        }
        );
  }
  ///
  ///  热门视频 item
  ///
  Widget itemVideoView(String list) {


    return  InkWell(
      onTap: (){

      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(501),height: ScreenUtil().setHeight(288),fit: BoxFit.fill,),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text("湖南湘中医联盟肛肠疾病高峰学术论坛",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("2019-09-20",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                ],
              ),
            )

          ],
        ),

      ),
    );


  }


  ///
  ///  直播预告提示
  ///
  getRowTextView2(String s) {


    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(55),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(42), 0, ScreenUtil().setWidth(42), 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(s,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w800),),
          new GestureDetector(
            child: Image.asset(wrapAssets(viewTypeLive==0?"tab/tab_live_iv1.png":"tab/tab_live_iv11.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
            onTap: (){
              setState(() {
                viewTypeLive==0?viewTypeLive=1:viewTypeLive=0;
              });
            },

          ),

        ],


      ),

    );

  }

  ///
  ///   列表item
  ///
  Widget getLiveItemView(context,List listBean){

    return  GestureDetector(

      onTap: (){
      //  RRouter.push(context, Routes.videoDetailsPage,{"reviewId":listBean.id});
      },

      child: new Container(
        height: ScreenUtil().setHeight(250),
        padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(27), ScreenUtil().setHeight(27), 0,  ScreenUtil().setHeight(40)),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            // Icon(Icons.apps,size: 110,color: Colors.blueAccent,),
            //  wrapImageUrl(listBean.image,110.0, 110.0),
            Image.asset(wrapAssets("tab/tab_live_img.png"),fit: BoxFit.fill,height: ScreenUtil().setHeight(215),width:ScreenUtil().setWidth(288)),
            //  new Image(image: new CachedNetworkImageProvider("http://via.placeholder.com/350x150"),width: 110,height: 110,color: Colors.black,),
            cXM(ScreenUtil().setHeight(20)),
            new Container(
                width: ScreenUtil().setWidth(720),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("湖南湘中医联盟肛肠疾病高峰论坛学术交流会",style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(37)),maxLines: 2,overflow: TextOverflow.ellipsis,),

                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Image.asset(wrapAssets("tab/tab_live_ic2.png"),width: ScreenUtil().setSp(32),height: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text("张素娟  李霞  将建成  张大大  王素娥",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
                          ],

                        ),

                        //       Text("看录播",style: TextStyle(color: Colors.greenAccent),)

                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Icon(Icons.access_time,size: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text("2019-12-01  03:33:00",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
                          ],

                        ),

                        //       Text("看录播",style: TextStyle(color: Colors.greenAccent),)

                      ],
                    ),

                  ],

                )

            )


          ],


        ),

      ),


    );

  }

}
