import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/doctor/bean/doctor_info_entity.dart';
import 'package:yqy_flutter/ui/drugs/drugs_company_detail_page.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorHomePage extends StatefulWidget {

  final String userId;

  const DoctorHomePage({Key key, this.userId}) : super(key: key);


  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> with SingleTickerProviderStateMixin {


  var tabTitle = [
    '主页',
    '文章',
    '视频',
    '相关',
  ];

  TabController _tabController;

  DoctorInfoInfo _doctorInfoInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    loadData();
  }
  void loadData() {

    NetworkUtils.requestDoctorHome(widget.userId)
        .then((res){

      int statusCode = int.parse(res.status);
      if(statusCode==9999){
        _doctorInfoInfo = DoctorInfoInfo.fromJson(res.info);
        setState(() {

        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body:  new DefaultTabController(
          length: tabTitle.length,
          child: Scaffold(
            body: _doctorInfoInfo==null?Container():new NestedScrollView(
              headerSliverBuilder: (context, bool) {
                return [
                  SliverAppBar(
                    title: Text("医生主页"),
                    backgroundColor: Color(0xFF1DD5E6),
                    centerTitle: true,
                    leading: InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                    ),
                    expandedHeight: ScreenUtil().setHeight(650),
                    floating: true,
                    pinned: true,
                    flexibleSpace: new FlexibleSpaceBar(
                      //   title: Text("山东汉方制药有限公司"),
                        centerTitle: true,
                        background: Container(
                            height: ScreenUtil().setHeight(550),
                            child:  buildTopContainer(context)
                        )

                    ),
                  ),
                  new SliverPersistentHeader(
                    delegate: new SliverTabBarDelegate(
                      new TabBar(
                        tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                        indicatorColor: Color(0xFF1DD5E6), //指示器颜色 如果和标题栏颜色一样会白色
                        //    isScrollable: true, //是否可以滑动
                        labelColor: Color(0xFF1DD5E6) ,
                        unselectedLabelColor: Color(0xFF999999),
                        indicatorSize: TabBarIndicatorSize.label,
                        unselectedLabelStyle: TextStyle(fontSize: 16),
                        labelStyle: TextStyle(fontSize: 16),
                        indicatorPadding: EdgeInsets.only(top: 5),
                      ),
                      color: Colors.white,
                    ),
                    pinned: true,
                  ),
                ];
              },
              body: TabBarView(
                children: <Widget>[
                  //  buildDoctorHomeView(context),
                  new  Container(
                    child: ListView(
                      physics: new NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 0),
                      shrinkWrap: true,
                      children: <Widget>[
                        getRowTextView("相关学会"),
                        buildLearnView(context),
                        getRowTextView("关注专家"),
                        buildDoctorListView(context),
                        getRowTextView("热门内容"),
                        buildLiveNoticeView(new List()),
                      ],
                    ),
                    color: Colors.white,
                  ),
                  Container(
                    height: 20,
                    child: Text("暂无数据"),
                  ),
                  Container(
                    height: 20,
                    child: Text("暂无数据"),
                  ),
                  Container(
                    height: 20,
                    child: Text("暂无数据"),
                  ),

                ],
              ),
            ),
          )),

    );
  }

  Container buildTopContainer(BuildContext context) {
    return Container(
                child: new Stack(
                  children: <Widget>[
                    Image.network(_doctorInfoInfo.background,width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                    Container(width: double.infinity,height: double.infinity,decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF1DD5E6),Color(0xFF46AEF7)])
                    ),),
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: ScreenUtil().setHeight(240),
                          ),
                          Image.network(_doctorInfoInfo.userPhoto,width: 80,height: 80,fit: BoxFit.fill,),
                          cYM( ScreenUtil().setHeight(20)),
                          Text(_doctorInfoInfo.realName,style: TextStyle(color: Colors.white,fontSize: 18),),
                          cYM( ScreenUtil().setHeight(20)),
                          Text(_doctorInfoInfo.hName,style: TextStyle(color: Colors.white,fontSize: 14),),
                          cYM( ScreenUtil().setHeight(20)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("发布 454 |",style: TextStyle(color: Colors.white,fontSize: 14),),
                              Text(" 粉丝 5645",style: TextStyle(color: Colors.white,fontSize: 14),),

                            ],

                          )
                        ],


                      ),


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
                      child:  Image.asset(wrapAssets("tab/tab_live_iv11.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                      onTap: (){
                        setState(() {
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
            },

          ),

        ],


      ),

    );

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

  ///
  ///  直播预告布局
  ///
  Widget buildLiveNoticeView(List<String> list){

    list.add("1");
    list.add("1");
    list.add("1");
    return list==null?Container():ListView.builder(
        shrinkWrap: true ,
        padding: EdgeInsets.only(top: 0),
        physics: new NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context,index){
          return getLiveItemView(context,list);
        }
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


  ///
  ///  主页 选项卡
  ///
  buildDoctorHomeView(BuildContext context) {

   return     buildContentView(context);

  }



  Widget  buildContentView(BuildContext context) {

    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(200),
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
                    //  _showTipContent?_showTipContent=false:_showTipContent = true;
                    });

                  },
                ),
              )



            ],
          ),
          cYM(ScreenUtil().setHeight(20)),
          Visibility(
              visible: true,
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

}


getListItemView(int v) {
  return Container(
      height: 200,
      color: Colors.white,
  );

}

class TopCommonView extends StatefulWidget  implements PreferredSizeWidget {

  TabController _tabController;

  TopCommonView(this._tabController);

  @override
  _TopCommonViewState createState() => _TopCommonViewState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}

class _TopCommonViewState extends State<TopCommonView> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
          height: 50,
          width: double.infinity,
          color: Colors.white,
          child:  TabBar(
            controller: widget._tabController,
            tabs: [Text('主页'),Text('文章'),Text('视频'),Text('相关')],
            indicatorColor: Color(0xFF1DD5E6), //指示器颜色 如果和标题栏颜色一样会白色
        //    isScrollable: true, //是否可以滑动
            labelColor: Color(0xFF1DD5E6) ,
            unselectedLabelColor: Color(0xFF999999),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: TextStyle(fontSize: 16),
            labelStyle: TextStyle(fontSize: 16),
            indicatorPadding: EdgeInsets.only(top: 5),
          ),
    );
  }
}

