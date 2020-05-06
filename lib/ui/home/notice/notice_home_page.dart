import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/notice/tab/tab_hd_page.dart';
import 'package:yqy_flutter/ui/home/notice/tab/tab_notice_page.dart';
import 'package:yqy_flutter/ui/home/notice/tab/tab_system_page.dart';
import 'package:yqy_flutter/ui/user/bean/message_entity.dart';
import 'package:yqy_flutter/utils/DateUtils.dart';
import 'package:yqy_flutter/utils/margin.dart';


class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

final _tabDataList = <_TabData>[
  _TabData(tab: Text('系统消息'), body: TabSystemPage()),
  _TabData(tab: Text('公告通知'), body: TabNoticePage()),
  _TabData(tab: Text('互动'), body: TabHDPage()),
  // _TabData(tab: Text('规范解读'), body: TabGFPage())
];



class NoticeHomePage extends StatefulWidget {
  @override
  _NoticeHomePageState createState() => _NoticeHomePageState();
}

class _NoticeHomePageState extends State<NoticeHomePage> with SingleTickerProviderStateMixin {

/*  final tabBarList = _tabDataList.map((item) => item.tab).toList();
  final tabBarViewList = _tabDataList.map((item) => item.body).toList();*/
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  //TabController _tabController;
  Info mesage_entity;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // _tabController = TabController(vsync: this, length: tabBarList.length);
    initData();

  }

  void _onRefresh() async{
    page = 1;
    initData();
  }

  void _onLoading() async{
    page ++;
    initData();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text("消息",style: TextStyle(fontSize: 18,color: Colors.black)),
        leading: InkWell(

            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.black54,)

        ),
        actions: <Widget>[
           InkWell(
             onTap: (){

               sendRequestReadMsg(context);

             },
             child:  Container(
               alignment: Alignment.center,
               margin: EdgeInsets.only(right: setW(30)),
               height: double.infinity,
               child:   Text("全部已读",style: TextStyle(color: Color(0xff999999)),),

             ),

           )
        ],

      ),

      body: mesage_entity == null? Container(): SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child:

          ListView.separated(itemCount:mesage_entity.info.length ,itemBuilder: (context,index){

            return  getNoticeItemView(context,mesage_entity.info[index]);

          },separatorBuilder: (context,index){

            return Container(
              height: setH(1),
              color: Colors.black12,
            );

          },)

      ),
      
    );
  }


  ///
  ///  请求 消息的列表数据
  ///
  void initData() {


    NetUtils.requestUserMsg(page)
        .then((res){

          if(res.code==200) {
            if (page > 1) {
              if (Info
                  .fromJson(res.info)
                  .info
                  .length == 0 || Info
                  .fromJson(res.info)
                  .info == null) {
                _refreshController.loadNoData();
              } else {
                mesage_entity.info.addAll(Info
                    .fromJson(res.info)
                    .info);
                _refreshController.loadComplete();
              }
            } else {
              mesage_entity = Info.fromJson(res.info);
              _refreshController.refreshCompleted();
              _refreshController.resetNoData();
            }
          }
          setState(() {

          });

    });

  }


  ///
  ///  全部已读请求
  ///
  void sendRequestReadMsg(BuildContext context) {

      NetUtils.requestUserAllRead()
          .then((res){


            if(res.code==200){

              FLToast.showSuccess(text: res.msg);

            }else{

              FLToast.showError(text: res.msg);

            }

      });

  }
}


///
///  消息item
///
getNoticeItemView(BuildContext context,InfoX bean) {



  return  InkWell(

    onTap: (){

      RRouter.push(context, Routes.noticeDetails, {"id":bean.id.toString(),"title":bean.title,"content":bean.msgContent,"date":bean.createTime.toString()});

    },
    child: Container(

      margin: EdgeInsets.symmetric(horizontal: setW(30)),
      height: setH(220),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[


          Container(
            height: setH(220),
            width: setW(100),
            child:   Image.asset(wrapAssets( bean.msgStatus==0?"notice/icon_notice.png":"notice/icon_notice_read.png"),width: setW(80),height: setW(80),),

          ),

          cXM(setW(30)),
          Expanded(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[

              Row(

                children: <Widget>[
                  buildText("系统消息",size: 46,color: bean.msgStatus==0?"#FF000000":"#FF999999",fontWeight: FontWeight.w500),
                  cXM(setW(15)),
                  buildText( bean.createTime,color:"#FF999999")

                ],
              ),
              cYM(setH(16)),
              Text(bean.title,style: TextStyle(fontSize: setSP(38),color: bean.msgStatus==0?Color(0xFF000000):Color(0xFF999999)),maxLines: 2,overflow: TextOverflow.ellipsis,)

            ],
          )),
          Container(
            height:setH(80),
            padding: EdgeInsets.only(top: setH(30)),
            child:
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                buildText("查看详情",size: 38,color:"#FF999999"),
                Icon(Icons.arrow_forward_ios,color: Color(0xfff999999),size: setW(40),)

              ],

            ),


          )


        ],

      ),

    ),

  );





}
