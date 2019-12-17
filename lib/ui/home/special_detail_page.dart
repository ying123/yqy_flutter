import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';

class SpecialDetailPage extends StatefulWidget {
  @override
  _SpecialDetailPageState createState() => _SpecialDetailPageState();
}

class _SpecialDetailPageState extends State<SpecialDetailPage> {

  int viewTypeMy = 0;// 当前的排列方式  我的预约排列   0 gridview  1  listview

  bool _showTipContent  = false;// 是否显示简介

  ScrollController _scrollController =  new ScrollController(); // 解决嵌套滑动冲突  设置统一滑动

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text("专题详情",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading:InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child:  Icon(Icons.arrow_back_ios,color: Colors.black38,),
        )
      ),

      body: ListView(
        controller: _scrollController,
        children: <Widget>[
         buildBannerView(context),
         buildContentView(context),
         buildLineView(),
         getRowTextView("视频"),
         buildLiveNoticeView(new List(),viewTypeMy),
         buildLineView(),
         getRowTextView("文章"),
         buildNewsListView(),
         buildLineView(),
         getRowTextView("相关专家"),
         buildDoctorListView(context),
         buildLineView(),
         getRowTextView("相关学会"),
         buildLearnView(context),
         buildLineView(),
         getRowTextView("产品推荐"),
         buildProductPublicityView(context)
        ],
      ) ,


    );
  }

  buildBannerView(BuildContext context) {

    return   Container(

      height: ScreenUtil().setHeight(403),
      child: Image.asset(wrapAssets("tab/tab_live_banner.png"),fit: BoxFit.fill,),

    );



  }

 Widget  buildContentView(BuildContext context) {

    return  new Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("肿瘤科医学专题",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w500),),
                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(120),
                  height: ScreenUtil().setHeight(50),
                  decoration: BoxDecoration(
                      color: Color(0xFF4AB1F2),
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20)))
                  ),
                  child: Text("关注",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(34)),),
                )
              ],
            ),
            cYM(ScreenUtil().setHeight(20)),
            new  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("6段视频    4篇文章    225人关注",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),),

                Material(

                  color: Colors.white30,
                  child: InkWell(
                    onTap: (){

                      setState(() {
                        _showTipContent?_showTipContent=false:_showTipContent = true;
                      });

                    },
                    child:   Container(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                      alignment: Alignment.center,
                      child: Text(_showTipContent?"简介":"简介 >",style: TextStyle(color: Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(35)),),
                    ) ,
                  ),
                )



              ],
            ),
            cYM(ScreenUtil().setHeight(20)),
           Visibility(
             visible: _showTipContent,
               child:   new  Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: <Widget>[
                   Text("6段视频    4篇文章    225人关注",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),),
                 ],
               )
           )

          ],
        ),

    );

  }

  Widget getRowTextView(String type){

    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(55),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(42), 0, ScreenUtil().setWidth(42), 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(type,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w800),),
          new GestureDetector(
            child: Container(
              child: Row(
                children: <Widget>[

                  Visibility(
                      child:    new  InkWell(
                        child:  Image.asset(wrapAssets(viewTypeMy==0?"tab/tab_live_iv1.png":"tab/tab_live_iv11.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                        onTap: (){
                          setState(() {
                            viewTypeMy==0?viewTypeMy=1:viewTypeMy=0;
                          });

                        },
                      ),
                      visible: type=="视频"?true:false,

                  ),

                  cXM(ScreenUtil().setWidth(60)),

                  Visibility(
                    visible: type.contains("相关")||type.contains("产品")?false:true,
                      child: Row(
                        children: <Widget>[
                          Text("更多"+type,style: TextStyle(color:Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
                          Icon(Icons.arrow_forward_ios,color: Colors.black12,size: ScreenUtil().setWidth(35),),
                        ],
                      )
                  )

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


  Widget buildNewsListView() {

    return  ListView.builder(
        controller: _scrollController,
        shrinkWrap: true ,
        physics: new NeverScrollableScrollPhysics(),
        itemCount:4,
        itemBuilder: (context,index) {

          return  getNewsItemView(context,null);

        }

    );

  }

  ///
  ///  资讯布局
  ///
  Widget getNewsItemView(BuildContext context,List xlist) {


    return GestureDetector(

      onTap: (){
        // RRouter.push(context, Routes.newsContentPage, {"id":xlist.id});
      },
      child: new Container(

          color: Colors.white,

          height: 90,

          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Expanded(
                  child:   new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      new   Container(
                          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(40), 0),
                        //  width: ScreenUtil().setWidth(900),
                          child:   Text("哪些范畴已扎堆？细数国际“高程度反复”...哪些范畴已扎堆？细数国际“高程度反复”...",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w500),)
                      ),

                      cYM(ScreenUtil().setHeight(20)),

                      new  Container(

                        width: ScreenUtil().setWidth(600),

                        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0,0, 0),

                        child:  new  Row(

                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: <Widget>[

                            Text("2019-11-12  09:60:37",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),

                            Text("2690次阅读",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),

                          ],


                        ),
                      ),


                      Divider(height: 1,color:Color(0xFFEEEEEE),)



                    ],


                  ),
              ),

          //    Image.asset(wrapAssets("home/bg_doctor.png"),width: ScreenUtil().setWidth(202),height: ScreenUtil().setHeight(144),)
            ],
          )
      ),
    );



  }


  ///
  ///  横向滑动专家列表
  ///
 Widget buildDoctorListView(BuildContext context) {

    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(30), 0, ScreenUtil().setHeight(30)),
      height: ScreenUtil().setHeight(300),
      child: ListView.builder(
           scrollDirection:Axis.horizontal,
            itemCount: 8,
            itemBuilder: (context,index){

              return buildItemDoctorView();
            }
      ),



    );


  }

  Widget buildItemDoctorView() {

    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
      width: ScreenUtil().setWidth(200),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          
          Image.asset(wrapAssets("tab/tab_me_sele.png"),width: ScreenUtil().setWidth(200),height: ScreenUtil().setHeight(200),fit: BoxFit.fill,),
          Text("李英爱",style: TextStyle(fontWeight: FontWeight.w600,fontSize: ScreenUtil().setSp(35)),),
          Text("中医大师",style: TextStyle(fontSize: ScreenUtil().setSp(30)),)
          
          
        ],
        


      ),

    );

  }

 Widget buildLineView() {
    return    Container(color: Color(0xfff5f5f5),height: ScreenUtil().setHeight(20),);

  }

  ///
  ///  相关学会布局
  ///
 Widget buildLearnView(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
      child: Column(
        children: <Widget>[

          Container(
            height: ScreenUtil().setHeight(100),
            child: Row(

              children: <Widget>[
                cXM(ScreenUtil().setWidth(10)),
                Image.asset(wrapAssets("tab/tab_doc.png"),width: ScreenUtil().setWidth(90),height: ScreenUtil().setHeight(90),),
                cXM(ScreenUtil().setWidth(30)),
                Text("中华医学会",style: TextStyle(),)
              ],
            ),
            
          )



        ],
      ),



    );


  }
  ///
  ///   产品推荐布局
  ///
 Widget buildProductPublicityView(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(45)),
      child: Row(

        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Image.asset(wrapAssets("tab/tab_doc_sele.png"),width: ScreenUtil().setWidth(230),height: ScreenUtil().setHeight(259),fit: BoxFit.fill,),
              cYM(ScreenUtil().setHeight(42)),
              Text("复方黄柏液涂剂",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35)),)

            ],
          )



        ],
      ),

    );

  }
}
