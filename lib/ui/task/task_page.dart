import 'dart:async';

import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/task/bean/task_list_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/bean/banner_entity.dart';
import 'package:yqy_flutter/utils/user_utils.dart';


  class TaskHome extends StatefulWidget {
    @override
    _TaskHomeState createState() => _TaskHomeState();
  }

  class _TaskHomeState extends State<TaskHome> {


    // 声明一个list，存放image Widget
    List<String> imageList = List();

    BannerEntity _bannerEntity;

    TaskListEntity _listEntity;

    StreamSubscription changeSubscription;

    @override
    void initState() {
      super.initState();
      loadData();
      changeSubscription =  eventBus.on<EventBusChange>().listen((event) {
        setState(() {
          loadData();
        });

      });
    }

    @override
    void dispose() {
      super.dispose();
      changeSubscription.cancel();

    }


    loadData () async {
      Future.wait([
        NetworkUtils.requestBanner("20"),
        NetworkUtils.requestTaskList()

      ]).then((results) {
        int statusCode0 = int.parse(results[0].status);
        int statusCode1 = int.parse(results[1].status);

        if(statusCode0==9999){
          _bannerEntity = BannerEntity.fromJson(results[0].toJson());

        }
        if(statusCode1==9999){
          _listEntity = TaskListEntity.fromJson(results[1].toJson());
        }

        setState(() {

        });

      }).catchError((e) {});
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

        appBar: AppBar(

          centerTitle: true,
          backgroundColor: Colors.white,
          title: new Text(
              "赚取积分", style: TextStyle(color: Colors.black, fontSize: 20)),

        ),

        body: new Column(
          children: <Widget>[
            cYM(5),
            ///轮播图
            getList(),
            cYM(5),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 15),
              width: double.infinity,
              height: 40,
              color: Colors.white,
              child: Text("今日任务"),
            ),
          Expanded(child: Container(
            color: Colors.white,
              padding:EdgeInsets.fromLTRB(20, 0, 10, 0) ,
               child:  buildListView(context),
          ))
          ],

        ),
      );
    }

    Widget getList() {
      return _bannerEntity==null?Container():BannerSwiper(
        //width  和 height 是图片的高宽比  不用传具体的高宽   必传
        height: 108,
        width: 54,
        //轮播图数目 必传
        length: _bannerEntity.info.length,
        autoLoop: _bannerEntity.info.length>1?true:false,
        //轮播的item  widget 必传
        getwidget: (index) {
          return new GestureDetector(
              child: Image.network(
                _bannerEntity.info[index % _bannerEntity.info.length].adFile,
                fit: BoxFit.fill,
              ),
              onTap: () {
                //点击后todo
              });
        },
      );
    }

Widget  buildListView(BuildContext context) {


      return _listEntity==null? Container(): ListView.builder(

          itemBuilder: (context,index){

            return new Container(
              height: 90,
              decoration: BoxDecoration(

                border: Border(bottom: BorderSide(color: Colors.black12,width: 0.5))

              ),
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  buildIconType(_listEntity.info[index].tId),

                  cXM(15),

                new  Expanded(
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          buildTitleType(_listEntity.info[index].tId),
                          cYM(5),
                          Text("完成可得"+_listEntity.info[index].points+"积分",style: TextStyle(color: Colors.black45,fontSize: 14),),
                        ],
                      ),

                  ),

                buildButton(_listEntity.info[index])

                ],
              ),
            );
          },
          itemCount: _listEntity.info.length,


      );

  }

Widget  buildIconType(String t_id) {

  String path;

  if (t_id=="1"){
    path = wrapAssets("icon_task_gk.png");
  }else if (t_id=="2"){
    path = wrapAssets("icon_task_tx.png");
  }else if (t_id=="3"){
    path = wrapAssets("icon_task_sm.png");
  }else{
    path = wrapAssets("icon_task_tx.png");
  }
   return Image.asset(path,width: 50,height: 50,fit: BoxFit.fill,);

  }

Widget  buildTitleType(String t_id) {

  String title;

  if (t_id=="1"){
    title = "视频任务";
  }else if (t_id=="2"){
    title = "问卷调查";
  }else if (t_id=="3"){
    title = "实名认证";
  }else if (t_id=="4"){
    title = "病例收集";
  }else{
    title = "其他任务";
  }
  return Text(title,style: TextStyle(color: Colors.black,fontSize: 15),maxLines: 2,overflow: TextOverflow.ellipsis,);
  }

 Widget buildButton(TaskListInfo info) {

   String status = info.status;

   String text;

   int color = 0xff618FEE;

   switch (status){
     case "0":
       text = "领取";
       break;
     case "1":
       text ="去完成";
       break;
     case "2":
       text ="领积分";
       color = 0xffeeb161;
       break;
     case "3":
       text ="已完成";
       color = 0x61000000;
       break;
     case "-1":
       text ="已过期";
       color = 0xffFF656363;
       break;
   }
   return FlatButton(
       onPressed: (){

         String  status =  info.status;

         if(status=="1"){  //去完成任务

           switch (info.tId){
             case "1": /// 跳转视频任务
               RRouter.push(context, Routes.taskVideoPage,{"tid":info.id});
               break;
             case "2":/// 跳转问卷任务
               RRouter.push(context, Routes.taskQuestionNairePage,{"tid":info.id});
               break;
             case "3": /// 跳转实名任务
             //  1:医生，2:医学代表，3:企业，4：结构，
               switch (UserUtils.getUserInfo().regType) {
                 case "1":
                   RRouter.push(context, Routes.realNamePage,{});
                   break;
                 case "2":
                   break;
                 case "3":
                 case "4":
                   break;
               }
               break;
             default:
               showToast("暂未开放，可以到药企源公众号进行此任务！");
               break;
           }

         }else if(status=="0"){ // 领取任务请求

           NetworkUtils.requestGetTask(info.id)
               .then((res){

                 showToast(res.message);

                 loadData();

           });

         }else if(status=="2"){ // 领取积分请求

           NetworkUtils.requestGetScore(info.id)
               .then((res){

                 showToast(res.message);

                 if(res.status=="9999"){

                   setState(() {
                      loadData();
                   });

                 }

           });


         }

       },
       child: Container(
         alignment: Alignment.center,
         height: 35,
         width: 90,
         decoration: BoxDecoration(
             color: Color(color),
             borderRadius: BorderRadius.all(Radius.circular(6))
         ),
         child: Text(text,style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),

       ));

  }

  }