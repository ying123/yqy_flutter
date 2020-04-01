import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/home/tab/bean/special_details_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

class SpecialDetailPage extends StatefulWidget {

  String id;


  SpecialDetailPage(this.id);

  @override
  _SpecialDetailPageState createState() => _SpecialDetailPageState();
}

class _SpecialDetailPageState extends State<SpecialDetailPage> {

  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  int viewTypeMy = 0;// 当前的排列方式  我的预约排列   0 gridview  1  listview

  bool _showTipContent  = false;// 是否显示简介

  ScrollController _scrollController =  new ScrollController(); // 解决嵌套滑动冲突  设置统一滑动

  SpecialDetailsInfo _specialDetailsInfo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(

        title: Text("专题详情",style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading:InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child:  Icon(Icons.arrow_back_ios,color: Colors.black38,),
        )
      ),

   body: LoadStateLayout(
   state: _layoutState,
   errorRetry: () {
    setState(() {
    _layoutState = LoadState.State_Loading;
    });
    this.initData();
    },
    successWidget:_specialDetailsInfo==null?Container(): ListView(
        controller: _scrollController,
        children: <Widget>[
        buildBannerView(context),
       buildContentView(context),
       buildLineView(),
       getRowTextView("视频"),//热门会议标题栏
       getHotVideo(_specialDetailsInfo.videoList),//热门会议视频横向列表
       buildLineView(),
       getRowTextView("文章"),//热门会议标题栏
       buildNewsListView(),
       //*   getRowTextView("相关专家"),
    /*   buildDoctorListView(context),
      buildLineView(),
      getRowTextView("相关学会"),
      buildLearnView(context),
      buildLineView(),
      getRowTextView("产品推荐"),
      buildProductPublicityView(context)*/
      ],
     ) ,

      )
    );
  }

  buildBannerView(BuildContext context) {

    return   Container(

      height: ScreenUtil().setHeight(403),
      child: wrapImageUrl(_specialDetailsInfo.image, double.infinity, double.infinity),

    );



  }


  Widget getHotVideo(List<SpecialDetailsInfoVideoList>  list){

    return list==null?Container(): GridView.count(
      controller: _scrollController,
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
      children: list.getRange(0,list.length).map((item) => itemVideoView(item)).toList(),
    );
  }




  Widget  buildContentView(BuildContext context) {

    return  new Container(
      padding: EdgeInsets.all(ScreenUtil().setWidth(30)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_specialDetailsInfo.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(40),fontWeight: FontWeight.w500),),
              /*  Container(
                  alignment: Alignment.center,
                  width: ScreenUtil().setWidth(120),
                  height: ScreenUtil().setHeight(50),
                  decoration: BoxDecoration(
                      color: Color(0xFF4AB1F2),
                      borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(20)))
                  ),
                  child: Text("关注",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(34)),),
                )*/
              ],
            ),
            cYM(ScreenUtil().setHeight(20)),
            new  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(_specialDetailsInfo.videoList.length.toString()+"段视频    "+_specialDetailsInfo.articleList.length.toString()+"篇文章",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(35)),),

                Material(
                  color: Colors.white30,
                  child: InkWell(
                    onTap: (){

                      setState(() {
                        _showTipContent?_showTipContent=false:_showTipContent = true;
                      });

                    },
                    child:   Container(
                      padding: EdgeInsets.all(ScreenUtil().setWidth(10)),
                      alignment: Alignment.center,
                      child: Text(_showTipContent?"简介":"简介 >",style: TextStyle(color: Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(35)),),
                    ) ,
                  ),
                )



              ],
            ),
            cYM(ScreenUtil().setHeight(20)),
           Visibility(
             visible: _showTipContent,
               child:  Html(
                 data: _specialDetailsInfo.content,
               )
           )

          ],
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

        ],


      ),

    );

  }

  ///
  ///  热门视频 item
  ///
  Widget itemVideoView(SpecialDetailsInfoVideoList bean) {


    return  InkWell(
      onTap: (){
        //   RRouter.push(context, Routes.livePaybackPage, {});
        RRouter.push(context, Routes.specialDetailsVideoPage,{"id": bean.id.toString()},transition:  TransitionType.cupertino);
      },
      child: Container(
        width: double.infinity,
        height: ScreenUtil().setHeight(412),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            wrapImageUrl(bean.image, ScreenUtil().setWidth(501), ScreenUtil().setHeight(288)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14), ScreenUtil().setHeight(26), ScreenUtil().setWidth(14), 0),
              child: Text(bean.title,style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35),fontWeight: FontWeight.w500),maxLines: 1,overflow: TextOverflow.ellipsis,),
            ),
            cYM(setH(5)),
            Container(
              padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(14),0, ScreenUtil().setWidth(14), 0),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(bean.createTime,style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(32)),),
                  Text(bean.pv.toString()+"次播放",style: TextStyle(color: Color(0xFF7E7E7E),fontSize: ScreenUtil().setSp(32)),),
                ],
              ),
            )

          ],
        ),

      ),
    );


  }




  Widget buildNewsListView() {

    return  ListView.builder(
        controller: _scrollController,
        shrinkWrap: true ,
        physics: new NeverScrollableScrollPhysics(),
        itemCount:_specialDetailsInfo.articleList.length,
        itemBuilder: (context,index) {

          return  getNewsItemView(context,_specialDetailsInfo.articleList[index]);

        }

    );

  }

  ///
  ///  资讯布局
  ///
  Widget getNewsItemView(BuildContext context,SpecialDetailsInfoArticleList xlist) {


    return  new GestureDetector(

      onTap: (){
        RRouter.push(context, Routes.specialDetailsWebPage, {"id":xlist.id});
      },
      child: new Container(

        color: Colors.white,

        height: setH(200),

        child: new Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: <Widget>[


            Row(

              children: <Widget>[

                Expanded(child:   Column(

                  children: <Widget>[

                    new   Container(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(xlist.title,style: TextStyle(color: Color(0xFF333333),fontSize: setSP(38),fontWeight: FontWeight.w500),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    ),

                    cYM(setH(20)),

                    new  Container(

                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                      child:  new  Row(


                        children: <Widget>[

                          buildText(xlist.createTime??"",size: 32,color:"#FF7E7E7E"),


                          xlist.createTime==null?Container():cXM(setW(100)),

                          buildText(xlist.pv.toString()+"次阅读",size: 32,color:"#FF7E7E7E"),

                        ],

                      ),
                    ),

                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                ),

                xlist.image==null?Container():wrapImageUrl(xlist.image, setW(200), setH(120)),
                cXM(setW(20))

              ],
            ),
            Divider(height: 1,color: Colors.black26,)



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

 Widget buildLineView() {
    return    Container(color: Color(0xfff5f5f5),height: ScreenUtil().setHeight(20),);

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
  ///   产品推荐布局
  ///
 Widget buildProductPublicityView(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(ScreenUtil().setWidth(45)),
      child: Row(

        children: <Widget>[

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Image.asset(wrapAssets("tab/tab_doc_sele.png"),width: ScreenUtil().setWidth(230),height: ScreenUtil().setHeight(259),fit: BoxFit.fill,),
              cYM(ScreenUtil().setHeight(42)),
              Text("复方黄柏液涂剂",style: TextStyle(color: Color(0xFF333333),fontSize: ScreenUtil().setSp(35)),)

            ],
          )



        ],
      ),

    );

  }

  void initData() {

    NetUtils.requestSpecialInfo(widget.id)
        .then((res){

        if(res.code==200){

          setState(() {

            _specialDetailsInfo =   SpecialDetailsInfo.fromJson(res.info);
            _layoutState = loadStateByCode(res.code);

          });


        }


    });

  }
}
