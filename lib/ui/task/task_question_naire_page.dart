import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_umplus/flutter_umplus.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/bean/base_result_entity.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/task/bean/question_task_entity.dart';
import 'package:yqy_flutter/ui/task/bean/task_question_entity.dart';
import 'package:yqy_flutter/ui/task/bean/upload_naire_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';


class TaskQuestionNairePage extends StatefulWidget {
  String tid;


  TaskQuestionNairePage(this.tid);

  @override
  _TaskQuestionNairePageState createState() => _TaskQuestionNairePageState();
}



class _TaskQuestionNairePageState extends State<TaskQuestionNairePage> {


  List seleValues;

  List seleValues2; // 每个问题的ID  提交数据时用到

  QuestionTaskInfo _questionInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterUmplus.beginPageView(runtimeType.toString());
    loadData();

  }


  @override
  void dispose() {
    FlutterUmplus.endPageView(runtimeType.toString());
    // TODO: implement dispose
    super.dispose();

  }

  void loadData() {

    NetUtils.requestPointsQuestionTask(widget.tid)
        .then((res){


      if(res.code==200){
        _questionInfo = QuestionTaskInfo.fromJson(res.info);
        seleValues  = new List(_questionInfo.questionList.length);
        seleValues2  = new List(_questionInfo.questionList.length);
        seleValues.fillRange(0,seleValues.length,-1);
        setState(() {

        });
      }

    });


  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(_questionInfo==null?"调查问卷":_questionInfo.title,style: TextStyle(fontSize: setSP(50)),),
        centerTitle: true,
      ),

      body:seleValues==null||_questionInfo==null?Container():ListView(

        children: <Widget>[
          cYM(15),
          ListView.builder(
            padding: EdgeInsets.only(right: setW(30)),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,//内容适配
            itemCount: _questionInfo.questionList.length,
            itemBuilder: (context,index){
              return buildItemView(index);
            },
          ),
          buildBtnView(context)


        ],
      )


    );
  }

  Widget buildItemView(int firstIndex) {


    return Column(

        children: <Widget>[

        new  Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              cXM(15),
               new Container(
                  width: setW(180),
                  height: setH(100),
                  child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                          Image.asset(wrapAssets("icon_question_bg.png"),width: double.infinity,height: double.infinity,),
                          Text(_questionInfo.questionList[firstIndex].type==1?"单选":"多选",style: TextStyle(color: Colors.white,fontSize: setSP(36)),)
                      ],
                  ),
                ),
                cXM(10),
                Expanded(child:  Text(_questionInfo.questionList[firstIndex].title,style: TextStyle(fontSize: setSP(45),fontWeight: FontWeight.w900),),),
            ],
          ),
        cYM(10),
        new  ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,//内容适配
          itemCount: _questionInfo.questionList[firstIndex].content.length,
          itemBuilder: (c,index){
            return  buildAnswerItemView(firstIndex,index,_questionInfo.questionList[firstIndex].id.toString());
          },

        ),
          cYM(30)

        ],

    );

  }

  ///
  ///   firstIndex 表示在列表的是第几个
  ///    index  表示 当前是第几个选项
  ///
  Widget buildAnswerItemView(int firstIndex,int index,String queId) {

    return FlatButton(
        onPressed: (){
          setState(() {
            seleValues[firstIndex] = index;
            seleValues2[firstIndex] = queId;
          });
        },
        child: buildAnswerTextStatus(seleValues[firstIndex],firstIndex,index),
    );

  }


  ///  返回  单选  当前选项的状态
  Widget  buildAnswerTextStatus(int seleValue,int firstIndex, int index) {

    return  Container(
      height: 45,
      width: double.infinity,
      color: index%2!=0?Colors.white: Colors.brown[50],
      child: Row(
        children: <Widget>[
          cXM(55),
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color:seleValue==index?Colors.blue:Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30)),
                border: Border.all(color: Colors.black12)
            ),
            height: 22,
            width: 22,
            child: Text(buildOptionValue(index),style: TextStyle(color:seleValue==index?Colors.white:Colors.black ),)
          ),
          cXM(20),

          Expanded(child:
          Text(_questionInfo.questionList[firstIndex].content[index],style: TextStyle(color:seleValue==index?Colors.blue:Colors.black ,fontSize: 14),)
          )




        ],
      ),

    );


  }

  String buildOptionValue(int j) {

    String value;

    if (j==0){
      value="A";
    }else if (j==1){
      value="B";
    }else if (j==2){
      value="C";
    }else if (j==3){
      value="D";
    }else if (j==4){
      value="E";
    }else if (j==5){
      value="F";
    }else if (j==6){
      value="G";
    }else if (j==7){
      value="H";
    }else if (j==8){
      value="I";
    }else if (j==9){
      value="J";
    }else if (j==10){
      value="K";
    }else {
      value="O";
    }
  
    return value;

  }


  ///
  ///  提交按钮
  Widget  buildBtnView(BuildContext context) {

    return FlatButton(
        onPressed: (){

          submissionData(context);

        },
        child: Container(
          margin: EdgeInsets.fromLTRB(15, 20, 15, 40),
          decoration: BoxDecoration(
              color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(6))
          ),
          alignment: Alignment.center,
          height: 50,
          width: double.infinity,
          child: Text("提交",style: TextStyle(color: Colors.white),),

        )
    );

  }


  ///
  ///  提交数据
  ///
  Future submissionData(BuildContext context) async {

    bool result = seleValues.any((element)=>(element==-1)); // 判断当前每道题是否都已经选择完成


    if(result){
        showToast("当前还有题目未选择答案！");
        return;
    }

/*
    List<answer>  answerList = new List();

    int i = 0;
    seleValues.forEach((element){//遍历每个元素  此时不可add或remove  否则报错 但可以修改元素值，
        answerList.add(new answer(id:seleValues2[i],value: element.toString() ));
        i++;
    });*/


   Map<String,String>  answerMap = new Map();

    int i = 0;
    seleValues.forEach((element){//遍历每个元素  此时不可add或remove  否则报错 但可以修改元素值，
      answerMap[seleValues2[i].toString()] = (element+1).toString();
      i++;
    });


 //   UploadQuestionBean questionBean = new UploadQuestionBean(tid: widget.tid,token: UserUtils.getToken(),answe: answerMap);

    NetUtils.requestPointsCompleteQuestionTask({"tid": widget.tid,"answer":answerMap})
        .then((res){


      if(res.code==200){

      //  eventBus.fire(new EventBusChange(res.code));

        showReceiveDialogView(context,res.info["points"],res.info["msg"]);


      }


    });





  }

  ///
  ///  积分领取成功弹窗
  ///
  void showReceiveDialogView(BuildContext context,var nums,String msg) {

    showDialog(context: context,

        builder: (_)=>Material(
          color: Colors.transparent,
          child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(setW(40), setW(650), setW(40), setW(900)),
              child: Stack(

                children: <Widget>[
                  Image.asset(wrapAssets("task/bg_finish.png"),width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                  Positioned(left: setW(200),top: setH(260),child: Text("您已获得 "+nums.toString()+" 积分",style: TextStyle(color: Colors.white,fontSize: setSP(75),fontWeight: FontWeight.w900,fontStyle: FontStyle.italic),)),
                  Positioned(left: setW(175),bottom: setH(20),child: Container(
                    width: setW(600),
                    margin: EdgeInsets.fromLTRB(setW(20),0, 0, setW(20)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Expanded(child:  Text(msg,style: TextStyle(color: Colors.white,fontSize: setSP(40))))

                      ],

                    ),

                  ))


                ],

              )

          ),


        )
    );

    Future.delayed(Duration(seconds: 2)).then((_){

      Navigator.pop(context);
      Navigator.pop(context);

    });



  }

}
