import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/margin.dart';

class LiveNoticePage extends StatefulWidget {
  @override
  _LiveNoticePageState createState() => _LiveNoticePageState();
}

class _LiveNoticePageState extends State<LiveNoticePage> {

  bool _showTipContent  = false;// 是否显示简介

  int viewTypeMy = 1;// 当前的排列方式  我的预约排列   0 gridview  1  listview

  ScrollController _scrollController = new ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          //主要内容布局
          buildContextView(context),
          // 底部点击评论的布局
          buildBottomView(context)


        ],
      ),


    );
  }

  buildContextView(BuildContext context) {

    return Container(

      height: double.infinity,
      child: Column(

        children: <Widget>[
          // 视频布局
          buildContentVideo(context),
          // 视频简介
          buildContentInfoView(context),
          //分割线
          buildLine(),
          //下方内容为可滚动的
          buildListView(context),
          //底部的高度 避免评论布局遮挡内容的布局
          cYM(ScreenUtil().setHeight(130))

        ],
      ),
    );

  }

  buildBottomView(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(30)),
      height: ScreenUtil().setHeight(130),
      color: Colors.white,
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
                Icon(Icons.border_color,color: Colors.black26,size: ScreenUtil().setWidth(50),),
                cXM(ScreenUtil().setWidth(30)),
                Text("发表评论",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),)
              ],
            ),

          ),),

          cXM(ScreenUtil().setWidth(40)),
          // 消息按钮
          new  Material(
            color: Colors.transparent,
            child:   InkWell(

              onTap: (){

              },
              child:   new Container(
                  height:  ScreenUtil().setHeight(110),
                  width: ScreenUtil().setWidth(110),
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Icon(Icons.sms,size: ScreenUtil().setWidth(60),color: Color(0xff999999),),
                      Positioned(
                          right: 0,
                          top: 0,
                          child:   Container(
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.all(Radius.circular(30))
                            ),
                            width: ScreenUtil().setWidth(36),
                            height: ScreenUtil().setWidth(36),
                            alignment: Alignment.center,
                            child: Text("3",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(22)),),

                          ))

                    ],

                  )

              ),
            ),
          ),

          // 点赞按钮
          new Container(
              alignment: Alignment.center,
              height:  ScreenUtil().setHeight(110),
              width: ScreenUtil().setWidth(110),
              child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: (){

                }, child:    Icon(Icons.favorite,size: ScreenUtil().setWidth(60),color: Color(0xFFFF934C),),)

          )
        ],
      ),

    );

  }

  // 视频view
  buildContentVideo(BuildContext context) {

    return Container(

      height: ScreenUtil().setHeight(600),
      color: Colors.blue,

    );


  }

  // 视频信息 简介
  buildContentInfoView(BuildContext context) {

    return Container(

      child: Column(

        children: <Widget>[

          // 倒计时  预约
          new  Container(
            margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
            color: Colors.blueAccent,
            height: ScreenUtil().setHeight(120),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Text("距离直播开始还有2天1时30分00秒",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(40)),),

                Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(180),
                  height: ScreenUtil().setHeight(60),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20))),
                      border: Border.all(color: Colors.white,width: ScreenUtil().setWidth(2))
                  ),
                  child: Text("立即预约",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(35)),),


                )


              ],

            ),
          ),

          new Container(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30),0, ScreenUtil().setWidth(30),ScreenUtil().setWidth(30)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text("关于糖尿病足神病症手临床医学是是的病足神病症应用", style: TextStyle(color: Color(0xFF333333),
                      fontSize: ScreenUtil().setSp(40),
                      fontWeight: FontWeight.w500),overflow: TextOverflow.ellipsis,maxLines: 2,textAlign: TextAlign.start,),
                  width: ScreenUtil().setWidth(1000),
                ),
                cYM(ScreenUtil().setHeight(10)),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("6段视频    4篇文章    225人关注", style: TextStyle(
                        color: Color(0xFF999999),
                        fontSize: ScreenUtil().setSp(35)),),

                    Material(

                      color: Colors.white30,
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _showTipContent
                                ? _showTipContent = false
                                : _showTipContent = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                          alignment: Alignment.center,
                          child: Text(_showTipContent ? "简介" : "简介 >",
                            style: TextStyle(color: Color(0xFF4AB1F2),
                                fontSize: ScreenUtil().setSp(35)),),
                        ),
                      ),
                    )


                  ],
                ),
                cYM(ScreenUtil().setHeight(10)),
                Visibility(
                    visible: _showTipContent,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text("6段视频    4篇文章    225人关注", style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: ScreenUtil().setSp(35)),),
                      ],
                    )
                )

              ],
            ),

          )


        ],

      ),

    );


  }

  // 分割线
  buildLine() {
    return Container(
      height: ScreenUtil().setHeight(12),
      color: Color(0xFFF5F5F5),
    );

  }

  buildListView(BuildContext context) {

    return Expanded(child:  ListView(
      controller: _scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      children: <Widget>[
        // 关键词
        buildCruxView(context),
        buildLine(),
        // 会议日程
        buildScheduleView(context),
        buildLine(),
        //相关专家
        getRowTextView("相关专家"),
        buildDoctorListView(context),
        buildLine(),
        //相关学会
        getRowTextView("相关学会"),
        buildLearnView(context),
        buildLine(),
        // 推荐视频
        getRowTextView("为您推荐"),
        buildLiveNoticeView(new List(),viewTypeMy),
        //评论
        getRowTextView("全部评论"),
        buildCommentView(context)

      ],

    ));

  }

  buildCruxView(BuildContext context) {

    return Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29), ScreenUtil().setWidth(40), ScreenUtil().setWidth(29),  ScreenUtil().setWidth(40)),
      height: ScreenUtil().setHeight(140),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Text("关键词",style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),

          ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
            scrollDirection: Axis.horizontal,
            children: <Widget>[

              new  Container(
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(40),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12)))
                ),
                child: Text("烧伤",style: TextStyle(color: Colors.black45,fontSize: ScreenUtil().setSp(35)),),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
              ),
              new  Container(
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(40),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12)))
                ),
                child: Text("烧伤",style: TextStyle(color: Colors.black45,fontSize: ScreenUtil().setSp(35)),),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
              ),
              new  Container(
                width: ScreenUtil().setWidth(200),
                height: ScreenUtil().setHeight(40),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(12)))
                ),
                child: Text("烧伤",style: TextStyle(color: Colors.black45,fontSize: ScreenUtil().setSp(35)),),
                margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
              )


            ],

          )

        ],

      ),

    );

  }

  buildScheduleView(BuildContext context) {

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: (){

        },
        child: Container(
          padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(29),0, ScreenUtil().setWidth(29), 0),
          height: ScreenUtil().setHeight(140),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("会议日程",style: TextStyle(color: Colors.black,fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.bold),),
              Icon(Icons.keyboard_arrow_right,size: ScreenUtil().setWidth(60),color:Colors.black26,)

            ],
          ),

        ),

      ),
    );

  }
  Widget getRowTextView(String type){

    return Container(
      color: Colors.white,
      height: ScreenUtil().setHeight(55),
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
      padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(42), 0, ScreenUtil().setWidth(42), 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(type,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w800),),
          new GestureDetector(
            child: Container(
              child: Row(
                children: <Widget>[

                  Visibility(
                    child:    new  InkWell(
                      child:  Image.asset(wrapAssets("tab/tab_live_iv1.png"),width: ScreenUtil().setWidth(40),height: ScreenUtil().setWidth(40),),
                      onTap: (){
                        setState(() {
                        });

                      },
                    ),
                    visible: type=="视频"?true:false,

                  ),

                  cXM(ScreenUtil().setWidth(60)),

                  Visibility(
                      visible: type.contains("相关")||type.contains("产品")?false:true,
                      child: Row(
                        children: <Widget>[
                          Text("更多"+type,style: TextStyle(color:Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
                          Icon(Icons.arrow_forward_ios,color: Colors.black12,size: ScreenUtil().setWidth(35),),
                        ],
                      )
                  )

                ],

              ),
            ),
            onTap: (){
              type=="热门视频"?RRouter.push(context, Routes.liveMeeting,{"title":"11"}):
              RRouter.push(context, Routes.videoListPage,{});
            },

          ),

        ],


      ),

    );

  }
  ///
  ///  直播预告布局
  ///
  Widget buildLiveNoticeView(List<String> list,int viewType){

    list.add("1");
    list.add("1");
    list.add("1");
    return list==null?Container():viewType==0?GridView.count(
      shrinkWrap: true ,
      physics: new NeverScrollableScrollPhysics(),
      //水平子Widget之间间距
      crossAxisSpacing: ScreenUtil().setWidth(20),
      //垂直子Widget之间间距
      mainAxisSpacing: ScreenUtil().setHeight(10),
      //GridView内边距
      padding: EdgeInsets.all(ScreenUtil().setWidth(29)),
      //一行的Widget数量
      crossAxisCount: 2,
      //子Widget宽高比例
      //子Widget列表
      children: list.getRange(0,2).map((item) => itemVideoView(item)).toList(),
    ): ListView.builder(
        shrinkWrap: true ,
        padding: EdgeInsets.all(0),
        physics: new NeverScrollableScrollPhysics(),
        itemCount: list.length,
        itemBuilder: (context,index){
          return getLiveItemView(context,list);
        }
    );
  }
  ///
  ///  热门视频 item
  ///
  Widget itemVideoView(String list) {


    return  InkWell(
      onTap: (){

      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(wrapAssets("tab/tab_live_img.png"),width: ScreenUtil().setWidth(501),height: ScreenUtil().setHeight(288),fit: BoxFit.fill,),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text("湖南湘中医联盟肛肠疾病高峰学术论坛",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("2019-09-20",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                  Text("2269次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(35)),),
                ],
              ),
            )

          ],
        ),

      ),
    );


  }

  ///
  ///   列表item
  ///
  Widget getLiveItemView(context,List listBean){

    return  GestureDetector(

      onTap: (){
        //  RRouter.push(context, Routes.videoDetailsPage,{"reviewId":listBean.id});
      },

      child: new Container(
        height: ScreenUtil().setHeight(250),
        padding: EdgeInsets.fromLTRB( ScreenUtil().setWidth(27), ScreenUtil().setHeight(27), 0,  ScreenUtil().setHeight(40)),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            // Icon(Icons.apps,size: 110,color: Colors.blueAccent,),
            //  wrapImageUrl(listBean.image,110.0, 110.0),
            Image.asset(wrapAssets("tab/tab_live_img.png"),fit: BoxFit.fill,height: ScreenUtil().setHeight(215),width:ScreenUtil().setWidth(288)),
            //  new Image(image: new CachedNetworkImageProvider("http://via.placeholder.com/350x150"),width: 110,height: 110,color: Colors.black,),
            cXM(ScreenUtil().setHeight(20)),
            new Container(
                width: ScreenUtil().setWidth(720),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text("湖南湘中医联盟肛肠疾病高峰论坛学术交流会",style: TextStyle(color: Color(0xFF333333),fontWeight: FontWeight.w500,fontSize: ScreenUtil().setSp(37)),maxLines: 2,overflow: TextOverflow.ellipsis,),

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

                        //       Text("看录播",style: TextStyle(color: Colors.greenAccent),)

                      ],
                    ),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  Row(
                          children: <Widget>[
                            Icon(Icons.access_time,size: ScreenUtil().setSp(32),color: Colors.black45,),
                            cXM(5),
                            Text("2019-12-01  03:33:00",style: TextStyle(color: Colors.black45,fontSize:  ScreenUtil().setSp(32)),),
                          ],

                        ),

                        //       Text("看录播",style: TextStyle(color: Colors.greenAccent),)

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
  ///  横向滑动专家列表
  ///
  Widget buildDoctorListView(BuildContext context) {

    return Container(
      margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), ScreenUtil().setHeight(30), 0, ScreenUtil().setHeight(30)),
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

  Widget buildItemDoctorView() {

    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(40)),
      width: ScreenUtil().setWidth(200),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Image.asset(wrapAssets("tab/tab_me_sele.png"),width: ScreenUtil().setWidth(200),height: ScreenUtil().setHeight(200),fit: BoxFit.fill,),
          Text("李英爱",style: TextStyle(fontWeight: FontWeight.w600,fontSize: ScreenUtil().setSp(35)),),
          Text("中医大师",style: TextStyle(fontSize: ScreenUtil().setSp(30)),)


        ],



      ),

    );

  }

  ///
  ///  相关学会布局
  ///
  Widget buildLearnView(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(30)),
      child: Column(
        children: <Widget>[

          Container(
            height: ScreenUtil().setHeight(100),
            child: Row(

              children: <Widget>[
                cXM(ScreenUtil().setWidth(10)),
                Image.asset(wrapAssets("tab/tab_doc.png"),width: ScreenUtil().setWidth(90),height: ScreenUtil().setHeight(90),),
                cXM(ScreenUtil().setWidth(30)),
                Text("中华医学会",style: TextStyle(),)
              ],
            ),

          )



        ],
      ),



    );


  }


  ///
  ///  评论布局
  ///
  buildCommentView(BuildContext context) {

    return ListView.builder(
      controller: _scrollController,
      shrinkWrap: true,
      padding: EdgeInsets.all(ScreenUtil().setWidth(24)),
      physics: new NeverScrollableScrollPhysics(),
      itemCount: 5,
      itemBuilder: (context,index){
        return itemCommentView(context,index);
      },

    );


  }

  ///
  ///  评论item
  ///
  itemCommentView(BuildContext context, int index) {

    return Container(
        padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(30), 0, ScreenUtil().setWidth(30), 0),
        height: ScreenUtil().setHeight(140),
        child: Column(

          children: <Widget>[
            new  Expanded(child: Row(
              children: <Widget>[
                Image.asset(wrapAssets("user/avatar.png"),width: ScreenUtil().setWidth(90),height: ScreenUtil().setHeight(90),),
                cXM(ScreenUtil().setWidth(24)),

                Expanded(child:      new  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text.rich(TextSpan(
                        children: [
                          TextSpan(
                              text: "王雪: ",
                              style: TextStyle(color: Colors.blue,fontSize: ScreenUtil().setSp(35))
                          ),
                          TextSpan(
                              text: "太精彩了！哈啊哈哈哈",
                              style: TextStyle(color:Color(0xff333333),fontSize: ScreenUtil().setSp(35))
                          ),
                        ]
                    )),
                    cYM(ScreenUtil().setHeight(20)),
                    Text("2019-12-15 11:25:00",style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(0xff999999)),),



                  ],
                )),

                new Container(
                  alignment: Alignment.bottomRight,
                  height: double.infinity,
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.textsms,size: ScreenUtil().setWidth(50),color: Color(0xff999999),),
                      cXM(ScreenUtil().setWidth(10)),
                      Text("回复",style: TextStyle(fontSize: ScreenUtil().setSp(30),color: Color(0xff999999)),)


                    ],

                  ),
                  /* child:  FlatButton.icon(padding:EdgeInsets.all(0),onPressed: (){}, icon: Icon(Icons.textsms), label: Text("回复")),*/

                )


              ],
            ),
            ),
            Divider(color: Colors.black12,height: ScreenUtil().setHeight(2),)

          ],
        )
    );
  }

}
