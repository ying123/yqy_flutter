import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/user/enterprise/search_page.dart';
import 'package:yqy_flutter/utils/margin.dart';

///
///   我的企业页面  包含 未加入企业view  和 已加入企业view
///
///
class MyEnterprisePage extends StatefulWidget {
  @override
  _MyEnterprisePageState createState() => _MyEnterprisePageState();
}

class _MyEnterprisePageState extends State<MyEnterprisePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(

        title: Text("我的企业"),
        centerTitle: true,

      ),

      body: buildDataView(),

    );
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          margin: EdgeInsets.only(top: ScreenUtil.getInstance().setHeight(591)),
          child: Text("您还没有加入任何企业哦~", style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(45),
              color: Color(0xFF666666),
              fontWeight: FontWeight.w400),),
        ),

        SizedBox(
          height: ScreenUtil().setHeight(76),

        ),

        InkWell(
          onTap: () {

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

    );
  }
}




///
///  已经加入企业 显示的页面
///
class buildDataView extends StatefulWidget {
  @override
  _buildDataViewState createState() => _buildDataViewState();
}

class _buildDataViewState extends State<buildDataView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,//内容适配
      children: <Widget>[

          buildMyEnterpriseList(context),//我的企业列表
           buildAddBtn(context),//添加企业按钮
            cYM(ScreenUtil().setHeight(28)),
            buildTipTextView("我的申请"),//提示文字
            buildApplyList(context),// 我的申请列表
            cYM(ScreenUtil().setHeight(29)),
          buildTipTextView("邀我加入"),//提示文字
          buildInvitationList(context),// 邀请我加入的列表

      ],

    );
  }


  buildMyEnterpriseList(BuildContext context) {

    return  ListView.builder(
       physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,//内容适配
        itemBuilder: (context,index){

          return itemMyEnterpriseView();

        },
        itemCount: 2,

    );


  }

  buildAddBtn(BuildContext context) {

    return InkWell(

      onTap: (){
        showSearch(context: context, delegate: searchBarDelegate());
       // RRouter.push(context ,Routes.searchPage,{},transition:TransitionType.cupertino);
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

  buildApplyList(BuildContext context) {

    return  ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,//内容适配
      itemBuilder: (context,index){

        return itemApplyView();

      },
      itemCount: 2,

    );


  }

  buildInvitationList(BuildContext context) {

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
                Image.asset(wrapAssets("icon_home_s.png"),width: ScreenUtil().setWidth(81),height:ScreenUtil().setWidth(81) ,),

                SizedBox(
                  width: ScreenUtil().setWidth(23),
                ),
                Expanded(child: Text("山东汉方制药有限公司",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w500),),),

                 InkWell(
                   onTap: (){
                     showTipDialog(context);
                     Future.delayed(Duration(milliseconds: 1500), (){
                       Navigator.of(context).pop();
                     });
                   },
                   child: Container(
                     alignment: Alignment.center,
                     width: ScreenUtil().setWidth(207),
                     height: ScreenUtil().setHeight(84),
                     decoration: BoxDecoration(
                       border: Border.all(color: Color(0xFFC4C4C4),width: ScreenUtil().setWidth(3)),
                       color: Colors.white,
                       borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12))),
                     ),
                     child: Text("同意",style: TextStyle(color: Color(0xFF0072EE),fontSize: ScreenUtil().setSp(40)),),
                   ),
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

  itemMyEnterpriseView() {
    return InkWell(
      onTap: (){
        RRouter.push(context ,Routes.enterpriseHomePage,{},transition:TransitionType.cupertino);
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
                  Image.asset(wrapAssets("icon_home_s.png"),width: ScreenUtil().setWidth(81),height:ScreenUtil().setWidth(81) ,),

                  SizedBox(
                    width: ScreenUtil().setWidth(23),
                  ),
                  Expanded(child: Text("山东汉方制药有限公司",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w500),),),

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

  itemApplyView() {

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
                Image.asset(wrapAssets("icon_home_s.png"),width: ScreenUtil().setWidth(81),height:ScreenUtil().setWidth(81) ,),

                SizedBox(
                  width: ScreenUtil().setWidth(23),
                ),
                Expanded(child: Text("山东汉方制药有限公司",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w500),),),

               Text("审核中",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),),

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
}


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
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Center(
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {

     return query.isEmpty?buildSearchEmptyView(context):buildSearchData(searchList);

  }

  buildSearchEmptyView(BuildContext context) {

    return  Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
      color: Colors.white,
      child: Column(

        children: <Widget>[
          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[

              Text("搜索历史", style: TextStyle(
                  color: Color(0xFF333333), fontSize: ScreenUtil().setSp(40)),),
              IconButton(
                  icon: Icon(
                  Icons.delete_forever, size: 30, color: Color(0xFFC8C8C8)),
                  onPressed: () {

                  })

            ],

          ),

          cYM(ScreenUtil().setHeight(20)),

          Wrap(
            spacing: ScreenUtil().setWidth(30), //主轴上子控件的间距
            runSpacing: ScreenUtil().setHeight(20), //交叉轴上子控件之间的间距
            children: Boxs(), //要显示的子控件集合

          )



        ],

      ),
      
    );


  }

  buildSearchData(List list) {




   return ListView.builder(
       itemCount: list.length,
       itemBuilder: (context,index){

         print(list[index].toString().indexOf(query));

         return Container(
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
                       children: searchData(list[index].toString().split(""),query))),
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