import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';

class DoctorHomePage extends StatefulWidget {
  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage>  with TickerProviderStateMixin {

  TabController _tabController;
  GlobalKey _globalKey = new GlobalKey();

  bool showDrawerType1 = true; // 筛选抽屉菜单是否展开  默认展开
  bool showDrawerType2 = true;
  bool showDrawerType3 = true;


  String seleV1,seleV2,seleV3;// 当前选中的  科室  地区  学会

  int viewType = 0;// 当前的排列方式  我的预约排列   0 gridview  1  listvie

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);


  }

  @override
  Widget build(BuildContext context) {

    //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      endDrawer: buildDrawer(context),
      body: ListView(
        padding: EdgeInsets.all(0),
       children: <Widget>[
        Container(height: ScreenUtil().setHeight(80),color: Colors.white,),
         buildBanner(context),
         cYM(ScreenUtil().setHeight(30)),
         buildBannerTitle(context),
         cYM(ScreenUtil().setHeight(58)),
         // 横向推荐视频
         buildRowRecommendView(context),
         cYM(ScreenUtil().setHeight(20)),
         buildAdView(context),
         cYM(ScreenUtil().setHeight(40)),
         buildScreenView(context),
         buildListView(new List())

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

  buildBannerTitle(BuildContext context) {
    
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      child: Text("王金义：杂交法经食管切除术",style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(40)),),
      
    );

  }

  buildRowRecommendView(BuildContext context) {

    return  Row(

      children: <Widget>[
      cXM(ScreenUtil().setWidth(30)),
      new  Expanded(
          child:  Container(
            height: ScreenUtil().setHeight(410),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(501),height: ScreenUtil().setHeight(288),fit: BoxFit.fill,),
                Padding(padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), 0, ScreenUtil().setWidth(14), 0),child:   Text("这种疫苗怎么打？要不要打？",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                Padding(padding:  EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), 0, ScreenUtil().setWidth(14), 0),child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("2019-09-21",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                    Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  ],
                ),)


              ],

            ),
          )),
      cXM(ScreenUtil().setWidth(20)),
      new  Expanded(
          child:  Container(
            height: ScreenUtil().setHeight(410),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(501),height: ScreenUtil().setHeight(288),fit: BoxFit.fill,),
                Padding(padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), 0, ScreenUtil().setWidth(14), 0),child:   Text("这种疫苗怎么打？要不要打？",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),),
                Padding(padding:  EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), 0, ScreenUtil().setWidth(14), 0),child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("2019-09-21",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                    Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  ],
                ),)


              ],

            ),
          )),
      cXM(ScreenUtil().setWidth(30))
      ],
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

  Widget buildScreenView(BuildContext context) {

    return Container(
      margin: EdgeInsets.fromLTRB(0, 0, ScreenUtil().setWidth(29), 0),
      //  height: ScreenUtil().setHeight(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(child:  TabBar(
            controller: _tabController,
            tabs: [Text("为你推荐",textAlign: TextAlign.center,),Text("按时间"),Text("按热度")],
            indicatorColor: Colors.white, //指示器颜色 如果和标题栏颜色一样会白色
            isScrollable: true, //是否可以滑动
            labelColor:Color(0xFF2CAAEE) ,
            unselectedLabelColor:Color(0xFF7E7E7E),
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(40)),
            labelStyle: TextStyle(fontSize: ScreenUtil().setSp(40)),
            //  indicatorPadding: EdgeInsets.only(top: 5),
          ),),
          Container(
            width: ScreenUtil().setWidth(80),
            child:   FlatButton(
              onPressed: (){
                setState(() {
                  viewType==0?viewType=1:viewType=0;
                });
              },
              padding: EdgeInsets.all(0),
              child: Image.asset(wrapAssets(viewType==0?"tab/tab_live_iv1.png":"tab/tab_live_iv11.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setHeight(40),),
            ),

          ),
          cXM(ScreenUtil().setWidth(40)),

          Builder(builder: (context1){
            return
              InkWell(
                  onTap: (){
                    Scaffold.of(context1).openEndDrawer();
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child:  Row(
                      children: <Widget>[
                        Image.asset(wrapAssets("tab/tab_screen.png"),width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),),
                        cXM(ScreenUtil().setWidth(6)),
                        Text("筛选",style:TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)))
                      ],


                    ),
                  )

              );

          })


        ],

      ),
    );

  }



  Widget buildListView(List  list){

    list.add("");
    list.add("");
    list.add("");
    list.add("");
    list.add("");
    list.add("");
    return list==null?Container():viewType==0? GridView.count(
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(5),
      //GridView内边距
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), 0, ScreenUtil().setWidth(20), ScreenUtil().setWidth(20)),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: list.map((item) => buildItemView(item)).toList(),
    ): ListView.builder(
        shrinkWrap: true ,
        padding: EdgeInsets.all(0),
        physics: new NeverScrollableScrollPhysics(),
        // physics: new NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context,index){
          return getLiveItemView(context,list);
        }
    );
  }

  Widget buildItemView(String string) {


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
            wrapImageUrl("http:\/\/cdn2.yaoqiyuan.com\/upload\/adspic\/2019-12\/5dea039ac27a0.JPG", ScreenUtil().setWidth(501), ScreenUtil().setHeight(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text("中西医结合联合微创技术治疗普通外科疾病进展学习班暨安徽省中医药学会外科专业委员会2019年学术年会",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
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

  buildDrawer(BuildContext context) {

    List<String> list1 = ["麻醉科","妇产科","皮肤病科","骨科","外科","内科","男科","儿科","传染病科","五官科","肿瘤科","中医科","医学影像科","康复医学科","精神心理科","营养科","其他科室"];
    List<String> list2 = ["北京","上海","广东","天津","山东","安徽","河北""河南","黑龙江","江苏","浙江","山西","四川","陕西","内蒙古"];
    List<String> list3 = ["学会1","学会2","学会3","学会4","学会5","学会6","学会7","学会8","学会11","学会12","学会13","学会14","学会15","学会16"];

    return Container(
        color: Colors.white,
        width: ScreenUtil().setWidth(825),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[

            ListView(
              children: <Widget>[
                buildItemDrawerView(list1,"科室",showDrawerType1),
                buildItemDrawerView(list2,"地区",showDrawerType2),
                buildItemDrawerView(list3,"学会",showDrawerType3),
                cYM(ScreenUtil().setHeight(240))
              ],
            ),

            new Container(
              height: ScreenUtil().setHeight(200),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){

                        setState(() {
                          seleV1 = "";
                          seleV2 = "";
                          seleV3 = "";
                        });


                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFFFBFBFB),
                            border: Border.all(color: Color(0xFFEEEEEE),width: ScreenUtil().setWidth(1)),
                            borderRadius:BorderRadius.only(bottomLeft: Radius.circular(ScreenUtil().setWidth(29),),topLeft: Radius.circular(ScreenUtil().setWidth(29)))
                        ),
                        alignment: Alignment.center,
                        width: ScreenUtil().setWidth(346),
                        height: ScreenUtil().setHeight(115),
                        child: Text("重置",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37)),),
                      )
                  ),
                  FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){

                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(0xFF2CAAEE),
                            border: Border.all(color: Color(0xFF2CAAEE),width: ScreenUtil().setWidth(1)),
                            borderRadius:BorderRadius.only(bottomRight: Radius.circular(ScreenUtil().setWidth(29),),topRight: Radius.circular(ScreenUtil().setWidth(29)))
                        ),
                        alignment: Alignment.center,
                        width: ScreenUtil().setWidth(346),
                        height: ScreenUtil().setHeight(115),
                        child: Text("确定",style: TextStyle(color: Color(0xFFFFFFFF),fontSize: ScreenUtil().setSp(37)),),
                      )

                  )


                ],
              ),
            )


          ],


        )
    );

  }

  buildItemDrawerView(List<String> list,String type,bool show) {

    return Column(

      children: <Widget>[

        new Container(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29), ScreenUtil().setWidth(39), ScreenUtil().setWidth(40), 0),
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Text(type,style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),

              Material(

                color: Colors.white,
                child:  InkWell(

                  onTap: (){

                    switch(type){

                      case"科室":
                        show?showDrawerType1=false:showDrawerType1=true;
                        break;
                      case"地区":
                        show?showDrawerType2=false:showDrawerType2=true;
                        break;
                      case"学会":
                        show?showDrawerType3=false:showDrawerType3=true;
                        break;
                    }

                    setState(() {

                    });

                  },
                  child: Padding(padding: EdgeInsets.all(10),
                    child:  Icon( show?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down,color: Color(0xFF7E7E7E),size: ScreenUtil().setSp(50),),
                  ),
                ),
              ),


            ],


          ),
        ),

        Visibility(
            visible: show,
            child: GridView.count(
              shrinkWrap: true,
              physics: new NeverScrollableScrollPhysics(),
              //水平子Widget之间间距
              crossAxisSpacing: 10.0,
              //垂直子Widget之间间距
              mainAxisSpacing: ScreenUtil().setHeight(14),
              //GridView内边距
              padding: EdgeInsets.all(10.0),
              //一行的Widget数量
              crossAxisCount: 3,
              //子Widget宽高比例
              childAspectRatio: 2.2,
              //子Widget列表
              children:  list.map((item) => buildGridItemView(item,type)).toList(),
            )
        )

      ],

    );


  }

  Widget buildGridItemView(String value,String type) {

    return InkWell(
      onTap: (){

        switch(type){

          case"科室":
            seleV1 = value;
            break;
          case"地区":
            seleV2 = value;
            break;
          case"学会":
            seleV3 = value;
            break;
        }

        setState(() {

        });

      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius:  BorderRadius.all(Radius.circular(ScreenUtil().setWidth(29))),
            color: Color(seleV1==value||seleV2==value||seleV3==value?0xFFE3F5FF:0xFFF5F5F5)
        ),
        child: Text(value,style: TextStyle(color: Color(seleV1==value||seleV2==value||seleV3==value?0xFF2CAAEE:0xFF333333),fontSize: ScreenUtil().setSp(32)),),

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
        padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(27), 0, 0,  ScreenUtil().setHeight(40)),
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