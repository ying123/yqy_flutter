import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/bean/news_list_entity.dart';
import 'package:yqy_flutter/ui/home/search/bean/search_home_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';


class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}






class SearchHomePage extends StatefulWidget {
  @override
  _SearchHomePageState createState() => _SearchHomePageState();
}

class _SearchHomePageState extends State<SearchHomePage> with SingleTickerProviderStateMixin {

  String  key;
   List<Widget> tabBarList   = new List();
   List<Widget> tabBarViewList   = new List();

  SearchHomeInfo _searchHomeInfo;

  List<_TabData> _tabDataList = new List();

  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:  buildAppbarView(),
        elevation: 0,
        actions: <Widget>[
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text("取消",style: TextStyle(color: Colors.black38),),
            )
          ),
          cXM(ScreenUtil().setWidth(25))
        ],
      ),

      body: _searchHomeInfo==null?Container(): Column(
        children: <Widget>[

          TabBar(
            controller: _tabController,
            tabs:tabBarList,
            indicatorColor: Color(0xFF17E2BD), //指示器颜色 如果和标题栏颜色一样会白色
            isScrollable: true, //是否可以滑动
            labelColor: Color(0xFF17E2BD) ,
            unselectedLabelColor: Color(0xFF7E7E7E),
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(46)), //防止字体抖动 不用此方法
            labelStyle: TextStyle(fontSize: ScreenUtil().setSp(46)),  //防止字体抖动 不用此方法
          ),
          cYM(setH(40)),
          Expanded(
              child: TabBarView(
                controller: _tabController,
                children: tabBarViewList,
              ),
          ),

        ],
      ),

    /*  body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          cYM(ScreenUtil().setHeight(40)),
          buildTitleView("搜索历史"),
          buildHosListView(context),
          cYM(ScreenUtil().setHeight(40)),
          buildTitleView("热门搜索"),
          buildHosListView(context),

        ],
      )*/


    );
  }



  Widget  buildAppbarView() {

    return  InkWell(

      onTap: (){
       // RRouter.push(context, Routes.searchHomePage,{});
      },
      child: Container(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
        alignment: Alignment.centerLeft,
        height: ScreenUtil().setHeight(90),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(22))),
          color: Color(0xfff5f5f5),
        ),
        child: Row(
          children: <Widget>[
            Icon(Icons.search,size: ScreenUtil().setWidth(70),color: Colors.black38,),
            Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: TextFormField(
                    autofocus: true,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(fontSize: ScreenUtil().setSp(42)),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                        hintText: "请输入您想要搜索的内容",
                        hintStyle: TextStyle(color: Colors.black38,fontSize: ScreenUtil().setSp(40)),
                        border: InputBorder.none,
                    ),
                    onChanged: (v){
                      key = v;
                    },
                    onEditingComplete: (){
                    //  eventBus.fire(EventBusChange(key));


                      if(key.isNotEmpty){
                        initData();

                      }else{
                        FLToast.error(text: "搜索内容不能为空");

                      }

                    },
                  ),

                )

            )

          ],
        )


      ),
    );

  }



  buildTitleView(String v) {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(27), 0, 0, 0),
      child: Text(v,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.bold),),
    );
  }


  ///
  ///  历史搜索页面
  ///
  buildHosListView(BuildContext context) {

    return GridView.count(
      shrinkWrap: true,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing:  ScreenUtil().setHeight(17),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(14),
      //GridView内边距
      padding: EdgeInsets.all(10.0),
      //一行的Widget数量
      crossAxisCount: 4,
      //子Widget宽高比例
      childAspectRatio: 2.2,
      //子Widget列表
      children: [
        itemListView(),
        itemListView(),
        itemListView(),
        itemListView(),
        itemListView(),
        itemListView(),
        itemListView()
        
      ]
    );
  }

  itemListView() {

    return Container(
      width: ScreenUtil().setWidth(173),
      height: ScreenUtil().setHeight(81),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(40))),
        color: Color(0xFFF6F6F6)
      ),
      child: Text("中医",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(32)),),

    );

  }

  void initData() {

    NetUtils.requestSearchIndex(key)
        .then((res){

          setState(() {

            _searchHomeInfo =    SearchHomeInfo.fromJson(res.info);
            _tabDataList = <_TabData>[
              _TabData(tab: Text('相关视频'), body:  _searchHomeInfo==null?Container(): VideoMeetingPage(_searchHomeInfo.videoList)),
              _TabData(tab: Text('相关新闻'), body: _searchHomeInfo==null?Container(): TabNewsPage(_searchHomeInfo.newsList)),
              _TabData(tab: Text('相关文献'), body:  _searchHomeInfo==null?Container(): TabGuidePage(_searchHomeInfo.documentList)),
              // _TabData(tab: Text('规范解读'), body: TabGFPage())
            ];
            tabBarList = _tabDataList.map((item) => item.tab).toList();
            tabBarViewList  = _tabDataList.map((item) => item.body).toList();
            if(_tabController==null){
              _tabController = TabController(vsync: this, length: _tabDataList.length);

            }


          });

    });

  }

}


///
///   会议直播页面
///
class VideoMeetingPage extends StatefulWidget {

  List<SearchHomeInfoVideoList> _list;


  VideoMeetingPage(this._list);

  @override
  _VideoMeetingPageState createState() => _VideoMeetingPageState();
}


