import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:yqy_flutter/ui/drugs/drugs_company_detail_page.dart';
import 'package:yqy_flutter/utils/margin.dart';


///
///
class DepartmentHomePage extends StatefulWidget {
  @override
  _DepartmentHomePageState createState() => _DepartmentHomePageState();
}

class _DepartmentHomePageState extends State<DepartmentHomePage> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin {


  var tabTitle = [
    '科室会议',
    '项目研究',
    '知名专家',
  ];

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body:NestedScrollView(
        headerSliverBuilder: (context, bool) {
          return [
            SliverAppBar(
              title: Text("中医科专题"),
              backgroundColor: Color(0xFF1DD5E6),
              centerTitle: true,
              leading: InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Icon(Icons.arrow_back_ios,color: Colors.white,),
              ),
              expandedHeight: ScreenUtil().setHeight(635),
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
          /*    bottom: PreferredSize(child:  buildScreenView(context),
                  preferredSize:  Size.fromHeight(setH(130))),*/
              actions: <Widget>[

              ],
            ),
            new SliverPersistentHeader(
              delegate: new SliverTabBarDelegate(
                new TabBar(
                  controller: _tabController,
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

        body: getListZTView(context)


      )

    );
  }

  Container buildTopContainer(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(setW(40)),
      height: double.infinity,
      width: double.infinity,
      child:  Column(

        children: <Widget>[

          cYM(setH(200)),

          /* 顶部*/
          Container(
            child:    Row(
              children: <Widget>[

                wrapImageUrl("", setW(180), setW(180)),
                cXM(setW(43)),
                Expanded(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[


                  //  Text("中医科",style: TextStyle(color:Colors.white,fontSize: setSP(52),fontWeight: FontWeight.bold),),

                 buildText("中医科",color: "#FFFFFFFF",size: 52,fontWeight: FontWeight.bold),
                   cYM(setH(35)),
                   buildText("3 会议    4 研究项目    78 专家",color: "#FFFFFFFF",size: 37)

                  ],
                )),

                Container(
                  width: setW(120),
                  height: setH(52),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(

                    color: Color(0xFFEBF7FF),
                    borderRadius: BorderRadius.all(Radius.circular(setW(24))),

                  ),
                  child: Text("+关注",style: TextStyle(color:Color(0xFF3AA7FB),fontSize: setSP(35)),),
                )


              ],
            ),

          ),

          cYM(setH(40)),
          /*简介*/

          Text("北京协和医院呼吸内科是由我国已故著名呼吸病学专家——朱贵卿教授创建的、具有悠久历史的学科专业。作为我国最早成立的呼吸科专业科室之一，北京协和医院呼吸内科是我国一流的呼吸科学临床和研究中心及呼吸疑难病诊治中心，拥有众多的我国呼吸专业的老前辈或知名教授",
            style: TextStyle(color: Colors.white,fontSize: setSP(37)),maxLines: 4,overflow: TextOverflow.ellipsis,),

          cYM(setH(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              buildText("显示全部 >",size: 29,color: "#FFF5F5F5")


            ],

          )


        ],

      )
    );
  }

  ///
  ///  悬停布局
  ///
  buildScreenView(BuildContext context) {


    return Container(
      height: setH(130),
      color: Colors.blueAccent,
    );

  }


  ///
  ///  相关专题列表
  ///
  getListZTView(BuildContext context) {

      return ListView.builder(itemBuilder: (context,pos){

        return Container(

          padding: EdgeInsets.symmetric(horizontal: setW(76)),
          height: setH(160),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Container(
                color: Color(0xFFE3F5FF),
                margin: EdgeInsets.only(top: setH(8)),
                padding: EdgeInsets.fromLTRB(setW(4), setH(2), setW(4), setH(2)),
                child: buildText("疾病",size: 29,color: "#FF4AB1F2"),

              ),
            cXM(setW(22)),
             Expanded(child:    Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.start,
               children: <Widget>[
                  
                 buildText("心血管疾病用药",size: 43,color: "#FF000000",fontWeight: FontWeight.w500),
                 buildText("365 内容     2595 关注",size: 32,color: "#FF666666",fontWeight: FontWeight.w400),

               ],

             )),


             Container(
               alignment: Alignment.center,
               width: setW(120),
               height: setH(60),
               decoration: BoxDecoration(
                 color: Color(0xFF2CAAEE),
                 borderRadius: BorderRadius.all(Radius.circular(setW(29)))
               ),
              child: Text("+关注",style: TextStyle(color: Color(0xFFFFFFFF),fontSize: setSP(32)),),

             )




            ],

          ),


        );

      });


  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  getVideoListView(BuildContext context) {

    return ListView.builder(shrinkWrap: true,
        padding: EdgeInsets.all(setW(24)),
        itemCount: 10,
        itemBuilder: (context, pos) {
          return Container(
            margin: EdgeInsets.only(bottom: setH(30)),
            padding: EdgeInsets.all(setW(12)),
            height: setH(666),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Color(0xFFD1D1D1),
                    offset: Offset(setW(1), setH(1)),
                    blurRadius: 1.0 /*,spreadRadius:2.0*/)
              ],
            ),

            child: Column(

              children: <Widget>[

                wrapImageUrl("", double.infinity, setH(566)),

                Expanded(child: Container(
                  alignment: Alignment.center,
                  child: buildText(
                      "火针疗法在难治性皮肤病的应火针疗法在难治性皮火针...", color: "#FF181818",
                      size: 37),

                ))

              ],

            ),


          );
        });

  }




}
