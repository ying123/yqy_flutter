import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/bean/base_result.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/http_manager.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/user/enterprise/bean/my_enterprise_entity.dart';
import 'package:yqy_flutter/ui/user/enterprise/bean/search_company_entity.dart';
import 'package:yqy_flutter/ui/user/enterprise/bean/search_entity.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

///
///   我的企业页面  包含 未加入企业view  和 已加入企业view
///
///
class MyEnterprisePage extends StatefulWidget {
  @override
  _MyEnterprisePageState createState() => _MyEnterprisePageState();
}

class _MyEnterprisePageState extends State<MyEnterprisePage> {

  //页面加载状态，默认为加载中
  LoadState _layoutState  = LoadState.State_Loading;

  MyEnterpriseData _myEnterpriseData;

  StreamSubscription changeSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
    initEventbusListener();
  }



  @override
  void dispose() {
    super.dispose();
    changeSubscription.cancel();
  }

  loadData () async{

    NetworkUtils.requestMyCompany()
        .then((res){

       int code =   res.code;

       _layoutState = loadStateByCode(code);

       if(_layoutState==LoadState.State_Success){

          _myEnterpriseData = MyEnterpriseData.fromJson(res.data);


       }
      setState(() {

      });

    });


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        title: Text("我的企业"),
        centerTitle: true,

      ),
      body: LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        this.loadData();
      },
      successWidget:_myEnterpriseData==null?Container(): buildContextView(),

    )
    );
  }

  buildContextView() {
    return  ListView(
      shrinkWrap: true,//内容适配
      children: <Widget>[

        _myEnterpriseData.companyList.length==0?buildEmptyView():buildMyEnterpriseList(context,_myEnterpriseData.companyList),//我的企业列表
        Visibility(visible: _myEnterpriseData.companyList.length==0?false:true,child:  buildAddBtn(context),),
       //添加企业按钮
        cYM(ScreenUtil().setHeight(28)),
        buildTipTextView("我的申请"),//提示文字
        buildApplyList(context,_myEnterpriseData.myApply),// 我的申请列表
        cYM(ScreenUtil().setHeight(29)),
        buildTipTextView("邀我加入"),//提示文字
        buildInvitationList(context,_myEnterpriseData.invite),// 邀请我加入的列表

      ],

    );

  }

  void initEventbusListener() {

    changeSubscription =  eventBus.on<EventBusChange>().listen((event) {
         loadData();
    });
  }

}


///
///  未加入企业  显示的页面
///
class buildEmptyView extends StatefulWidget {
  @override
  _buildEmptyViewState createState() => _buildEmptyViewState();
}

class _buildEmptyViewState extends State<buildEmptyView> {
  @override
  Widget build(BuildContext context) {
    ///
    ///  当前未加入企业的 显示的页面
    ///
    return  Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(500),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top:  ScreenUtil().setHeight(145)),
            height: ScreenUtil().setHeight(145),
            width: double.infinity,
            child: Text("您还没有加入任何企业哦~", style: TextStyle(
                fontSize: ScreenUtil.getInstance().setSp(40),
                color: Color(0xFF666666),
                fontWeight: FontWeight.w400),),
          ),

          SizedBox(
            height: ScreenUtil().setHeight(20),

          ),

          InkWell(
            onTap: () {
          //    showSearch(context: context, delegate: searchBarDelegate());
              RRouter.push(context ,Routes.searchCompanyPage,{},transition:TransitionType.native);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(265),
              height: ScreenUtil().setHeight(84),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Color(0xFFC4C4C4), width: ScreenUtil().setWidth(3)),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(12)))

              ),
              child: Text("+添加企业", style: TextStyle(
                  color: Color(0xFF999999), fontSize: ScreenUtil().setSp(40)),),

               ),
          )
        ],

      ),
    );
  }
}







  buildMyEnterpriseList(BuildContext context,List<MyEnterpriseDataCompanyList> list) {

    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,//内容适配
        itemBuilder: (context,index){

          return itemMyEnterpriseView(context,list[index]);

        },
        itemCount: list.length,

    );

  }

  buildAddBtn(BuildContext context) {

    return InkWell(

      onTap: (){
       // showSearch(context: context, delegate: searchBarDelegate());
        RRouter.push(context ,Routes.searchCompanyPage,{},transition:TransitionType.native);
      },

      child: Container(
        alignment: Alignment.center,
        color: Colors.white,
        width: double.infinity,
        height: ScreenUtil().setHeight(145),
        child: Text("+添加企业",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),),
        
      ),
      
    );



  }

  buildTipTextView(String s) {

    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(43)),
      color: Colors.white,
      height: ScreenUtil().setHeight(130),
      width: double.infinity,
      child: Text(s,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46)),),

    );


  }

  buildApplyList(BuildContext context,	List<MyEnterpriseDataMyApply> list) {

    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,//内容适配
      itemBuilder: (context,index){

        return itemApplyView(context,list[index]);

      },
      itemCount: list.length,

    );


  }

  buildInvitationList(BuildContext context,	List<MyEnterpriseDataInvite> list) {
    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,//内容适配
      itemBuilder: (context,index){

        return itemInvitationView(context,list[index]);

      },
      itemCount: list.length,

    );


  }

