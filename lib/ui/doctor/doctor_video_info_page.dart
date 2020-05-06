import 'dart:async';

import 'package:fijkplayer/fijkplayer.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:like_button/like_button.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/bean/status_entity.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/doctor/bean/doctor_video_info_entity.dart';
import 'package:yqy_flutter/ui/live/bean/live_details_entity.dart';
import 'package:yqy_flutter/ui/live/bean/live_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:yqy_flutter/ui/live/bean/comment_list_entity.dart';


///
///   专家视频播放详情页面
///
class DoctorVideoInfoPage extends StatefulWidget {
  
  final String id;


  DoctorVideoInfoPage(this.id);

  @override
  _DoctorVideoInfoPageState createState() => _DoctorVideoInfoPageState();
}

class _DoctorVideoInfoPageState extends State<DoctorVideoInfoPage>   with WidgetsBindingObserver{

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  bool _showTipContent  = false;// 是否显示简介

  int viewTypeMy = 1;// 当前的排列方式  我的预约排列   0 gridview  1  listview

  ScrollController _scrollController = new ScrollController();
//页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  DoctorVideoInfoInfo _doctorVideoInfoInfo;

  ///点赞收藏相关==================================
  bool _isLike,_isCollect; // 点赞 和 收藏 之前的状态
  String _cancelLike,_cancelCollect;// 取消点赞和收藏的ID
  ///=============================================


  ///评论相关==================================
  int _commentPage = 1;
  CommentListInfo _commentListInfo;
  String _content; // 评论的内容
  ///=============================================


  /// 播放器设置
     FijkPlayer player = FijkPlayer();

