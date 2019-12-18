import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/doctor/bean/doctor_info_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DoctorHomePage extends StatefulWidget {

  final String userId;

  const DoctorHomePage({Key key, this.userId}) : super(key: key);


  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> with SingleTickerProviderStateMixin {


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
    return _doctorInfoInfo==null?Container():Scaffold(
      backgroundColor: Colors.white,
      body:  new  CustomScrollView(
        slivers: <Widget>[
          new SliverAppBar(
            title: Text("医生主页"),
            centerTitle: true,
            leading: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios,color: Colors.white,),
            ),
            pinned: true,
            expandedHeight: ScreenUtil().setHeight(800),
            bottom: TopCommonView(_tabController),
            flexibleSpace: new FlexibleSpaceBar(
                background: Container(
                  child: new Stack(
                    children: <Widget>[
                      Image.network(_doctorInfoInfo.background,width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
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
                )

            ),
          ),


          SliverList(

            delegate: new SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                //创建子widget
                return  Container(
                  height: 1000,
                  child: new TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                        buildDoctorHomeView(context),
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
                );
              },
              childCount: 1,
            ),

          ),

        ],



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