itemInvitationView(BuildContext context, MyEnterpriseDataInvite bean) {
  return new Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(170),
      width: double.infinity,
      child: Column(

        children: <Widget>[

          Expanded(child:  Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: ScreenUtil().setWidth(108),
              ),
              wrapImageUrl(bean.userPhoto,  ScreenUtil().setWidth(81),  ScreenUtil().setWidth(81)),

              SizedBox(
                width: ScreenUtil().setWidth(23),
              ),
              Expanded(child: Text(bean.companyName,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w500),),),

              InkWell(
                onTap: (){
                  showTipDialog(context);
                  Future.delayed(Duration(milliseconds: 1500), (){
                    Navigator.of(context).pop();
                  });
                },
                child:bean.dataFlag==4?Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(207),
                  height: ScreenUtil().setHeight(84),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFC4C4C4),width: ScreenUtil().setWidth(3)),
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12))),
                  ),
                  child: Text(getStatus(bean.dataFlag),style: TextStyle(color: Color(0xFF0072EE),fontSize: ScreenUtil().setSp(40)),),
                ):Material(
                  color: Colors.transparent,
                  child: InkWell(
                    // 点击同意加入企业
                    onTap: (){
                        requestJoinData(context,bean.id);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(207),
                      height: ScreenUtil().setHeight(84),
                      child: Text(getStatus(bean.dataFlag),style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),),
                    ),
                  ),
                )
              ),

              SizedBox(
                width: ScreenUtil().setWidth(43),
              ),
            ],

          ),),

          Divider(height: ScreenUtil().setHeight(1),color: Color(0xFFF2F2F2),)
        ],
      )
  );

}


///
///  点击同意邀请  加入企业
///
void requestJoinData(BuildContext context,int id) {

  NetworkUtils.requestDealCompanyInvite(id.toString(), "1")
      .then((res){

        showToast(res.message);
        if(res.code==200){
          //如果点击同意  则刷新界面
          eventBus.fire(new EventBusChange(""));
        }

  });


}

  itemMyEnterpriseView(BuildContext context,MyEnterpriseDataCompanyList bean) {
    return InkWell(
      onTap: (){
        RRouter.push(context ,Routes.enterpriseHomePage,{"cid":bean.cid,"bid":0},transition:TransitionType.cupertino);
      },
      child: new Container(
          color: Colors.white,
          height: ScreenUtil().setHeight(170),
          width: double.infinity,
          child: Column(

            children: <Widget>[
              Expanded(child:  Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: ScreenUtil().setWidth(108),
                  ),
                  wrapImageUrl(bean.userPhoto, ScreenUtil().setWidth(81), ScreenUtil().setWidth(81)),
                  SizedBox(
                    width: ScreenUtil().setWidth(23),
                  ),
                  Expanded(child: Text(bean.companyName,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w500),),),

                  Icon(Icons.arrow_forward_ios,color: Color(0xFFC8C8C8),size: 20,),

                  SizedBox(
                    width: ScreenUtil().setWidth(30),
                  ),
                ],

              ),),

              Divider(height: ScreenUtil().setHeight(1),color: Color(0xFFF2F2F2),)

            ],

          )

      ),
    );


  }

  itemApplyView(BuildContext context,MyEnterpriseDataMyApply bean) {

    return new Container(
        color: Colors.white,
        height: ScreenUtil().setHeight(170),
        width: double.infinity,
        child: Column(

          children: <Widget>[

            Expanded(child:  Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: ScreenUtil().setWidth(108),
                ),
                wrapImageUrl(bean.userPhoto, ScreenUtil().setWidth(81), ScreenUtil().setWidth(81)),
                SizedBox(
                  width: ScreenUtil().setWidth(23),
                ),
                Expanded(child: Text(bean.companyName,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w500),),),

               Text(getStatus(bean.dataFlag),style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),),

                SizedBox(
                  width: ScreenUtil().setWidth(43),
                ),
              ],

            ),),

            Divider(height: ScreenUtil().setHeight(1),color: Color(0xFFF2F2F2),)




          ],

        )

    );

  }


 ///