  StreamSubscription changeSubscription;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    loadData(widget.id);
    initPlayerSetting();
    changeSubscription =  eventBus.on<DoctorVideoInfoInfoVideoList>().listen((event) {
      setState(() {
          loadData(event.id.toString());
      });
    });
    
    

  }

  @override
  void dispose() {
    //  FlutterUmplus.endPageView(runtimeType.toString());
    super.dispose();
    player.release();
    player = null;
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


  ///
  ///  请求数据
  ///
  void loadData(String id) async{


    Future.wait([

      // 当前页面的数据
      NetUtils.requestVideosInfo(id),
      // 收藏的状态
      NetUtils.requestCollectCheckStatus(AppRequest.PAGE_ROUTE_DOCTOR_VIDEO_INFO,widget.id),
      // 点赞的状态
      NetUtils.requestGoodCheckStatus(AppRequest.PAGE_ROUTE_DOCTOR_VIDEO_INFO,widget.id),
      // 评论列表
      NetUtils.requestCommentLists(UserUtils.getUserInfoX().id.toString(),AppRequest.PAGE_ROUTE_DOCTOR_VIDEO_INFO,widget.id,_commentPage.toString())

    ]).then((results) async {

      if(results[0].code==200){
        _doctorVideoInfoInfo = DoctorVideoInfoInfo.fromJson(results[0].info);
        if(player.state==FijkState.idle){
          player.setDataSource(_doctorVideoInfoInfo.playUrl, autoPlay: true);
        }else{
          player.reset().then((_){
            player.setDataSource(_doctorVideoInfoInfo.playUrl, autoPlay: true);
          });
        }
      }else{
        FLToast.error(text: results[0].msg);

      }

      if(results[1].code==200){
        StatusInfo   info =  StatusInfo.fromJson((results[1].info));
        int  status = info.status;
        _cancelCollect = info.id.toString();
        status==1?_isCollect = true : _isCollect = false;
      }


      if(results[2].code==200){
        StatusInfo   info =  StatusInfo.fromJson(results[2].info);
        int  status = info.status;
        _cancelLike = info.id.toString();
        status==1?_isLike = true : _isLike = false;
      }


      if(results[3].code==200){
        _commentListInfo =  CommentListInfo.fromJson(results[3].info);
      }


      setState(() {
        _layoutState = loadStateByCode(results[0].code);
      });

    });

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 1080, height: 1920);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: getCommonAppBar(context,"专家视频"),
      body:  LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          this.loadData(widget.id);
        },
        successWidget:_doctorVideoInfoInfo==null?Container(): Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            //主要内容布局
            buildContextView(context),
            // 底部评论的布局
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
      child:Column(

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
      height: setH(600),
      color: Colors.blue,
      child: FijkView(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        player: player,
      ),
    );

  }

  // 视频信息 简介
    buildContentInfoView(BuildContext context) {

    return Container(
      child: Column(

        children: <Widget>[

          new Container(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30),0, ScreenUtil().setWidth(30),ScreenUtil().setWidth(0)),
            margin: EdgeInsets.only(top: setH(15)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(_doctorVideoInfoInfo.title??"", style: TextStyle(color: Color(0xFF333333),
                      fontSize: ScreenUtil().setSp(40),
                      fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.start,),
                  width: ScreenUtil().setWidth(1000),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_doctorVideoInfoInfo.createTime, style: TextStyle(
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
                cYM(ScreenUtil().setHeight(10)),
                Visibility(
                    visible: _showTipContent,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(child:  Text(_doctorVideoInfoInfo.desc??"", style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: ScreenUtil().setSp(35)),),)
                      ],
                    )
                )

              ],
            ),

          ),




        ],

      ),

    );


  }

  // 分割线
  buildLine() {
    return Container(
      height: ScreenUtil().setHeight(12),
      color: Color(0xFFf5f5f5),
    );

  }

  buildListView(BuildContext context) {

    return Expanded(child:SmartRefresher(
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
            // 视频简介
            buildContentInfoView(context),
            // 观看人数 点赞收藏
            buildBtnView(context),
            //分割线
            buildLine(),
            //相关专家
            _doctorVideoInfoInfo.users==null?Container():getRowTextView("相关专家"),
            _doctorVideoInfoInfo.users==null?Container(): buildDoctorListView(context),
            _doctorVideoInfoInfo.users==null?Container(): buildLine(),
            // 关键词
            buildCruxView(context),
            buildLine(),
            //相关学会
            //   getRowTextView("相关学会"),
            //  buildLearnView(context),
            //  buildLine(),
            // 推荐视频
            getRowTextView("专家视频"),
            buildLiveNoticeView(viewTypeMy),
            //评论
            getRowTextView("全部评论"),
            buildCommentView(context),


          ],

        ),

    ) );

  }

  buildCruxView(BuildContext context) {

    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29),setH(12), ScreenUtil().setWidth(12), setH(29)),
      height: setH(120),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Text("关键词",style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),

         ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
            scrollDirection: Axis.horizontal,
            itemCount: _doctorVideoInfoInfo.keywords.length,
            itemBuilder: (context,page){
              return    new  Container(
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(40),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12)))
                ),
                child: Text(_doctorVideoInfoInfo.keywords[page],style: TextStyle(color: Colors.black45,fontSize: ScreenUtil().setSp(35)),),
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
      color: Colors.white,
      height: ScreenUtil().setHeight(120),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29), 0, ScreenUtil().setWidth(29), 0),
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
              type=="专家视频"?   RRouter.push(context, Routes.doctorVideoListPage,{}):
                FLToast.info(text: "暂无更多内容");
            },

          ),

        ],


      ),

    );

  }
  ///
  ///  直播预告布局
  ///
  Widget buildLiveNoticeView(int viewType){

    return _doctorVideoInfoInfo.videoList==null?Container():viewType==0?GridView.count(
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(10),
      //GridView内边距
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29), 0, ScreenUtil().setWidth(29), 0),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: _doctorVideoInfoInfo.videoList.getRange(0,_doctorVideoInfoInfo.videoList.length).map((item) => itemVideoView(item)).toList(),
    ): ListView.separated(
        shrinkWrap: true ,
        padding: EdgeInsets.all(0),
        physics: new NeverScrollableScrollPhysics(),
        itemCount: _doctorVideoInfoInfo.videoList.length,
        itemBuilder: (context,index){
          return getLiveItemView(context,_doctorVideoInfoInfo.videoList[index]);
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
  Widget itemVideoView(DoctorVideoInfoInfoVideoList bean) {


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
            Image.network(wrapAssets(bean.image),width: ScreenUtil().setWidth(501),height: ScreenUtil().setHeight(288),fit: BoxFit.fill,),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(bean.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(bean.createTime,style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  Text(bean.pv.toString()+"次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
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
  Widget getLiveItemView(context,DoctorVideoInfoInfoVideoList listBean){

    return  GestureDetector(

      onTap: (){
        //  RRouter.push(context, Routes.videoDetailsPage,{"reviewId":listBean.id});

     //   RRouter.push(context, Routes.doctorVideoInfoPage,{"id": listBean.id.toString()});

        eventBus.fire(listBean);


      },

      child: new Container(
        height: ScreenUtil().setHeight(250),
        padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(27), ScreenUtil().setHeight(27), 0,  ScreenUtil().setHeight(40)),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            // Icon(Icons.apps,size: 110,color: Colors.blueAccent,),
            //  wrapImageUrl(listBean.image,110.0, 110.0),
            Image.network(listBean.image,fit: BoxFit.fill,height: ScreenUtil().setHeight(215),width:ScreenUtil().setWidth(288)),
            //  new Image(image: new CachedNetworkImageProvider("http://via.placeholder.com/350x150"),width: 110,height: 110,color: Colors.black,),
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
                        //    Image.asset(wrapAssets("tab/tab_live_ic2.png"),width: ScreenUtil().setSp(32),height: ScreenUtil().setSp(32),color: Colors.black45,),
                        //    cXM(5),
                            Text(listBean.pv.toString()+"次播放",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
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
                            Text(listBean.createTime,style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
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
  ///  专家信息
  ///
  Widget buildDoctorListView(BuildContext context) {

    return InkWell(

      onTap: (){
        RRouter.push(context, Routes.doctorDetailsPage,{"userId":_doctorVideoInfoInfo.users.id});
      },

      child: Container(
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, 0, 0),
        height: ScreenUtil().setHeight(260),

        child:  new Row(
          children: <Widget>[
            wrapImageUrl(_doctorVideoInfoInfo.users.userPhoto, setW(250), setW(245)),
            cXM(ScreenUtil().setWidth(62)),
            new  Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        Text(_doctorVideoInfoInfo.users.realName??"",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
                        cXM(ScreenUtil().setWidth(56)),
                        //  Text(_doctorVideoInfoInfo.users.job.name==null?"":_doctorVideoInfoInfo.users.job.name,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w400),),
                        cXM(ScreenUtil().setWidth(32)),
                        Container(
                          height: ScreenUtil().setHeight(43),
                          padding: EdgeInsets.fromLTRB(setW(10), 0, setW(10), 0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Color(0xFF4AB1F2),
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(22))),
                          ),
                          child: Text(_doctorVideoInfoInfo.users.job==null?"":_doctorVideoInfoInfo.users.job.name,style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(32)),),
                        )

                      ],

                    ),
                    cYM(ScreenUtil().setHeight(16)),
                    Text(_doctorVideoInfoInfo.users.hospital==null?"":_doctorVideoInfoInfo.users.hospital.name,style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),)
                  ],

                )
            ),
            cXM(ScreenUtil().setWidth(50)),

          ],
        ),


      ),

    );


  }

  Widget buildItemDoctorView(BuildContext context,LiveInfoAuthor bean) {

    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
      width: ScreenUtil().setWidth(200),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          wrapImageUrl(bean.userPhoto, setW(200), setW(200)),
          Text(bean.realName,style: TextStyle(fontWeight: FontWeight.w600,fontSize: ScreenUtil().setSp(35)),),
          Text("介绍",style: TextStyle(fontSize: ScreenUtil().setSp(30)),)


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
  ///  评论布局
  ///
  buildCommentView(BuildContext context) {

    return _commentListInfo==null?Container(): ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29), 0, ScreenUtil().setWidth(29), 0),
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
        height: ScreenUtil().setHeight(140),
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
                              text: _commentListInfo.lists[index].userName+": ",
                              style: TextStyle(color: Colors.blue,fontSize: ScreenUtil().setSp(35))
                          ),
                          TextSpan(
                              text: _commentListInfo.lists[index].content,
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
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setWidth(10), 0, 0),
        height: ScreenUtil().setHeight(340),
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: <Widget>[
           new Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(270),
              height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  cYM(ScreenUtil().setHeight(20)),
                 Container(
                   width: ScreenUtil().setWidth(230),
                   child:    Text("严重烧伤液体复苏有何不可",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),textAlign: TextAlign.center,maxLines: 2,),
                 ),
                 cYM(ScreenUtil().setHeight(20)),
                   new  Row(
                     children: <Widget>[
                        Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(6),)),
                        Container(
                          width: ScreenUtil().setWidth(26),
                          height: ScreenUtil().setWidth(26),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
                            border: Border.all(color: Color(0xFF999999))
                          ),
                        ),
                        Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(6),)),

                     ],
                   ),
                  cYM(ScreenUtil().setHeight(20)),
                    Image.asset(wrapAssets("user/avatar.png"),width: ScreenUtil().setWidth(81),height: ScreenUtil().setWidth(81),),
                  cYM(ScreenUtil().setHeight(22)),
                    Text("孙黄力",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),)

                ],
              ),
            ),
           new Container(
             alignment: Alignment.center,
             width: ScreenUtil().setWidth(320),
             height: double.infinity,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 cYM(ScreenUtil().setHeight(20)),
                 Container(
                   width: ScreenUtil().setWidth(230),
                   child:    Text("严重烧伤液体复苏有何不可",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),textAlign: TextAlign.center,maxLines: 2,),
                 ),
                 cYM(ScreenUtil().setHeight(20)),
                 new  Row(
                   children: <Widget>[
                     Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(6),)),
                     Container(
                       width: ScreenUtil().setWidth(26),
                       height: ScreenUtil().setWidth(26),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
                           border: Border.all(color: Color(0xFF999999))
                       ),
                     ),
                     Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(6),)),

                   ],
                 ),
                 cYM(ScreenUtil().setHeight(20)),
                 Image.asset(wrapAssets("user/avatar.png"),width: ScreenUtil().setWidth(81),height: ScreenUtil().setWidth(81),),
                 cYM(ScreenUtil().setHeight(22)),
                 Text("孙黄力",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),)

               ],
             ),
           ),
           new Container(
             alignment: Alignment.center,
             width: ScreenUtil().setWidth(320),
             height: double.infinity,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 cYM(ScreenUtil().setHeight(20)),
                 Container(
                   width: ScreenUtil().setWidth(230),
                   child:    Text("严重烧伤液体复苏有何不可",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),textAlign: TextAlign.center,maxLines: 2,),
                 ),
                 cYM(ScreenUtil().setHeight(20)),
                 new  Row(
                   children: <Widget>[
                     Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(6),)),
                     Container(
                       width: ScreenUtil().setWidth(26),
                       height: ScreenUtil().setWidth(26),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
                           border: Border.all(color: Color(0xFF999999))
                       ),
                     ),
                     Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(6),)),

                   ],
                 ),
                 cYM(ScreenUtil().setHeight(20)),
                 Image.asset(wrapAssets("user/avatar.png"),width: ScreenUtil().setWidth(81),height: ScreenUtil().setWidth(81),),
                 cYM(ScreenUtil().setHeight(22)),
                 Text("孙黄力",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),)

               ],
             ),
           ),
           new Container(
             alignment: Alignment.center,
             width: ScreenUtil().setWidth(320),
             height: double.infinity,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 cYM(ScreenUtil().setHeight(20)),
                 Container(
                   width: ScreenUtil().setWidth(230),
                   child:    Text("严重烧伤液体复苏有何不可",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),textAlign: TextAlign.center,maxLines: 2,),
                 ),
                 cYM(ScreenUtil().setHeight(20)),
                 new  Row(
                   children: <Widget>[
                     Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(6),)),
                     Container(
                       width: ScreenUtil().setWidth(26),
                       height: ScreenUtil().setWidth(26),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
                           border: Border.all(color: Color(0xFF999999))
                       ),
                     ),
                     Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(6),)),

                   ],
                 ),
                 cYM(ScreenUtil().setHeight(20)),
                 Image.asset(wrapAssets("user/avatar.png"),width: ScreenUtil().setWidth(81),height: ScreenUtil().setWidth(81),),
                 cYM(ScreenUtil().setHeight(22)),
                 Text("孙黄力",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),)

               ],
             ),
           ),
           new Container(
             alignment: Alignment.center,
             width: ScreenUtil().setWidth(320),
             height: double.infinity,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: <Widget>[
                 cYM(ScreenUtil().setHeight(20)),
                 Container(
                   width: ScreenUtil().setWidth(230),
                   child:    Text("严重烧伤液体复苏有何不可",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),textAlign: TextAlign.center,maxLines: 2,),
                 ),
                 cYM(ScreenUtil().setHeight(20)),
                 new  Row(
                   children: <Widget>[
                     Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(6),)),
                     Container(
                       width: ScreenUtil().setWidth(26),
                       height: ScreenUtil().setWidth(26),
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30))),
                           border: Border.all(color: Color(0xFF999999))
                       ),
                     ),
                     Expanded(child:  Divider(color: Colors.black26,height: ScreenUtil().setHeight(6),)),

                   ],
                 ),
                 cYM(ScreenUtil().setHeight(20)),
                 Image.asset(wrapAssets("user/avatar.png"),width: ScreenUtil().setWidth(81),height: ScreenUtil().setWidth(81),),
                 cYM(ScreenUtil().setHeight(22)),
                 Text("孙黄力",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),)

               ],
             ),
           ),

          ],
        ),


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

          Expanded(child: buildText(_doctorVideoInfoInfo.pv==null?"0次播放":_doctorVideoInfoInfo.pv.toString()+"次播放",color: "#FF999999"),),

          Row(

            children: <Widget>[
              LikeButton(
                isLiked: _isCollect,
                likeBuilder: (bool isLike){

                  return  !isLike?Image.asset(wrapAssets("icon_collect_cancel.png"),width: setW(25),height: setH(25),):
                  Image.asset(wrapAssets("icon_collect.png"),width: setW(25),height: setH(25),);
                },
                onTap: (bool isLiked)
                {
                  return onCollectButtonTap(isLiked,_doctorVideoInfoInfo.id.toString());
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

                  return  !isLike?Image.asset(wrapAssets("icon_dz_cancel.png"),width: setW(25),height: setH(25),):
                  Image.asset(wrapAssets("icon_dz.png"),width: setW(25),height: setH(25),);
                },
                onTap: (bool isLiked)
                {
                  return onLikeButtonTap(isLiked,_doctorVideoInfoInfo.id.toString());
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

      NetUtils.requestGoodAdd(AppRequest.PAGE_ROUTE_DOCTOR_VIDEO_INFO,id)
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

      NetUtils.requestCollectAdd(AppRequest.PAGE_ROUTE_DOCTOR_VIDEO_INFO,id)
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

    NetUtils.requestCommentAdd(AppRequest.PAGE_ROUTE_DOCTOR_VIDEO_INFO, widget.id, value)
        .then((res){
           showToast(res.msg);
          if(res.code==200){

            // 评论列表
            NetUtils.requestCommentLists(UserUtils.getUserInfoX().id.toString(),AppRequest.PAGE_ROUTE_DOCTOR_VIDEO_INFO,widget.id,_commentPage.toString())
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
  ///  设置参数  优化视频播放加载速度
  ///
  Future<void> initPlayerSetting() async {


    await player.applyOptions(
        FijkOption()
          ..setFormatOption('flush_packets', 1)
          ..setFormatOption('analyzemaxduration', 100)
          ..setFormatOption('analyzeduration', 1)
          ..setCodecOption('skip_loop_filter', 48)
          ..setPlayerOption('start-on-prepared', 1)
          ..setPlayerOption('packet-buffering', 0)
          ..setPlayerOption('framedrop', 1)
          ..setPlayerOption('enable-accurate-seek', 1)
          ..setPlayerOption('find_stream_info', 0)
          ..setPlayerOption('render-wait-start', 1)
    );

  }

  void _onLoading() async{
    _commentPage ++;
    loadMoreData();
  }

  ///
  ///  加载更多评论
  ///
  void loadMoreData() {

    // 评论列表
    NetUtils.requestCommentLists(UserUtils.getUserInfoX().id.toString(),AppRequest.PAGE_ROUTE_DOCTOR_VIDEO_INFO,widget.id,_commentPage.toString())
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
