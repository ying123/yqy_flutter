import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/user/enterprise/bean/search_company_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SearchCompanyPage extends StatefulWidget {
  @override
  _SearchCompanyPageState createState() => _SearchCompanyPageState();
}

class _SearchCompanyPageState extends State<SearchCompanyPage> {

  final ProxyAnimation _proxyAnimation = ProxyAnimation(kAlwaysDismissedAnimation);

  String query;
  TextEditingController controller = new TextEditingController();

  SearchCompanyEntity entity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: AnimatedIcon(
                icon: AnimatedIcons.arrow_menu, progress: _proxyAnimation,color: Colors.black54,),
            onPressed: (){
              Navigator.pop(context);
            }),

          title: TextField(
            controller: controller,
            autofocus: true,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
                  hintText: "搜索企业",
                  hintStyle: TextStyle(color: Color(0xFF666666),fontSize: ScreenUtil().setSp(40)),
                  border: InputBorder.none,

            ),
            onSubmitted: (v){

              if(v.isNotEmpty){
                query = v;
                requestSearchData(v);
              }

            },

          ),

          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.clear,color: Colors.black54,),
              onPressed: (){

                setState(() {
                  controller.text = "";
                  entity = null;
                });
              }
            )
          ],
      ),

      body:entity==null?Container(): ListView.builder(
         itemCount: entity.info.length,
          itemBuilder: (context,index){

          return  _buildListItem(context,entity.info[index]);

          }
      ),

    );
  }

  Widget _buildListItem(BuildContext context,SearchCompanyInfo bean) {

    return  new Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
      color: Colors.white,
      height: ScreenUtil().setHeight(180),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new RichText(
              text: TextSpan(
                  text: "",
                  style: TextStyle(
                      color: Color(0xFF0072EE), fontWeight: FontWeight.bold),
                  children: searchData(bean.companyName.split(""),query))),
          InkWell(

            onTap: (){
              showApplyDialog(context,bean);
            },

            child:  Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(265),
              height: ScreenUtil().setHeight(84),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xFFC4C4C4),width: ScreenUtil().setWidth(3)),
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12)))
              ),
              child: Text("申请加入",style: TextStyle(color: Color(0xFF0072EE),fontSize:  ScreenUtil().setSp(40)),),

            ),
          )

        ],

      ),

    );

  }

  List<TextSpan> searchData(List list,String v) => List.generate(list.length, (index) {

    return TextSpan(
        text:list[index],
        style: TextStyle(color:v.contains(list[index])?Color(0xFF0072EE):Color(0xFF666666),fontSize: ScreenUtil().setSp(40))

    );

  });

  void requestSearchData(String v) {

    NetworkUtils.requestSearchCompany(v)
        .then((res){
      if(res.code==200){
        setState(() {
          entity = SearchCompanyEntity.fromJson(res.toJson());
          if(entity.info.length==0){
            showToast("没有搜索到相关公司");
          }
        });
      }
    });

  }
}

///
///  确认申请加入的弹窗
///
void showApplyDialog(BuildContext context,SearchCompanyInfo bean) {

  showDialog(
      context: context,
      builder: (_){
        return Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12))),
              color: Colors.white,
            ),
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(148), ScreenUtil().setHeight(655), ScreenUtil().setWidth(148), ScreenUtil().setHeight(755)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text("确认申请加入",style: TextStyle(color: Color(0xFF666666),fontSize: ScreenUtil().setSp(40)),),
                Text(bean.companyName,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46)),),
                Container(
                  width: ScreenUtil().setWidth(513),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      new InkWell(
                        onTap: (){
                          Navigator.pop(context);

                          showApplySuccessDialog(context,bean);

                        },
                        child:   Container(
                          width: ScreenUtil().setWidth(207),
                          height: ScreenUtil().setHeight(84),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Color(0xFF0072EE),
                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12)))
                          ),
                          child: Text("确定",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(40)),),
                        ),
                      ),
                      new InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child:   Container(
                          width: ScreenUtil().setWidth(207),
                          height: ScreenUtil().setHeight(84),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Color(0xFFC4C4C4),width: ScreenUtil().setWidth(3)),
                              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12)))
                          ),
                          child: Text("取消",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),),
                        ),
                      )


                    ],

                  ),
                )

              ],

            ),

          ),


        );

      }
  );


}


///
///  申请加入公司成功
///
void showApplySuccessDialog(BuildContext context,SearchCompanyInfo bean) {


  NetworkUtils.requestApplyJoinCompany(bean.userId.toString())
      .then((res){

    if(res.code==200){
      showDialog(
          context: context,
          builder: (_){
            return Material(
              color: Colors.transparent,
              child:Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12))),
                  color: Colors.white,
                ),
                margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(148), ScreenUtil().setHeight(655), ScreenUtil().setWidth(148), ScreenUtil().setHeight(755)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.assignment_turned_in,size: 60,color: Colors.blue,),
                    cYM(ScreenUtil().setHeight(30)),
                    Text("您的申请已提交",style: TextStyle(color: Color(0xFF666666),fontSize: ScreenUtil().setSp(40)),),
                    cYM(ScreenUtil().setHeight(30)),
                    Text("请等待企业管理员审核",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46)),),
                  ],

                ),

              ) ,

            );

          }
      );
      Future.delayed(Duration(milliseconds: 2000), (){
        Navigator.of(context).pop();
        //刷新我的企业界面
        eventBus.fire(new EventBusChange(""));
      });


    }else{
      showToast(res.message);
    }


  });




}