class _VideoMeetingPageState extends State<VideoMeetingPage>{



  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: AnimationLimiter(
        child:ListView.separated(
          itemCount: widget._list.length,
          shrinkWrap: true,
          itemBuilder: (context,index){
            return  AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 1000),
              child: FadeInAnimation(
                child: getLiveItemView(context, widget._list[index]),
              ),

            );


          },
          separatorBuilder: (context,index){
            return Container(height: setH(1),color: Colors.black12,);

          },
        ),
      ),

    );
  }
}


///
///   列表item
///
Widget getLiveItemView(context,SearchHomeInfoVideoList listBean){

  return  new  GestureDetector(

    onTap: (){
      RRouter.push(context, Routes.doctorVideoInfoPage,{"id":listBean.id});
    },

    child: new Container(
      height: ScreenUtil().setHeight(250),
      padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(27), ScreenUtil().setHeight(27), 0,  ScreenUtil().setHeight(40)),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          wrapImageUrl(listBean.image,setW(288), setH(215)),
          cXM(ScreenUtil().setHeight(20)),
          new Container(
              width: ScreenUtil().setWidth(720),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(listBean.title,style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(37)),maxLines: 2,overflow: TextOverflow.ellipsis,),

                  ),
             /*     new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new  Row(
                        children: <Widget>[
                          Image.asset(wrapAssets("tab/tab_live_ic2.png"),width: ScreenUtil().setSp(32),height: ScreenUtil().setSp(32),color: Colors.black45,),
                          cXM(5),
                          //   Text("张素娟  李霞  将建成  张大大  王素娥",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
                        ],

                      ),

                      //       Text("看录播",style: TextStyle(color: Colors.greenAccent),)

                    ],
                  ),*/
                  new Row(
                    children: <Widget>[
                      new  Row(
                        children: <Widget>[
                       //   Icon(Icons.access_time,size: ScreenUtil().setSp(32),color: Colors.black45,),
                        //  cXM(5),
                          Text(listBean.pv.toString()+"次播放",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
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





class TabNewsPage extends StatefulWidget {


  List<SearchHomeInfoNewsList> _list;


  TabNewsPage(this._list);

  @override
  _TabNewsPageState createState() => _TabNewsPageState();
}

class _TabNewsPageState extends State<TabNewsPage>{



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  ListView.separated(
          itemCount:widget._list.length,
          itemBuilder: (context,index) {

            return getLiveItemView(context,widget._list[index]);

          },
        separatorBuilder: (context,index){
          return Container(height: setH(1),color: Colors.black12,);

        },

      ),

    );
  }

  Widget getLiveItemView(BuildContext context,SearchHomeInfoNewsList xlist) {


    return  new GestureDetector(

      onTap: (){
        RRouter.push(context, Routes.newsContentPage, {"id":xlist.id});
      },
      child: new Container(


        color: Colors.white,

        height: setH(200),

        child: new Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,


          children: <Widget>[


            Row(

              children: <Widget>[

                Expanded(child:   Column(

                  children: <Widget>[

                    new   Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(xlist.title,style: TextStyle(color: Color(0xFF333333),fontSize: setSP(38),fontWeight: FontWeight.w500),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    ),

                    cYM(setH(20)),

                    new  Container(

                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                      child:  new  Row(


                        children: <Widget>[

                          buildText(xlist.createTime??"",size: 32,color:"#FF7E7E7E"),


                          xlist.createTime==null?Container():cXM(setW(100)),

                          buildText(xlist.pv.toString()+"次阅读",size: 32,color:"#FF7E7E7E"),

                        ],


                      ),
                    ),

                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                ),

                xlist.image.isEmpty?Container():wrapImageUrl(xlist.image, setW(200), setH(120)),

                cXM(setW(20))

              ],
            ),

          ],


        ),

      ),
    );



  }
}



class TabGuidePage extends StatefulWidget {
  List<SearchHomeInfoDocumantList> _list;


  TabGuidePage(this._list);

  @override
  _TabGuidePageState createState() => _TabGuidePageState();
}

class _TabGuidePageState extends State<TabGuidePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:  ListView.separated(
          itemCount:widget._list.length,
          itemBuilder: (context,index) {

            return getGuideItemView(context,widget._list[index]);

          },
        separatorBuilder: (context,index){
          return Container(height: setH(1),color: Colors.black12,);

        },

      ),

    );
  }

  Widget getGuideItemView(BuildContext context, SearchHomeInfoDocumantList xlist) {

    return  new GestureDetector(

      onTap: (){
        RRouter.push(context, Routes.guideContentPage, {"id":xlist.id});
      },
      child: new Container(


        color: Colors.white,

        height: setH(200),

        child: new Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,


          children: <Widget>[


            Row(

              children: <Widget>[

                Expanded(child:   Column(

                  children: <Widget>[

                    new   Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(xlist.title,style: TextStyle(color: Color(0xFF333333),fontSize: setSP(38),fontWeight: FontWeight.w500),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    ),

                    cYM(setH(20)),

                    new  Container(

                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                      child:  new  Row(


                        children: <Widget>[

                          buildText(xlist.createTime??"",size: 32,color:"#FF7E7E7E"),


                          xlist.createTime==null?Container():cXM(setW(100)),

                          buildText(xlist.pv.toString()+"次阅读",size: 32,color:"#FF7E7E7E"),

                        ],


                      ),
                    ),

                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                ),

                cXM(setW(20))

              ],
            ),

          ],


        ),

      ),
    );
  }
}




