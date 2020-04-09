import 'dart:convert';

import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/user/follow/bean/flow_doctor_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

///
///   粉丝列表
///
///
class FansDoctorPage extends StatefulWidget {
  @override
  _FansDoctorPageState createState() => _FansDoctorPageState();
}

class _FansDoctorPageState extends State<FansDoctorPage> {

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  int page = 1;

  FlowDoctorEntity _flowDoctorInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void _onRefresh() async{
    page = 1;
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    initData();
  }

  void _onLoading() async{
    page ++;
    initData();
  }


  @override
  Widget build(BuildContext context) {

    return  Scaffold(

      appBar: getCommonAppBar("我的粉丝"),

      body:  new LoadStateLayout(
        state: _layoutState,
        errorRetry: () {
          setState(() {
            _layoutState = LoadState.State_Loading;
          });
          this.initData();
        },
        successWidget:_flowDoctorInfo==null||_flowDoctorInfo.info.length==0?Center(child: Text("暂无数据"),):
        SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            controller: _refreshController,
            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child:
            ListView.separated(
              shrinkWrap: true,
              itemCount: _flowDoctorInfo.info.length,
              itemBuilder: (context,index){

                return itemListView(_flowDoctorInfo.info[index]);

              },
              separatorBuilder: (context,index){

                return Container(
                  height: setH(1),
                  color: Colors.black26,

                );

              },
            )

        ),




      ),

    );

  }

  Widget itemListView(FlowDoctorInfo bean) {

    return InkWell(
      onTap: (){
        RRouter.push(context, Routes.doctorDetailsPage,{"userId":bean.info.id});
      },
      child: new Container(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(27), setH(10), ScreenUtil().setWidth(59), 0),
          child: Column(

            children: <Widget>[
              new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  wrapImageUrl(bean.info.img, setW(196), setH(196)),
                  cXM(ScreenUtil().setWidth(62)),
                  new  Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Row(
                            children: <Widget>[
                              Text(bean.info.realName,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
                              cXM(ScreenUtil().setWidth(56)),
                              //Text(bean.info.,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w400),),
                              // cXM(ScreenUtil().setWidth(32)),
                              Container(
                                width: ScreenUtil().setWidth(153),
                                height: ScreenUtil().setHeight(43),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4AB1F2),
                                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(22))),
                                ),
                                child: Text(bean.info.departs==null?"未知":bean.info.departs.name,style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(32)),),
                              )

                            ],

                          ),
                          cYM(ScreenUtil().setHeight(16)),
                          Text(bean.info.hospital==null?"":bean.info.hospital.name,style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),)
                        ],

                      )
                  ),
                ],
              ),
              cYM(ScreenUtil().setHeight(16)),


            ],
          )

      ),
    );

  }


  void initData() {

    NetUtils.requestUsersMyFans(page)
        .then((res){

      if(res.code==200){

        setState(() {
          _flowDoctorInfo =   FlowDoctorEntity.fromJson(res.toJson());
          if(page==1){

            _layoutState = loadStateByCode(res.code);
            _refreshController.refreshCompleted();

          }else{

              if(_flowDoctorInfo.info.length==0){

                _refreshController.loadNoData();
              }else{

                _flowDoctorInfo.info.addAll(FlowDoctorEntity.fromJson(res.toJson()).info);
                _refreshController.loadComplete();

              }

          }

        });

      }

    });

  }





}