///  获取审核状态
///  备注：dataflag:1正常 0已离职 2申请中 3申请拒绝 4邀请中 5邀请拒绝
///
String getStatus(int dataFlag) {

  switch(dataFlag){

    case 0:
      return "已离职";
    case 1:
      return "正常";
    case 2:
      return "申请中";
    case 3:
      return "申请拒绝";
    case 4:
      return "同意";
    case 5:
      return "邀请拒绝";
  }


}

  void showTipDialog(BuildContext context) {

      showDialog(context: context,

        builder: (_){

        return Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12))),
                boxShadow: [BoxShadow(color: Color(0xD000000), offset: Offset(0, 14.0), blurRadius: 10.0, spreadRadius: 2.0)]
            ),
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(150), ScreenUtil().setWidth(750), ScreenUtil().setWidth(150), ScreenUtil().setWidth(800)),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Icon(Icons.assignment_turned_in,size: 60,color: Colors.blue,),
                cYM(ScreenUtil().setHeight(50)),
                Text("您已加入山东汉方制药有限公司",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40)),)

              ],
            ),


          ),

        );

        }

      );

  }


///
///  搜索布局设置
///
///
class searchBarDelegate extends SearchDelegate<String> {

  @override
  // TODO: implement searchFieldLabel
  String get searchFieldLabel => "搜索企业";



  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];

  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () => close(context, null));
  }

  @override
  Widget buildResults(BuildContext context) {
    return  Container(color: Colors.red,);

  }

  @override
  void showResults(BuildContext context) {
    // TODO: implement showResults
    super.showResults(context);

  }


  @override
  Widget buildSuggestions(BuildContext context) {

    SearchCompanyEntity searchCompanyEntity;

    if(query.isNotEmpty){

      NetworkUtils.requestSearchCompany(query)
          .then((res){
        searchCompanyEntity = SearchCompanyEntity.fromJson(res.toJson());
        return searchCompanyEntity.info.length==0?buildSearchEmptyView(context):buildSearchData(searchCompanyEntity.info);
      });
      return Container(
        height: 50,
        color: Colors.black,
      );
    }else{
      return Container(
      );

    }


  }

  buildSearchEmptyView(BuildContext context) {

    return  Container(

    );


  }

  buildSearchData(List<SearchCompanyInfo> list) {

  print("buildSearchData--------------"+list.toString());
   return new ListView.builder(
       itemCount: list.length,
       itemBuilder: (context,index){

         print(list[index].toString().indexOf(query));

         return  new Container(
           padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
           color: Colors.white,
           height: ScreenUtil().setHeight(145),
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
                       children: searchData(list[index].companyName.split(""),query))),
               InkWell(

                 onTap: (){
                   showApplyDialog(context);
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

   );


 /* return
     ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) => ListTile(
          title: RichText(
              text: TextSpan(
                  text: list[index].substring(0, query.length),
                  style: TextStyle(
                      color: Color(0xFF0072EE), fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: list[index].substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ])),
        ));
*/
  }


  ///
  ///  确认申请加入的弹窗
  ///
  void showApplyDialog(BuildContext context) {

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
                  Text("山东汉方制药有限公司",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46)),),
                  Container(
                    width: ScreenUtil().setWidth(513),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                         new InkWell(
                            onTap: (){
                              Navigator.pop(context);

                              showApplySuccessDialog(context);

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
  void showApplySuccessDialog(BuildContext context) {

    showDialog(
        context: context,
        builder: (_){

          return Material(
            color: Colors.transparent,
            child:Container(
              margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(148), ScreenUtil().setHeight(655), ScreenUtil().setWidth(148), ScreenUtil().setHeight(755)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[


                  Text("您的申请已提交",style: TextStyle(color: Color(0xFF666666),fontSize: ScreenUtil().setSp(40)),),
                  Text("请等待企业管理员审核",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(46)),),
                  Container(
                    width: ScreenUtil().setWidth(513),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        new InkWell(
                          onTap: (){
                            Navigator.pop(context);
                            showApplySuccessDialog(context);

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

            ) ,

          );

        }
    );

  }

  Future<Response> requestData(String q) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post(APPConfig.SEARCH_COMPANY, data: {"keyword":q});
    return response;
  }





 /* @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentSuggest
        : searchList.where((input) => input.startsWith(query)).toList();

    return ListView.builder(
        itemCount: suggestionList.length,
        itemBuilder: (context, index) => ListTile(
          title: RichText(
              text: TextSpan(
                  text: suggestionList[index].substring(0, query.length),
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                        text: suggestionList[index].substring(query.length),
                        style: TextStyle(color: Colors.grey))
                  ])),
        ));
  }*/


}

const searchList = [
  "山东汉方制药有限公司",
  "汉方科技有限公司",
  "山东汉方纽贝小红帽生物科技有...",
  "山东汉方生物科技有限公司"
];

const recentSuggest = [
  "历史",
  "历史记",
  "历",
  "历史记",
  "历史记",
  "历史6",
  "历史记7",
  "历史记录8",
];

List<Widget> Boxs() => List.generate(recentSuggest.length, (index) {
  return  InkWell(
    onTap: (){

    },
    child: Container(
      alignment: Alignment.center,
      height: ScreenUtil().setHeight(58),
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFC4C4C4),width: ScreenUtil().setWidth(1)),
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12))),
          color: Colors.white
      ),
      child: Text(recentSuggest[index],style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),),
    ),
  );
});



