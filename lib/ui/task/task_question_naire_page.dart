import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/task/bean/task_question_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';


class TaskQuestionNairePage extends StatefulWidget {
  String tid;


  TaskQuestionNairePage(this.tid);

  @override
  _TaskQuestionNairePageState createState() => _TaskQuestionNairePageState();
}



class _TaskQuestionNairePageState extends State<TaskQuestionNairePage> {


  List seleValues;

  TaskQuestionInfo _questionInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }

  void loadData() {

    NetworkUtils.requestTaskQuestion(widget.tid)
        .then((res){

      int statusCode = int.parse(res.status);

      if(statusCode==9999){

        _questionInfo = TaskQuestionInfo.fromJson(res.info);
        seleValues  = new List(_questionInfo.xList.length);
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

        title: Text(_questionInfo==null?"调查问卷":_questionInfo.title),
        centerTitle: true,
      ),

      body:seleValues==null||_questionInfo==null?Container():ListView(

        children: <Widget>[
          cYM(15),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,//内容适配
            itemCount: _questionInfo.xList.length,
            itemBuilder: (context,index){
              return buildItemView(index);
            },
          ),
          buildBtnView()


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
                  width: 60,
                  height: 35,
                  child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                          Image.asset(wrapAssets("icon_question_bg.png"),width: double.infinity,height: double.infinity,),
                          Text(_questionInfo.xList[firstIndex].type=="1"?"单选":"多选",style: TextStyle(color: Colors.white),)
                      ],
                  ),
                ),
                cXM(10),
                Expanded(child:  Text(_questionInfo.xList[firstIndex].question,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900),),),
            ],
          ),
        cYM(10),
        new  ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,//内容适配
          itemCount: _questionInfo.xList[firstIndex].content.length,
          itemBuilder: (c,index){
            return  buildAnswerItemView(firstIndex,index);
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
  Widget buildAnswerItemView(int firstIndex,int index) {

    return FlatButton(
        onPressed: (){
          setState(() {
            seleValues[firstIndex] = index;
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
          Text(_questionInfo.xList[firstIndex].content[index],style: TextStyle(color:seleValue==index?Colors.blue:Colors.black ,fontSize: 14),)


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
  Widget  buildBtnView() {

    return FlatButton(
        onPressed: (){

          submissionData();

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
  void submissionData() {



  }



}
