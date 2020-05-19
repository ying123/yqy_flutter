import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:indexed_list_view/indexed_list_view.dart';
import 'package:like_button/like_button.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/bean/status_entity.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_meeting_list_info_entity.dart';
import 'package:yqy_flutter/ui/live/bean/hc_status_entity.dart';
import 'package:yqy_flutter/ui/live/bean/live_details_entity.dart';
import 'package:yqy_flutter/ui/live/bean/live_entity.dart';
import 'package:yqy_flutter/ui/live/bean/live_review_info_entity.dart';
import 'package:yqy_flutter/ui/live/bean/review_video_list_entity.dart';
import 'package:yqy_flutter/utils/DateUtils.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:yqy_flutter/widgets/dialog/live_schedule_dialog.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:yqy_flutter/ui/live/bean/comment_list_entity.dart';


class LiveReviewPage extends StatefulWidget {

  final  String id;


  LiveReviewPage(this.id);

  @override
  _LiveReviewPageState createState() => _LiveReviewPageState();
}

class _LiveReviewPageState extends State<LiveReviewPage>  with WidgetsBindingObserver {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  bool _showTipContent  = false;// 是否显示简介

  int viewTypeMy = 1;// 当前的排列方式  我的预约排列   0 gridview  1  listview

  ScrollController _scrollController = new ScrollController();
//页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  LiveReviewInfoInfo _liveDetailsInfo;

  ///点赞收藏相关==================================
  bool _isLike,_isCollect; // 点赞 和 收藏 之前的状态
  String _cancelLike,_cancelCollect;// 取消点赞和收藏的ID
  ///=============================================


  ///评论相关==================================
  int _commentPage = 1;
  CommentListInfo _commentListInfo;
  String _content; // 评论的内容
  ///=============================================



  ///直播专家列表==================================
  ReviewVideoListInfo _videoListInfo; // 直播专家列表
  int _idnexVideoList  = 0; // 当前视频列表的节点
  ///=============================================



  ///会场相关==================================
    String currentHCID ; // 当前所在的会场编号
    int currentHC = 0; // 当前所在的会场坐标
    int statusId = 1; // 当前会场的直播状态  需要展示不同的布局
   String imgUrl; // 当前会场的需要展示的图片   未开始和已结束
   ///=============================================

  FijkPlayer player = FijkPlayer();
  StreamSubscription changeSubscription;