List<TextSpan> searchData(List list,String v) => List.generate(list.length, (index) {

        return TextSpan(
          text:list[index],
          style: TextStyle(color:v.contains(list[index])?Color(0xFF0072EE):Color(0xFF666666),fontSize: ScreenUtil().setSp(40))

        );

});


///
///  搜索页面  主内容  默认显示所有企业的列表
///
class SearchContentView extends StatefulWidget {

  String query;

  SearchContentView(this.query);

  @override
  _SearchContentViewState createState() => _SearchContentViewState();
}

class _SearchContentViewState extends State<SearchContentView> {
  SearchCompanyEntity entity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkUtils.requestSearchCompany(widget.query)
        .then((res){
      entity = SearchCompanyEntity.fromJson(json.decode(res.data));
      print("searchCompanyEntity::::"+entity.toString());

      if(entity.code==200){
        setState(() {

        });
      }
    });
  }
  Future<Response> requestData(String q) async {
    Response response;
    Dio dio = Dio();
    response = await dio.post(APPConfig.SEARCH_COMPANY, data: {"keyword":q});
    return response;
  }
  @override
  Widget build(BuildContext context) {
    return entity==null?Container(): ListView.builder(
        itemCount: entity.info.length,
        itemBuilder: (context,index){
          return    new Container(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
            color: Colors.white,
            height: ScreenUtil().setHeight(145),
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Text(entity.info[index].companyName,style: TextStyle(color: Color(0xFF666666),fontSize: ScreenUtil().setSp(40)),),

                InkWell(

                  onTap: (){

                    showApplyDialog(context,entity.info[index]);

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
        });
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
}
