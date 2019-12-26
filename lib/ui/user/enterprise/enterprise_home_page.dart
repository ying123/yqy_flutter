import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/user/enterprise/bean/enterprise_hone_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
///
///
///  企业主页
///
class EnterpriseHomePage extends StatefulWidget {

    String cid;
    String bid;


    EnterpriseHomePage(this.cid, this.bid);

    @override
  _EnterpriseHomePageState createState() => _EnterpriseHomePageState();
}

class _EnterpriseHomePageState extends State<EnterpriseHomePage> {
  //页面加载状态，默认为加载中
  LoadState _layoutState ;

  EnterpriseHoneInfo _enterpriseHoneInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loadData();
  }

  loadData () async{

    NetworkUtils.requestMyCompanyInfo(widget.cid, widget.bid)
        .then((res){

      int code =   res.code;

      _layoutState = loadStateByCode(code);

      if(_layoutState==LoadState.State_Success){

        _enterpriseHoneInfo = EnterpriseHoneInfo.fromJson(res.info);

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
        title: Text("企业主页"),
        centerTitle: true,
      ),
      body:_enterpriseHoneInfo==null?Container(): Column(

        children: <Widget>[

          buildTopView(context),//顶部企业信息
          cYM(ScreenUtil().setHeight(30)),
          Expanded(
              child:  buildDepartmentAndCount(context),// 部门分类和人数
          )


        ],


      ),


    );
  }

  buildTopView(BuildContext context) {

    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(100), ScreenUtil().setHeight(65),ScreenUtil().setWidth(43), 0),
      width: double.infinity,
      height: ScreenUtil().setHeight(370),
      child: Column(

        children: <Widget>[

         new Row(
            children: <Widget>[
              wrapImageUrl(_enterpriseHoneInfo.userPhoto,  ScreenUtil().setWidth(81),  ScreenUtil().setWidth(81)),
              cXM(ScreenUtil().setWidth(23)),
              Expanded(
                  child: Text(_enterpriseHoneInfo.companyName, style: TextStyle(
                      color: Color(0xFF333333),
                      fontSize: ScreenUtil().setSp(46)))
              ),
              Container(
                alignment: Alignment.center,
                width: ScreenUtil().setWidth(164),
                height: ScreenUtil().setHeight(57),
                decoration: BoxDecoration(
                  
                  border: Border.all(color: Color(0xFF0072EE),width: ScreenUtil().setWidth(1)),
                  borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12))),
                  color: Colors.white
                ),
                child: Text("企业详情",style: TextStyle(color: Color(0xFF0072EE),fontSize: ScreenUtil().setSp(35)),),

              )

            ],
          ),

         cYM(ScreenUtil().setHeight(55)),

         new Row(

           children: <Widget>[
             Text("我的部门：",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),),
             cXM(ScreenUtil().setWidth(23)),
             Text(_enterpriseHoneInfo.my.branchName??"",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40)),),

           ],

         ),
         cYM(ScreenUtil().setHeight(35)),
         new Row(

           children: <Widget>[
             Text("我的角色：",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),),
             cXM(ScreenUtil().setWidth(23)),
             Text(_enterpriseHoneInfo.my.groupName??"",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40)),),

           ],

         ),
        ],

      ),


    );



  }

  buildDepartmentAndCount(BuildContext context) {

    return  ListView(

      shrinkWrap: true,

      children: <Widget>[

        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context,index){
              return itemDepartment(_enterpriseHoneInfo.branchLists[index]);
            },
            itemCount: _enterpriseHoneInfo.branchLists.length,
        ),
        cYM(ScreenUtil().setHeight(29)),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){
            return itemOtherCount(_enterpriseHoneInfo.staffLists[index]);
          },
          itemCount: _enterpriseHoneInfo.staffLists.length,
        )



      ],


    );


  }

  itemDepartment(EnterpriseHoneInfoBranchList bean) {
    return Column(
      
      children: <Widget>[

       InkWell(
         onTap: (){
           RRouter.push(context ,Routes.staffListPage,{},transition:TransitionType.cupertino);
         },
         child:   Container(
           padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(99), 0, ScreenUtil().setWidth(43), 0),
           height: ScreenUtil().setHeight(146),
           width: double.infinity,
           color: Colors.white,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Text(bean.name+"("+bean.staffNums.toString()+")",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40)),),
               Icon(Icons.arrow_forward_ios,size: 20,color: Color(0xFFC8C8C8),)

             ],


           ),

         ),
       ),
        Divider(height: ScreenUtil().setHeight(1),color: Color(0xFFF2F2F2),)

        
      ],

    );


  }

  itemOtherCount(EnterpriseHoneInfoStaffList bean) {

    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(95)),
      height: ScreenUtil().setHeight(146),
      color: Colors.white,
      width: double.infinity,
      child:  Column(
        
        children: <Widget>[
          
        new  Container(
            height: ScreenUtil().setHeight(145),
            child:  new Row(
              children: <Widget>[
                wrapImageUrl(bean.userPhoto,  ScreenUtil().setWidth(81),  ScreenUtil().setWidth(81)),
                  cXM(ScreenUtil().setWidth(21)),
                  Expanded(
                    child: Text(bean.realName, style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: ScreenUtil().setSp(40)))
                ),
                
              ],
            ),
          ),
          
        Divider(height: ScreenUtil().setHeight(1),color: Color(0xFFF2F2F2),)
          
        ],
        
      )


    );

  }
}
