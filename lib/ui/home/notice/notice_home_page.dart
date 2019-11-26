import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/home/notice/bean/notice_home_entity.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/utils/margin.dart';

class NoticeHomePage extends StatefulWidget {
  @override
  _NoticeHomePageState createState() => _NoticeHomePageState();
}

class _NoticeHomePageState extends State<NoticeHomePage> {




  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  int page = 1;

  NoticeHomeEntity  _noticeHomeEntity ;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }



  void _onRefresh() async{
    // monitor network fetch
    //   await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    page = 1;
    loadData();
  }

  void _onLoading() async{
    page ++;
    loadData();
  }



  loadData() {
    NetworkUtils.requestMessageList(page.toString())
        .then((res){

      int statusCode = int.parse(res.status);

      if(statusCode==9999){

        if(page>1){

          if (NoticeHomeEntity
              .fromJson(res.info)
              .page=="0") {
            _refreshController.loadNoData();
          } else {
            _noticeHomeEntity.list.addAll(NoticeHomeEntity.fromJson(res.info).list);
            _refreshController.loadComplete();
          }

        }else{
          _noticeHomeEntity = NoticeHomeEntity.fromJson(res.info);

          print("打印的结果："+_noticeHomeEntity.toJson().toString());

          _refreshController.refreshCompleted();
          _refreshController.resetNoData();
        }

      }

      setState(() {

        _layoutState = loadStateByCode(statusCode);
      });




    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(

          title: Text("系统通知"),
          centerTitle: true,

        ),
      body:  LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        this.loadData();
      },
      successWidget:
      _noticeHomeEntity==null||_noticeHomeEntity.list==null?Center(child: Text("暂无消息"),):AnimationLimiter(
        child:SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: ListView.builder(
            //  itemCount: _noticeHomeEntity.list.length,
              itemCount: 5,
              itemBuilder: (context,index){
                return  AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 1000),
                  child: FadeInAnimation(
                    child: getNoticeItemView(context,_noticeHomeEntity.list[index]),
                  ),

                );

              }
          ),

        ),
      ),

    ),


    );
  }

  getNoticeItemView(BuildContext context, NoticeHomeList bean) {

    return bean==null?Container(): Container(
        margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(50), ScreenUtil().setHeight(30), ScreenUtil().setWidth(50), 0),
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(25), 0, 0, ScreenUtil().setWidth(25)),
        width: double.infinity,
        height: ScreenUtil().setHeight(400),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(18))),
          color: Colors.white
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(bean.title,style: TextStyle(fontSize: ScreenUtil().setSp(45),color: Colors.black54),),
            Text(bean.msgContent),
            Container(
              margin: EdgeInsets.only(right: ScreenUtil().setWidth(25)),
              alignment: Alignment.centerRight,
              width: double.infinity,
              child: Text(bean.createTime,style: TextStyle(color: Colors.black26),),

            )
          ],
          
        ),
        


    );


  }
}