  String liveId; // 当前会议的ID



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    liveId = widget.id;
    loadData();
    changeSubscription =  eventBus.on<EventBusChange>().listen((event) {
      setState(() {
        player.reset().then((_){
          player.setDataSource(event.url, autoPlay: true);
        });
      });
    });
  }

  @override
  void dispose() {
    //  FlutterUmplus.endPageView(runtimeType.toString());
    super.dispose();
    player.release();
      player=null;
    changeSubscription.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {

    if(state==AppLifecycleState.paused){
      player.pause();
    }

    if(state==AppLifecycleState.resumed){
      player.start();
    }

  }

  void loadData() async{


    Future.wait([
      // 当前页面的数据
      NetUtils.requestReviewInfo(liveId),
     // 收藏的状态
     NetUtils.requestCollectCheckStatus(AppRequest.PAGE_ROUTE_LIVE,liveId),
      // 点赞的状态
      NetUtils.requestGoodCheckStatus(AppRequest.PAGE_ROUTE_LIVE,liveId),
      // 评论列表
      NetUtils.requestCommentLists(UserUtils.getUserInfoX().id.toString(),AppRequest.PAGE_ROUTE_LIVE,liveId,_commentPage.toString())

    ]).then((ress){


      if(ress[0].code==200){
        _liveDetailsInfo = LiveReviewInfoInfo.fromJson(ress[0].info);

        if(_liveDetailsInfo.videoList.length>0){
          player.setDataSource(_liveDetailsInfo.videoList[0].playUrl??"", autoPlay: true);

          }

      }

      if(ress[1].code==200){
          StatusInfo   info =  StatusInfo.fromJson(ress[1].info);
          int  status = info.status;
          _cancelCollect = info.id.toString();
          status==1?_isCollect = true : _isCollect = false;
      }

      if(ress[2].code==200){

          StatusInfo   info =  StatusInfo.fromJson(ress[2].info);
          int  status = info.status;
          _cancelLike = info.id.toString();
          status==1?_isLike = true : _isLike = false;
      }


      if(ress[3].code==200){

          _commentListInfo =  CommentListInfo.fromJson(ress[3].info);
      }


      setState(() {
        _layoutState = loadStateByCode(200);
      });

    }).then((_){
      if(_liveDetailsInfo!=null&&_liveDetailsInfo.meetList!=null){
        currentHCID = _liveDetailsInfo.meetList[0].id.toString();
        getProgrammeListData();
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 1080, height: 1920);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getCommonAppBar(context,"会议录播"),
      body:  LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          this.loadData();
        },
        successWidget:_liveDetailsInfo==null?Container(): Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            //主要内容布局
            buildContextView(context),
            // 底部点击评论的布局
            buildBottomView(context)
          ],
        ),

      )
    );
  }


  ///
  ///  界面布局
  ///
  buildContextView(BuildContext context) {

    return Container(
      height: double.infinity,
      child: Column(

        children: <Widget>[
          // 视频布局
          buildContentVideo(context),
          //下方内容为可滚动的
          buildListView(context),
          //底部的高度 避免评论布局遮挡内容的布局
          cYM(ScreenUtil().setHeight(130))

        ],
      ),
    );
  }

  buildBottomView(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
      height: ScreenUtil().setHeight(130),
      color: Colors.white,
      child: Row(

        children: <Widget>[
          //评论输入框
          Expanded(child:   new Container(
            width: ScreenUtil().setWidth(800),
            height: ScreenUtil().setHeight(90),
            decoration: BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30)))
            ),
            child: Row(
              children: <Widget>[
                cXM(ScreenUtil().setWidth(40)),
                Icon(Icons.border_color,color: Colors.black26,size: ScreenUtil().setWidth(50),),
                cXM(ScreenUtil().setWidth(30)),

                Container(
                  width: setW(600),
                  child:  TextFormField(
                    controller: new TextEditingController(
                      text: _content
                    ),
                    decoration: InputDecoration(
                      hintText: "发表评论",
                      hintStyle:  TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.send,
                    style:  TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(36)),
                    onChanged: (str){
                      _content = str;
                    },
                    onFieldSubmitted: (value) {
                      _content = "";
                      // 上传 评论的内容
                      uploadCommentData(value);
                    },

                  ),

                )
              ],
            ),

          ),),

          cXM(ScreenUtil().setWidth(20)),
          // 消息按钮
          new  Material(
            color: Colors.transparent,
            child:   InkWell(

              onTap: (){

              },
              child:   new Container(
                  height:  ScreenUtil().setHeight(110),
                  width: ScreenUtil().setWidth(110),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(Icons.sms,size: ScreenUtil().setWidth(60),color: Color(0xff999999),),
                      Positioned(
                          right: 0,
                          top: 0,
                          child:  Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            width: ScreenUtil().setWidth(36),
                            height: ScreenUtil().setWidth(36),
                            alignment: Alignment.center,
                            child: Text(_commentListInfo==null?"0":_commentListInfo.lists.length.toString(),style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(22)),),

                          ))
                    ],

                  )

              ),
            ),
          ),

          // 点赞按钮
          new Container(
              alignment: Alignment.center,
              height:  ScreenUtil().setHeight(110),
              width: ScreenUtil().setWidth(25),
            /*  child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: (){

                }, child:    Icon(Icons.favorite,size: ScreenUtil().setWidth(60),color: Color(0xFFFF934C),),)
*/
          )
        ],
      ),

    );

  }

  // 视频view
  buildContentVideo(BuildContext context) {

    return Container(

      height: ScreenUtil().setHeight(500),
      child: statusId==1?FijkView(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        player: player,
      ):wrapImageUrl(imgUrl, double.infinity, double.infinity),

    );


  }

  // 视频信息 简介
  buildContentInfoView(BuildContext context) {

    return Container(

      child: Column(

        children: <Widget>[

          new Container(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30),0,ScreenUtil().setWidth(30),ScreenUtil().setWidth(0)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(_liveDetailsInfo.title??"", style: TextStyle(color: Color(0xFF333333),
                      fontSize: ScreenUtil().setSp(40),
                      fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.start,),
                  width: ScreenUtil().setWidth(1000),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_liveDetailsInfo.startTime+"~"+_liveDetailsInfo.endTime, style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: ScreenUtil().setSp(35)),),

                    Material(

                      color: Colors.white30,
                      child: InkWell(
                        onTap: () {
                          setState(() {

                            _showTipContent
                                ? _showTipContent = false
                                : _showTipContent = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                          alignment: Alignment.center,
                          child: Text(_showTipContent ? "简介" : "简介 >",
                            style: TextStyle(color: Color(0xFF4AB1F2),
                                fontSize: ScreenUtil().setSp(35)),),
                        ),
                      ),
                    )


                  ],
                ),
                Visibility(
                    visible: true,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_liveDetailsInfo.area, style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: ScreenUtil().setSp(35)),),
                      ],
                    )
                ),
                cYM(ScreenUtil().setHeight(10)),
                Visibility(
                    visible: _showTipContent,
                  child: Html(
                    data: _liveDetailsInfo.content,

                  ),

                  // 文字显示
                  /*  child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(_liveDetailsInfo.content, style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: ScreenUtil().setSp(35)),),
                      ],
                    )*/
                )

              ],
            ),

          ),
          // 观看人数 点赞收藏
          buildBtnView(context),


        ],

      ),

    );


  }

  // 分割线
  buildLine() {
    return Container(
      height: ScreenUtil().setHeight(12),
      color: Color(0xFFF5F5F5),
    );

  }



  buildListView(BuildContext context) {

    return Expanded(child:  SmartRefresher(
    enablePullDown: false,
    enablePullUp: true,
        controller: _refreshController,
        onRefresh: null,
        onLoading: _onLoading,
        child:  ListView(
          controller: _scrollController,
          shrinkWrap: true,
          padding: EdgeInsets.all(0),
          children: <Widget>[
            cYM(setH(40)),
            // 视频简介
            buildContentInfoView(context),
            // 其他会场的布局
            buildOtherHCView(context),
            //分割线
            buildLine(),
            // 关键词
            buildCruxView(context),
            buildLine(),
            //正在播放
            getRowTextView("内容列表"),
            _videoListInfo==null?Container(): buildLiveTab(context),
            buildLine(),
            //相关专家
            getRowTextView("相关专家"),
            buildDoctorListView(context),
            buildLine(),
            /*   //相关学会
        getRowTextView("相关学会"),
        buildLearnView(context),
        buildLine(),*/
            // 推荐视频
            getRowTextView("为您推荐"),
            buildLiveNoticeView(_liveDetailsInfo.recommendMeeting,viewTypeMy),
            //评论
            getRowTextView("全部评论"),
            buildCommentView(context),

          ],

        )
    )      );
  }


  buildCruxView(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29),setH(29), ScreenUtil().setWidth(29), setH(29)),
      height: ScreenUtil().setHeight(120),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Text("关键词",style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),

         ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
            scrollDirection: Axis.horizontal,
            itemCount: _liveDetailsInfo.keywords.length,
             itemBuilder: (context,page){
              return    new  Container(
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(40),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12)))
                ),
                child: Text(_liveDetailsInfo.keywords[page],style: TextStyle(color: Colors.black45,fontSize: ScreenUtil().setSp(35)),),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
              );
          },

          )

        ],

      ),

    );
  }

  buildScheduleView(BuildContext context) {

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){
          requestSchedule(context,_liveDetailsInfo.content);
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29),0, ScreenUtil().setWidth(29), 0),
          height: ScreenUtil().setHeight(140),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("会议日程",style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
              Icon(Icons.keyboard_arrow_right,size: ScreenUtil().setWidth(60),color:Colors.black26,)

            ],
          ),

        ),

      ),
    );

  }
  Widget getRowTextView(String type){

    return Container(
      height: ScreenUtil().setHeight(120),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29),0, ScreenUtil().setWidth(29), 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(type,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w800),),
          new GestureDetector(
            child: Container(
              child: Row(
                children: <Widget>[

                  Visibility(
                    child:    new  InkWell(
                      child:  Image.asset(wrapAssets("tab/tab_live_iv1.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                      onTap: (){
                        setState(() {
                        });

                      },
                    ),
                    visible: type=="视频"?true:false,

                  ),

                  cXM(ScreenUtil().setWidth(60)),

                  Visibility(
                      visible: false,
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
  Widget buildLiveNoticeView(List<LiveReviewInfoInfoRecommandMeeting> list,int viewType){

    return list==null?Container():viewType==0?GridView.count(
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(10),
      //GridView内边距
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29),0, ScreenUtil().setWidth(29), 0),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: list.getRange(0,list.length).map((item) => itemVideoView(item)).toList(),
    ): ListView.separated(
        shrinkWrap: true ,
        physics: new NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context,index){
          return getLiveItemView(context,list[index]);
        },
      separatorBuilder: (context,index){
          return Container(
            height: setH(1),
            color: Colors.black12,
          );
      },
    );
  }
  ///
  ///  热门视频 item
  ///
  Widget itemVideoView(LiveReviewInfoInfoRecommandMeeting bean) {

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
            wrapImageUrl(bean.image,  ScreenUtil().setWidth(501),  ScreenUtil().setHeight(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(bean.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(bean.startTime.toString(),style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
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
  ///   列表item
  ///
  Widget getLiveItemView(context,LiveReviewInfoInfoRecommandMeeting bean){

    return  GestureDetector(

      onTap: (){

        RRouter.push(context, Routes.liveReviewPage,{"id":bean.id});

      },

      child: new Container(
        height: ScreenUtil().setHeight(250),
        padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(27), ScreenUtil().setHeight(27), 0,  ScreenUtil().setHeight(40)),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // Icon(Icons.apps,size: 110,color: Colors.blueAccent,),
              wrapImageUrl(bean.image, ScreenUtil().setHeight(230),ScreenUtil().setWidth(380)),
            //  new Image(image: new CachedNetworkImageProvider("http://via.placeholder.com/350x150"),width: 110,height: 110,color: Colors.black,),
            cXM(ScreenUtil().setHeight(20)),
            new Container(
                width: ScreenUtil().setWidth(720),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(bean.title,style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(37)),maxLines: 2,overflow: TextOverflow.ellipsis,),

                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Image.asset(wrapAssets("tab/tab_live_ic2.png"),width: ScreenUtil().setSp(32),height: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Row(

                              children: bean.authors.map((item)=>Text(item.realName+" ",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32))),).toList()
                            )

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
                            Text(DateUtils.instance.getFormartData(timeSamp: int.parse(bean.startTime.toString())*1000,format: "yyyy-MM-dd"),style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
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
  ///  横向滑动专家列表
  ///
  Widget buildDoctorListView(BuildContext context) {

    return Container(
      height: ScreenUtil().setHeight(300),
      child: ListView.builder(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29),0, ScreenUtil().setWidth(29), 0),
          scrollDirection:Axis.horizontal,
          itemCount: _liveDetailsInfo.authors.length,
          itemBuilder: (context,index){
            return buildItemDoctorView(context,_liveDetailsInfo.authors[index]);
          }
      ),



    );


  }

  Widget buildItemDoctorView(BuildContext context,LiveReviewInfoInfoAuthor bean) {

    return  InkWell(
      onTap: (){
        RRouter.push(context, Routes.doctorDetailsPage,{"userId":bean.id});
      },

      child: Container(
        margin: EdgeInsets.only(right: ScreenUtil().setWidth(30)),
        height: ScreenUtil().setWidth(260),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            wrapImageUrl(bean.userPhoto, setW(250), setW(245)),
            cYM(setH(35)),
            Text(bean.realName,style: TextStyle(fontWeight: FontWeight.w400,fontSize: ScreenUtil().setSp(35)),),
            //   Text("介绍",style: TextStyle(fontSize: ScreenUtil().setSp(30)),)

          ],


        ),

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
  ///  评论布局
  ///
  ///
  ///


  void _onLoading() async{
    _commentPage ++;
    loadMoreData();
  }
  buildCommentView(BuildContext context) {

    return _commentListInfo==null?Container():

        ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29),0, ScreenUtil().setWidth(29), 0),
          physics: new NeverScrollableScrollPhysics(),
          itemCount: _commentListInfo.lists.length,
          itemBuilder: (context,index){
            return itemCommentView(context,index);
          },
    );


  }

  ///
  ///  评论item
  ///
  itemCommentView(BuildContext context, int index) {

    return Container(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
        height: ScreenUtil().setHeight(145),
        child: Column(
          children: <Widget>[
            new  Expanded(child: Row(
              children: <Widget>[
                wrapImageUrl(_commentListInfo.lists[index].userPhoto,  ScreenUtil().setWidth(90),  ScreenUtil().setWidth(90)),
                cXM(ScreenUtil().setWidth(24)),
                Expanded(child:      new  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text.rich(TextSpan(
                        children: [
                          TextSpan(
                              text: _commentListInfo.lists[index].userName==null?":": _commentListInfo.lists[index].userName+": ",
                              style: TextStyle(color: Colors.blue,fontSize: ScreenUtil().setSp(35))
                          ),
                          TextSpan(
                              text: _commentListInfo.lists[index].content??"",
                              style: TextStyle(color:Color(0xff333333),fontSize: ScreenUtil().setSp(35))
                          ),
                        ]
                    )),
                    cYM(ScreenUtil().setHeight(20)),
                    Text(_commentListInfo.lists[index].createTime,style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(0xff999999)),),

                  ],
                )),

              ],
            ),
            ),
            Divider(color: Colors.black12,height: ScreenUtil().setHeight(2),)

          ],
        )
    );
  }

  ///
  ///  正在直播 节点切换
  ///
  buildLiveTab(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(340),
        child: ListView.builder(
             shrinkWrap: true,
            padding: EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            itemCount: _videoListInfo.lists.length,
            itemBuilder: (context,index){

          return tabItemView(index);

        }),
    );

  }



  buildBtnView(BuildContext context) {

    return Container(
      padding: EdgeInsets.fromLTRB(setW(30), 0, setW(30), 0),
      margin: EdgeInsets.only(bottom: setH(30)),
      height: setH(60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Expanded(child: buildText(_liveDetailsInfo.pv==null?"0":_liveDetailsInfo.pv.toString()+"次播放",color: "#FF999999"),),

          Row(

            children: <Widget>[
              LikeButton(
                isLiked: _isCollect,
                likeBuilder: (bool isLike){

                  return  !isLike?Image.asset(wrapAssets("icon_collect_cancel.png"),width: setW(25),height: setH(25),):
                  Image.asset(wrapAssets("icon_collect.png"),width: setW(25),height: setH(25));
                },
                onTap: (bool isLiked)
                {
                  return onCollectButtonTap(isLiked,_liveDetailsInfo.id.toString());
                },

              ),

            ],
          ),
          cXM(setW(40)),
          Row(

            children: <Widget>[
              LikeButton(
                isLiked: _isLike,
                likeBuilder: (bool isLike){

                  return  !isLike?Image.asset(wrapAssets("icon_dz_cancel.png"),width: setW(25),height: setH(25)):
                  Image.asset(wrapAssets("icon_dz.png"),width: setW(25),height: setH(25));
                },
                onTap: (bool isLiked)
                {
                  return onLikeButtonTap(isLiked,_liveDetailsInfo.id.toString());
                },

              ),


            ],
          )





        ],
      ),

    );

  }

  ///
  ///  点赞 的 网络请求
  ///
  Future<bool> onLikeButtonTap(bool isLike,var  id) {

    final Completer<bool> completer = new Completer<bool>();

    if(!isLike){

      NetUtils.requestGoodAdd(AppRequest.PAGE_ROUTE_LIVE,id)
          .then((res){
        completer.complete(res.code==200?true:false);
        showToast(res.msg);
        setState(() {
          _isLike = true;
        });
      });
    }else{

      NetUtils.requestGoodDel(_cancelLike)
          .then((res){
        completer.complete(res.code==200?false:true);
        showToast(res.msg);
        setState(() {
          _isLike = false;
        });
      });
    }
    return completer.future;
  }

  ///
  ///  收藏 的 网络请求
  ///
  Future<bool> onCollectButtonTap(bool isLike,var  id) {

    final Completer<bool> completer = new Completer<bool>();

    if(!isLike){

      NetUtils.requestCollectAdd(AppRequest.PAGE_ROUTE_LIVE,id)
          .then((res){
        completer.complete(res.code==200?true:false);
        showToast(res.msg);
        setState(() {
          _isCollect = true;
        });
      });
    }else{

      NetUtils.requestCollectDel(_cancelCollect)
          .then((res){
        completer.complete(res.code==200?false:true);
        showToast(res.msg);
        setState(() {
          _isCollect = false;
        });
      });
    }
    return completer.future;
  }

  ///
  ///  上传评论的内容
  ///
  void uploadCommentData(String value) {

    NetUtils.requestCommentAdd(AppRequest.PAGE_ROUTE_LIVE, liveId, value)
        .then((res){
           showToast(res.msg);
          if(res.code==200){

            // 评论列表
            NetUtils.requestCommentLists(UserUtils.getUserInfoX().id.toString(),AppRequest.PAGE_ROUTE_LIVE,liveId,_commentPage.toString())
                .then((res) {

              if(res.code==200){

                setState(() {
                  _commentListInfo =  CommentListInfo.fromJson(res.info);
                });
              }

            });

          }

    });

  }

  ///
  ///  专家播放节点
  /// 
  tabItemView(int pos) {

    return  InkWell(
      onTap: (){

        _idnexVideoList = pos;
        eventBus.fire(EventBusChange(_videoListInfo.lists[pos].playUrl));

      },
      child: new  Container(
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(350),
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            cYM(ScreenUtil().setHeight(20)),
            Container(
              width: ScreenUtil().setWidth(280),
              height: setH(90),
              child:    Text(_videoListInfo.lists[pos].title,style: TextStyle(color:_idnexVideoList==pos?Colors.blue: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),textAlign: TextAlign.center,maxLines: 2,overflow: TextOverflow.ellipsis,),
            ),
            cYM(ScreenUtil().setHeight(20)),
            new  Row(
              children: <Widget>[
                Expanded(child:  Divider(color: pos==0?Colors.white: Colors.black26,height: ScreenUtil().setHeight(20),)),
                Container(
                  width: ScreenUtil().setWidth(26),
                  height: ScreenUtil().setWidth(26),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
                    border: Border.all(color:_idnexVideoList==pos?Colors.blue: Color(0xFF999999)),
                    color: _idnexVideoList==pos?Colors.blue: Colors.white,
                  ),
                ),
                Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(20),)),

              ],
            ),
            cYM(ScreenUtil().setHeight(20)),
         //   wrapImageUrl(_videoListInfo.lists[pos].users.userPhoto,  ScreenUtil().setWidth(120),  ScreenUtil().setWidth(120)),

            FLAvatar(
              image: Image.network(_videoListInfo.lists[pos].users.userPhoto,scale: 2,),
              width: setW(120),
              height: setW(120),
              radius: setW(60), // if not specify, will be width / 2
            ),

            cYM(ScreenUtil().setHeight(22)),
            Text(_videoListInfo.lists[pos].users.realName??"",style: TextStyle(color: _idnexVideoList==pos?Colors.blue:Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),)

          ],
        ),
      ),
    );
    
  }



  ///
  ///  获取 专家讲课进度节点的列表
  ///
  void getProgrammeListData() {
    // 请求会场专家的列表
    var loadingCancel = FLToast.loading();
    NetUtils.requestReviewVideoList(currentHCID)
        .then((res){

      loadingCancel();
      if(res.code==200){

        setState(() {
          _videoListInfo  =    ReviewVideoListInfo.fromJson(res.info);
        });

      }

    }).catchError((e){
      loadingCancel();

    });


  }


  ///
  ///   切换当前会场的 内容列表
  ///
  void getCurrentHcStatusData(BuildContext context) {


    getProgrammeListData();

  }

  buildOtherHCView(BuildContext context) {

    // 分会场
  return  _liveDetailsInfo.meetList.length>1?Column(

    children: <Widget>[
      //分割线
      buildLine(),
      //正在播放
      getRowTextView("其他会场"),
      Container(
          margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, 0, 0),
          height: ScreenUtil().setHeight(100),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: _liveDetailsInfo.meetList.length,
            padding: EdgeInsets.all(0),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, page) {
              return InkWell(
                onTap: () {
                  currentHC = page;
                  currentHCID = _liveDetailsInfo.meetList[page].id.toString();
                  // 获取当前会场状态数据
                  getCurrentHcStatusData(context);

                  },
                child: new Container(
                    width: ScreenUtil().setWidth(430),
                    height: ScreenUtil().setHeight(90),
                    margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                    alignment: Alignment.center,

                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[

                        Image.asset(wrapAssets(page == currentHC
                            ? "live/bg_hc_sele.png"
                            : "live/bg_hc.png"), width: double.infinity,
                          height: double.infinity,),
                        Text(_liveDetailsInfo.meetList[page].title,
                          style: TextStyle(color: Colors.white,
                              fontSize: ScreenUtil().setSp(37),
                              fontWeight: FontWeight.bold),),

                      ],

                    )
                ),

              );
            },
          )
      )
    ],

    ):Container();

  }

  ///
  ///  加载更多评论
  ///
  void loadMoreData() {

    // 评论列表
    NetUtils.requestCommentLists(UserUtils.getUserInfoX().id.toString(),AppRequest.PAGE_ROUTE_LIVE,liveId,_commentPage.toString())
        .then((res){


      if(res.code==200){
        if (CommentListInfo
            .fromJson(res.info)
            .lists.length == 0) {
          _refreshController.loadNoData();
        } else {
          _commentListInfo.lists.addAll(CommentListInfo.fromJson(res.info).lists);
          _refreshController.loadComplete();
        }
        setState(() {

        });

      }

    });

  }
}
