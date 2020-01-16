import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/ui/user/bean/user_info_entity.dart';

class NewUserPage extends StatefulWidget {
  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {

  UserInfoInfo _info;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return Scaffold(
    backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[

          buildTopInfoView(context),
          buildLine(),
          buildMoreView(context),
          buildVideoListView(context),
          buildLine(),
          buildBtnView(context,"我的企业"),
          buildBtnView(context,"积分专区"),
          buildBtnView(context,"我的订单"),
          buildBtnView(context,"用户反馈"),


        ],
      ),


    );
  }


  ///
  ///  顶部个人信息
  ///
  buildTopInfoView(BuildContext context) {

    return Container(
      height: ScreenUtil().setHeight(660),
      child: Stack(

        children: <Widget>[

            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(40), 0, ScreenUtil().setWidth(40), 0),
              color: Colors.white,
              height: ScreenUtil().setHeight(420),
            ),

           Image.asset(wrapAssets("user/top_bg.png"),width: double.infinity,height:  ScreenUtil().setHeight(470),fit: BoxFit.fill,),

           Positioned(
             top: ScreenUtil().setHeight(120),
             right: ScreenUtil().setWidth(136),
               child:  Material(
             color: Colors.transparent,
             child:  InkWell(
                 onTap: (){},
                 child: Padding(padding: EdgeInsets.all(10),

                   child: Image.asset(wrapAssets("user/setting.png"),width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),),
                 )

             ),
           )),
            Positioned(
                top: ScreenUtil().setHeight(120),
                right: ScreenUtil().setWidth(3),
                child:  Material(
                  color: Colors.transparent,
                  child:  InkWell(
                      onTap: (){},
                      child: Padding(padding: EdgeInsets.all(10),

                        child: Image.asset(wrapAssets("user/msg.png"),width: ScreenUtil().setWidth(60),height: ScreenUtil().setWidth(60),),
                      )

                  ),
                )),
            Positioned(
                top: ScreenUtil().setHeight(250),
                left: ScreenUtil().setWidth(30),
                child:  Material(
                  child:  InkWell(
                      onTap: (){},
                          child: wrapImageUrl(_info==null?"":_info.userPhoto, ScreenUtil().setWidth(196), ScreenUtil().setWidth(196)),

                  ),
                )),

            Positioned(
                top: ScreenUtil().setHeight(290),
                left: ScreenUtil().setWidth(256),
                child:  Text(_info==null?"":_info.realName,style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),)
            ),
            Positioned(
                top: ScreenUtil().setHeight(370),
                left: ScreenUtil().setWidth(261),
                child:  Text(_info==null?"":_info.userInfo,style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(29)),)
            ),

          new  Positioned(
                top: ScreenUtil().setHeight(320),
                right: ScreenUtil().setWidth(30),
                child: Container(padding: EdgeInsets.all(ScreenUtil().setWidth(20),),
                      child:  Material(
                        color: Color(0XFF609CFB),
                        child: InkWell(
                          onTap: (){
                            RRouter.push(context ,Routes.realNameNewPage,{},transition:TransitionType.cupertino);
                          },
                          child: Row(
                            children: <Widget>[
                              Container(
                                alignment: Alignment.center,
                                width: ScreenUtil().setWidth(156),
                                height: ScreenUtil().setHeight(52),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(26))),
                                    border: Border.all(color: Colors.white,width: ScreenUtil().setWidth(3))
                                ),
                                child: Text("认证医生",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(29)),),
                              ),
                              cXM(ScreenUtil().setWidth(30)),
                              Image.asset(wrapAssets("user/arrow.png"),width: ScreenUtil().setWidth(20),height: ScreenUtil().setHeight(35),)
                            ],

                          ),
                        ),
                      )
                )
            ),

          new Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                color: Colors.white,
                height: ScreenUtil().setHeight(173),
                child: Row(

                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[

               new  Material(

                     color: Colors.white,
                     child: InkWell(
                       onTap: (){

                       },
                       child:   new Container(
                       padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
                         alignment: Alignment.center,
                         child:  Column(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: <Widget>[
                             Text(_info==null?"0":_info.fabu.toString(),style: TextStyle(color: Color(0xFF000000),fontSize: ScreenUtil().setSp(63),fontStyle: FontStyle.italic),),
                             Text("发布",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(29)),),

                           ],
                         ),


                       ),
                     ),
                   ) ,

               new  Material(

                 color: Colors.white,
                 child: InkWell(
                   onTap: (){
                     RRouter.push(context ,Routes.collectHomePage,{},transition:TransitionType.cupertino);
                   },
                   child:   new Container(
                     padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
                     alignment: Alignment.center,
                     child:  Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text(_info==null?"0":_info.collect.toString(),style: TextStyle(color: Color(0xFF000000),fontSize: ScreenUtil().setSp(63),fontStyle: FontStyle.italic),),
                          buildText("收藏",size: 29,color: "#FF333333"),

                       ],
                     ),

                   ),
                 ),
               ) ,
               new  Material(

                 color: Colors.white,
                 child: InkWell(
                   onTap: (){
                     RRouter.push(context ,Routes.followHomePage,{},transition:TransitionType.cupertino);
                   },
                   child:   new Container(
                     padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
                     alignment: Alignment.center,
                     child:  Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text(_info==null?"0":_info.follow.toString(),style: TextStyle(color: Color(0xFF000000),fontSize: ScreenUtil().setSp(63),fontStyle: FontStyle.italic),),
                         buildText("关注",size: 29,color: "#FF333333")

                       ],
                     ),


                   ),
                 ),
               ) ,
               new  Material(

                 color: Colors.white,
                 child: InkWell(
                   onTap: (){
                     RRouter.push(context ,Routes.loginHomePage,{},transition:TransitionType.cupertino);
                   },
                   child:   new Container(
                     padding: EdgeInsets.all(ScreenUtil().setWidth(25)),
                     alignment: Alignment.center,
                     child:  Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                         Text(_info==null?"0":_info.fen.toString(),style: TextStyle(color: Color(0xFF000000),fontSize: ScreenUtil().setSp(63),fontStyle: FontStyle.italic),),
                         buildText("粉丝",size: 29,color: "#FF333333")
                       ],
                     ),


                   ),
                 ),
               ) ,


                  ],
                ),


              )


          )

        ],
      ),

    );
  }

  ///
  ///  分割线
  ///
  buildLine() {
    return Container(
      height: ScreenUtil().setHeight(12),
      color: Color(0xfff5f5f5),

    );

  }

  ///
  ///  点击查看更多
  ///
  buildMoreView(BuildContext context) {

    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(27), 0, ScreenUtil().setWidth(27), 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("观看记录",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w400),),
          new GestureDetector(
            child: Container(
              child: Row(
                children: <Widget>[
                  Text("查看更多",style: TextStyle(color:Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
                  cXM(ScreenUtil().setWidth(4)),
                  Icon(Icons.arrow_forward_ios,color: Colors.black12,size: ScreenUtil().setWidth(35),),
                ],

              ),
            ),
            onTap: (){
            },

          ),

        ],


      ),

    );

  }

  ///
  ///  观看记录横向视频列表
  ///
  buildVideoListView(BuildContext context) {

    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(50), 0, ScreenUtil().setHeight(10)),
      height: ScreenUtil().setHeight(300),
      child: ListView.builder(
          scrollDirection:Axis.horizontal,
          itemCount: 8,
          itemBuilder: (context,index){

            return buildItemDoctorView();
          }
      ),

    );
  }

  ///
  ///  观看记录横向视频列表 Item
  ///
  Widget buildItemDoctorView() {

    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(43)),
      width: ScreenUtil().setWidth(288),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(288),height: ScreenUtil().setHeight(215),fit: BoxFit.fill,),
          Text("湖南湘中医联盟肛...",style: TextStyle(color:Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(32)),),

        ],



      ),

    );

  }

  ///
  ///  跳转布局
  ///
  buildBtnView(BuildContext context,String value) {

    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: (){

          switch(value){

            case"用户反馈":
              RRouter.push(context ,Routes.feedBackPage,{},transition:TransitionType.cupertino);
              break;
            case"积分专区":
              RRouter.push(context ,Routes.taskNewPage,{});
              break;

          }




        },
        child: Container(
          height: ScreenUtil().setHeight(140),
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(58), 0, ScreenUtil().setWidth(43), 0),
          child: Column(

            children: <Widget>[

              Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Icon(Icons.account_balance,size: ScreenUtil().setWidth(70),),
                      cXM(ScreenUtil().setWidth(23)),
                      Expanded(child:  Text(value,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40)),)),
                      Icon(Icons.arrow_forward_ios,color: Colors.black12,size: ScreenUtil().setWidth(46),),
                    ],
                  )
              ),
              Container(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(60)),
                color: Color(0xFFF2F2F2),
                height: ScreenUtil().setHeight(2),

              )



            ],


          ),


        ),
      ),
    );

  }

  void initData() {

    NetUtils.requestIndex()
        .then((res){

          print("个人信息返回："+res.toString());

        if(res.code==200){

          setState(() {
            _info = UserInfoInfo.fromJson(res.info);
          });

        }else{
          showToast(res.msg);
        }
    });

  }

}
