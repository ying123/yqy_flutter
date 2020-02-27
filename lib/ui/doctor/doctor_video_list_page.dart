import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:yqy_flutter/ui/home/bean/video_page_entity.dart';

class DoctorVideoListPage extends StatefulWidget {
  @override
  _DoctorVideoListPageState createState() => _DoctorVideoListPageState();
}

class _DoctorVideoListPageState extends State<DoctorVideoListPage> {

  String _content;

  bool _screenShow = false; // 筛选布局是否显示


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: Text("专家视频"),

      ),

      body:  new   Column(

        children: <Widget>[

          buildSearchView(context),

          Expanded(
              child:  Stack(
                  children: <Widget>[

                      // 主体内容  列表
                      ListView.builder(itemBuilder: (context,index){

                          return getLiveItemView(context,null);

                      }),

                      //筛选布局
                      Visibility(visible: _screenShow??false,child: buildScreenView(context)),


            ],
          ))

        ],

      ),
      

      
    );

  }
  ///
  ///   列表item
  ///
  Widget getLiveItemView(context,VideoPageInfoVideoList bean){

    return  GestureDetector(

      onTap: (){

        RRouter.push(context, Routes.doctorVideoInfoPage,{"id": bean.id.toString()});

      },

      child: new Container(
        height: ScreenUtil().setHeight(250),
        padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(27), 0, 0,  ScreenUtil().setHeight(40)),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Image.network(bean.image,fit: BoxFit.fill,height: ScreenUtil().setHeight(215),width:ScreenUtil().setWidth(288)),
            cXM(ScreenUtil().setHeight(20)),
            new Container(
                width: ScreenUtil().setWidth(720),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(bean.title,style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(37)),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Image.asset(wrapAssets("tab/tab_live_ic2.png"),width: ScreenUtil().setSp(32),height: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text("张素娟  李霞  将建成  张大大  王素娥",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
                          ],
                        ),

                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Icon(Icons.access_time,size: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text(bean.createTime,style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
                          ],
                        ),

                      ],
                    ),

                  ],

                )

            )

          ],

        ),
      ),

    );

  }

  ///
  ///  顶部搜索筛选布局
  ///
  buildSearchView(BuildContext context) {

    return Container(
      padding: EdgeInsets.fromLTRB(setW(30), 0, setW(30), 0),
      height: setH(160),
      child: Row(
        children: <Widget>[

          //评论输入框
          Expanded(child:   new Container(
            width: ScreenUtil().setWidth(800),
            height: ScreenUtil().setHeight(90),
            decoration: BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(30)))
            ),
            child: Row(
              children: <Widget>[
                cXM(ScreenUtil().setWidth(40)),
                Icon(Icons.search,color: Colors.black26,size: ScreenUtil().setWidth(50),),
                cXM(ScreenUtil().setWidth(30)),

                Container(
                  width: setW(600),
                  child:  TextFormField(
                    controller: new TextEditingController(
                        text: _content
                    ),
                    decoration: InputDecoration(
                      hintText: "按医院、科室、医生名、疾病名称搜索",
                      hintStyle:  TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),
                      border: InputBorder.none,
                    ),
                    textInputAction: TextInputAction.send,
                    style:  TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(36)),
                    onChanged: (str){
                      _content = str;
                    },
                    onFieldSubmitted: (value) {
                      _content = "";
                      // 搜索内容 请求
                     // uploadCommentData(value);
                    },

                  ),

                )
              ],
            ),

          ),),

          Builder(builder: (context1){
            return
              InkWell(
                  onTap: (){

                    setState(() {

                      _screenShow?_screenShow = false:_screenShow = true;

                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                    child:  Row(
                      children: <Widget>[
                        Image.asset(wrapAssets("tab/tab_screen.png"),width: ScreenUtil().setWidth(50),height: ScreenUtil().setHeight(50),),
                        cXM(ScreenUtil().setWidth(6)),
                        Text("地区",style:TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)))
                      ],

                    ),
                  )

              );

          })





        ],
      ),

    );

  }

  ///
  ///  弹出的筛选布局
  ///
  buildScreenView(BuildContext context) {

    return  Column(

      children: <Widget>[

        Container(
          height: setH(400),
          color: Colors.white,
        ),
        Expanded(child: Container(

          color: Colors.black38,
        ))



      ],
    );

  }


}
