import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/ui/task/bean/task_list_entity.dart';
import 'package:yqy_flutter/ui/user/bean/integral_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
///   任务列表
///
class TaskListPage extends StatefulWidget {

  String id;


  TaskListPage(this.id);

  @override
  _TaskListPageState createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {


  TaskListInfo _taskListInfo;

  String _currentTask;  // 已完成的任务数量

  String _allTaskCount; // 总任务数量

  String _allPoints; // 总积分数量
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("任务列表"),

      ),

      body: Column(

       children: <Widget>[

         buildTopView(context),
         _taskListInfo==null?Container(): buildTaskListView(context)

       ],




      ),



    );
  }



  buildTopView(BuildContext context) {

     return Container(
       color: Colors.white,
        padding: EdgeInsets.fromLTRB(setW(30), 0, setW(30), 0),
        height: setH(200),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    buildText("当前任务（$_currentTask / $_allTaskCount ）",color: "#FF333333",size: 40,fontWeight: FontWeight.bold),
                    cYM(setH(12)),
                    buildText("完成全部视频观看任务即可领取$_allPoints积分",size: 32,color: "#FF999999")
                  ],
                ),
            
              //  buildText("显示未完",color: "#FF999999",size: 32)
            
          ],


        ),

     );

  }

  buildTaskListView(BuildContext context) {

    return ListView.builder(
        shrinkWrap: true,
        itemCount: _taskListInfo.taskList.length,
        itemBuilder: (context,index){
      return buildItemView(context,_taskListInfo.taskList[index]);

    });

  }

  buildItemView(BuildContext context,TaskListInfoTaskList bean) {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(setW(30), 0, setW(30), 0),
      height: setH(140),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Expanded(child:    new  Row(

            children: <Widget>[

              Container(
                width: setW(80),
                height: setW(80),
                alignment: Alignment.center,
                decoration: BoxDecoration(

                    gradient: LinearGradient(colors: [Color(0xFF87C8FE),Color(0xFF65B2FA),Color(0xFF66A6FF)]),
                    borderRadius: BorderRadius.all(Radius.circular(30))

                ),
                child: Text(bean.points.toString(),style: TextStyle(color: Colors.white,fontSize: setSP(37),fontWeight: FontWeight.bold),),
              ),
              cXM(setW(30)),
              Expanded(child: buildText(bean.title,size: 37,color: "#FF333333")),

              InkWell(
                //  根据任务类型不同  跳转不同的页面
                onTap: (){

                  switch(bean.type){

                    case 0:

                      break;
                    case 1:

                      break;

                  }

                },
                child:   Container(
                  width: setW(190),
                  height: setH(52),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(26)),
                      border: Border.all(color: Color(0xFF4AB1F2),width: setW(1))

                  ),

                  child: Text(getTextStatus(bean.status),style: TextStyle(color: Color(0xFF4AB1F2),fontSize: setSP(35)),),

                ),

              )

            ],
          ),),
          new Container(
             margin: EdgeInsets.only(left: setW(110),right: setW(27) ),
            color: Color(0xFFEEEEEE),
            height: setH(2),
            
          )


        ],
      )


    );

  }


  // 0未开始 1去完成 2领取奖励 3已完成 4已过期
  String getTextStatus(int status) {
    String v;

    switch(status){
      case 0:
        v = "未开始";
        break;
      case 1:
        v = "去完成";
        break;
      case 2:
        v = "领取奖励";
        break;
      case 3:
        v = "已完成";
        break;
      case 4:
        v = "已过期";
        break;
    }
    return v;

  }
  void initData() {

    NetUtils.requestPointsTaskChildList(widget.id)
        .then((res){

          if(res.code==200){

          setState(() {
            _taskListInfo =  TaskListInfo.fromJson(res.info);

             _currentTask = _taskListInfo.completeTask.toString();  // 已完成的任务数量

             _allTaskCount = _taskListInfo.allTask.toString(); // 总任务数量

             _allPoints = _taskListInfo.points.toString(); // 总积分数量

          });


          }


    });

  }
}
