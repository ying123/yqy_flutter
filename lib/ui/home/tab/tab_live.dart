import 'package:cached_network_image/cached_network_image.dart';
import 'package:flui/flui.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_live_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

class TabLivePage extends StatefulWidget {
  @override
  _TabLivePageState createState() => _TabLivePageState();
}

class _TabLivePageState extends State<TabLivePage>  with AutomaticKeepAliveClientMixin {



  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  int viewTypeMy = 0;// 当前的排列方式  我的预约排列   0 gridview  1  listview
  int viewTypeLive = 0;// 当前的排列方式  直播预告排列   0 gridview  1  listview
  int viewTypeLiveIng = 0;// 当前的排列方式  正在直播排列   0 gridview  1  listview
  int viewTypeVideo = 0;// 当前的排列方式  视频回放排列   0 gridview  1  listview
  RefreshController _refreshController ;

  TabLiveInfo _tabLiveInfo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initData();
    _refreshController  = RefreshController(initialRefresh: false);
  }


  void _onRefresh() async{
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    initData();
    _refreshController.refreshCompleted();
    _refreshController.resetNoData();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return  Scaffold(
      backgroundColor: Colors.white,
       body: LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          this.initData();
        },
        successWidget:_tabLiveInfo==null?Container(): SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        controller: _refreshController,
        onRefresh: _onRefresh,
          //onLoading: _onLoading,
          child:  new ListView(

            children: <Widget>[
              cYM(ScreenUtil().setHeight(22)),


              // 正在直播
              Visibility(visible:_tabLiveInfo.bannerList.length>0,child: Column(

                children: <Widget>[
                  _tabLiveInfo.bannerList.length>0?buildBanner(context,_tabLiveInfo.bannerList[0]):Container(),
                  cYM(ScreenUtil().setHeight(60)),
                  getRowTextView("正在直播"),
                  buildLiveIngView("正在直播",_tabLiveInfo.bannerList,viewTypeLiveIng),

                ],

              )),


              // 预约
              Visibility(visible: _tabLiveInfo.myOrder.length>0,child: Column(

                children: <Widget>[

                  getRowTextView("我的预约"),
                  buildLiveMyNoticeView("我的预约",_tabLiveInfo.myOrder,viewTypeMy),

                ],

              )),


              // 直播预告
              Visibility(visible: _tabLiveInfo.orderList.length>0,child: Column(

                children: <Widget>[

                  getRowTextView("直播预告"),
                  buildLiveNoticeView("直播预告", _tabLiveInfo.orderList,viewTypeLive),

                ],

              )),



              // 视频回放
              Visibility(visible:_tabLiveInfo.historyList.length>0,child: Column(

                children: <Widget>[

                  getRowTextView("视频回放"),
                  buildLiveHistoryView("视频回放",_tabLiveInfo.historyList,viewTypeVideo),

                ],

              )),


            ],

          ),
      )
    ));
  }

 Widget buildBanner(BuildContext context,TabLiveInfoBannerList bean) {

    return InkWell(
    //  child: Image.asset(wrapAssets("tab/tab_live_banner.png"),width: double.infinity,height: ScreenUtil().setHeight(403),fit: BoxFit.fill,),
      child: wrapImageUrl(bean.image, double.infinity,  ScreenUtil().setHeight(460)),
      onTap: (){
        RRouter.push(context ,Routes.liveIngPage,{"id":bean.id.toString()},transition:TransitionType.cupertino);
      },
    );


  }


  Widget getRowTextView(String type){

    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(120),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(24), 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(type,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46),fontWeight: FontWeight.w600),),
          new GestureDetector(
            child: Container(
              child: Row(
                children: <Widget>[
                  InkWell(
                    child: Image.asset(wrapAssets(viewTypeMy==0?"tab/tab_live_iv1.png":"tab/tab_live_iv11.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                    onTap: (){
                      setState(() {

                        switch(type){

                          case "正在直播":
                            viewTypeLiveIng==0?viewTypeLiveIng=1:viewTypeLiveIng=0;
                            break;
                          case "我的预约":
                            viewTypeMy==0?viewTypeMy=1:viewTypeMy=0;
                            break;
                          case "直播预告":
                            viewTypeLive==0?viewTypeLive=1:viewTypeLive=0;
                            break;
                          case "视频回放":
                            viewTypeVideo==0?viewTypeVideo=1:viewTypeVideo=0;
                            break;

                        }

                      });

                    },
                  ),

                  cXM(ScreenUtil().setWidth(63)),
                  Text("更多"+type.substring(2,4),style: TextStyle(color:Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
                  Icon(Icons.arrow_forward_ios,color: Colors.black12,size: ScreenUtil().setWidth(35),),
                ],

              ),
            ),
            onTap: (){


              switch(type){

                case "正在直播":
              //    RRouter.push(context, Routes.liveMeeting,{"title":"11"});
                 FLToast.info(text: "暂无更多内容");
                  break;
                case "我的预约":
                  FLToast.info(text: "暂无更多内容");
                  break;
                case "直播预告":
                  FLToast.info(text: "暂无更多内容");
                  break;
                case "视频回放":
                  FLToast.info(text: "暂无更多内容");
                 // RRouter.push(context, Routes.doctorVideoListPage,{});
                  break;

              }

            },

          ),

        ],


      ),

    );

  }
  ///
  ///  正在直播
  ///
  Widget buildLiveIngView(String v,List<TabLiveInfoBannerList> list,int viewType){

    return list==null?Container():viewType==0?GridView.count(
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(10),
      //GridView内边距
      padding:EdgeInsets.fromLTRB(setW(29), 0, setW(29), 0),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: list.getRange(0,list.length).map((item) => itemLiveIngView(item,v)).toList(),
    ): ListView.builder(
        shrinkWrap: true ,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context,index){
          return getLiveItemIngView(context,list[index]);
        }
    );
  }
  ///
  ///  直播预告布局
  ///
  Widget buildLiveNoticeView(String v,List<TabLiveInfoOrderList> list,int viewType){

    return list==null?Container():viewType==0?GridView.count(
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(10),
      //GridView内边距
      padding:EdgeInsets.fromLTRB(setW(29), 0, setW(29), 0),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: list.getRange(0,list.length).map((item) => itemLiveNoticeView(item,v)).toList(),
    ): ListView.builder(
        shrinkWrap: true ,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context,index){
          return getLiveItemNoticeView(context,list[index]);
        }
        );
  }

  ///
  ///  视频 item
  ///
  Widget itemVideoView(TabLiveInfoHistoryList list,String type) {

    return  InkWell(
      onTap: (){

        switch(type){

          case "正在直播":
            RRouter.push(context, Routes.liveMeeting,{"title":"11"});
            break;
          case "我的预约":
            RRouter.push(context, Routes.liveMeeting,{"title":"11"});
            break;
          case "直播预告":
            RRouter.push(context, Routes.liveMeeting,{"title":"11"});
            break;
          case "视频回放":
            RRouter.push(context, Routes.liveReviewPage,{"id":list.id.toString()});
            break;

        }

      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            wrapImageUrl(list.image, setW(501), setH(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(list.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(list.startTime,style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  //   Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                ],
              ),
            )

          ],
        ),

      ),
    );


  }
  ///
  ///  直播 item
  ///
  Widget itemLiveIngView(TabLiveInfoBannerList list,String type) {


    return new InkWell(
      onTap: (){

        switch(type){

          case "正在直播":
            RRouter.push(context, Routes.liveIngPage,{"id":list.id});
            break;
          case "我的预约":
            RRouter.push(context, Routes.liveNoticePage,{"id":list.id});
            break;
          case "直播预告":
            RRouter.push(context, Routes.liveNoticePage,{"id":list.id});
            break;
          case "视频回放":
            RRouter.push(context, Routes.livePaybackPage,{"id":list.id});
            break;

        }

      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            wrapImageUrl(list.image, setW(501), setH(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(list.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(list.startTime.toString(),style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
               //   Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                ],
              ),
            )

          ],
        ),

      ),
    );


  }
  ///
  ///  我的预约 item
  ///
  Widget itemLiveMyNoticeView(TabLiveInfoMyOrder list,String type) {

    return new InkWell(
      onTap: (){

        switch(type){

          case "正在直播":
            RRouter.push(context, Routes.liveIngPage,{"id":list.id});
            break;
          case "我的预约":
            RRouter.push(context, Routes.liveNoticePage,{"id":list.id});
            break;
          case "直播预告":
            RRouter.push(context, Routes.liveNoticePage,{"id":list.id});
            break;
          case "视频回放":
            RRouter.push(context, Routes.livePaybackPage,{"id":list.id});
            break;

        }

      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            wrapImageUrl(list.image, setW(501), setH(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(list.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(list.startTime.toString(),style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  //   Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                ],
              ),
            )

          ],
        ),

      ),
    );


  }
  ///
  ///  预约 item
  ///
  Widget itemLiveNoticeView(TabLiveInfoOrderList list,String type) {

    return new InkWell(
      onTap: (){

        switch(type){

          case "正在直播":
            RRouter.push(context, Routes.liveIngPage,{"id":list.id});
            break;
          case "我的预约":
            RRouter.push(context, Routes.liveNoticePage,{"id":list.id});
            break;
          case "直播预告":
            RRouter.push(context, Routes.liveNoticePage,{"id":list.id});
            break;
          case "视频回放":
            RRouter.push(context, Routes.livePaybackPage,{"id":list.id});
            break;

        }

      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            wrapImageUrl(list.image, setW(501), setH(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(list.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(list.startTime.toString(),style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  //   Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                ],
              ),
            )

          ],
        ),

      ),
    );


  }
  ///
  ///  视频 item
  ///
  Widget itemLiveHisView(TabLiveInfoHistoryList list,String type) {


    return new InkWell(
      onTap: (){

        switch(type){

          case "正在直播":
            RRouter.push(context, Routes.liveIngPage,{"id":list.id});
            break;
          case "我的预约":
            RRouter.push(context, Routes.liveNoticePage,{"id":list.id});
            break;
          case "直播预告":
            RRouter.push(context, Routes.liveNoticePage,{"id":list.id});
         //   RRouter.push(context, Routes.liveIngPage,{"id":list.id});
            break;
          case "视频回放":
           RRouter.push(context, Routes.liveReviewPage,{"id":list.id});
          //  RRouter.push(context, Routes.liveIngPage,{"id":list.id});
           // RRouter.push(context, Routes.liveNoticePage,{"id":list.id});
            break;

        }

      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            wrapImageUrl(list.image, setW(501), setH(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(list.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(list.startTime.toString(),style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  //   Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
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
  ///   直播列表item
  ///
  Widget getLiveItemIngView(context,TabLiveInfoBannerList listBean){

    return  GestureDetector(

      onTap: (){
         RRouter.push(context, Routes.liveIngPage,{"id":listBean.id});
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
                    new Row(
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
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Icon(Icons.access_time,size: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text(listBean.startTime.toString(),style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
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
  ///   我的预约列表item
  ///
  Widget getLiveItemMyNoticeView(context,TabLiveInfoMyOrder listBean){

    return  GestureDetector(

      onTap: (){
        RRouter.push(context, Routes.liveNoticePage,{"id":listBean.id});
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
                    new Row(
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
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Icon(Icons.access_time,size: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text(listBean.startTime.toString(),style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
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
  ///   预约列表item
  ///
  Widget getLiveItemNoticeView(context,TabLiveInfoOrderList listBean){

    return  GestureDetector(

      onTap: (){
        RRouter.push(context, Routes.liveNoticePage,{"id":listBean.id});
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
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Image.asset(wrapAssets("tab/tab_live_ic2.png"),width: ScreenUtil().setSp(32),height: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                        //    Text("张素娟  李霞  将建成  张大大  王素娥",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
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
                            Text(listBean.startTime.toString(),style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
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
  ///   视频列表item
  ///
  Widget getLiveItemHistoryView(context,TabLiveInfoHistoryList listBean){

    return  new  GestureDetector(

      onTap: (){
        RRouter.push(context, Routes.liveReviewPage,{"id":listBean.id});
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
                    new Row(
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
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Icon(Icons.access_time,size: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text(listBean.startTime.toString(),style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
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


  void initData() {


    NetUtils.requestMeetingIndex()
        .then((res){


       if(res.code==200){


         setState(() {
           _tabLiveInfo = TabLiveInfo.fromJson(res.info);
           _layoutState = loadStateByCode(res.code);
         });

       }




    });


  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  buildLiveMyNoticeView(String s, List<TabLiveInfoMyOrder> list, int viewType) {

    return list==null?Container():viewType==0?GridView.count(
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(10),
      //GridView内边距
      padding:EdgeInsets.fromLTRB(setW(29), 0, setW(29), 0),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: list.getRange(0,list.length).map((item) => itemLiveMyNoticeView(item, s)).toList(),
    ): ListView.builder(
        shrinkWrap: true ,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context,index){
          return getLiveItemMyNoticeView(context,list[index]);
        }
    );
  }

  buildLiveHistoryView(String s, List<TabLiveInfoHistoryList> list, int viewType) {
    return list==null?Container():viewType==0?GridView.count(
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(10),
      //GridView内边距
      padding:EdgeInsets.fromLTRB(setW(29), 0, setW(29), 0),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: list.getRange(0,list.length).map((item) => itemLiveHisView(item, s)).toList(),
    ): ListView.builder(
        shrinkWrap: true ,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context,index){
          return getLiveItemHistoryView(context,list[index]);
        }
    );

  }

}
