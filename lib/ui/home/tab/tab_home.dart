import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutter_marquee/flutter_marquee.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TabHomePage extends StatefulWidget {
  @override
  _TabHomePageState createState() => _TabHomePageState();
}


class _TabHomePageState extends State<TabHomePage> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  // 声明一个list，存放image Widget
  List<String> imageList = List();

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageList.add(
        "http://minimg.hexun.com/i4.hexunimg.cn/mobile_show/image/20190701/20190701121331_376_621x310.jpg");
    imageList.add(
        "http://minimg.hexun.com/i7.hexun.com/2015-11-16/180596378_c324x234.jpg");
    imageList.add(
        "http://minimg.hexun.com/i7.hexun.com/2014-09-02/168105362_c324x234.jpg");
  }

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
    _refreshController.resetNoData();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
  //  items.add((items.length+1).toString());
    if(mounted)
      setState(() {
      });
    _refreshController.loadNoData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
        header: BezierCircleHeader(),
        footer: CustomFooter(
          builder: (BuildContext context,LoadStatus mode){
            Widget body ;
            if(mode==LoadStatus.idle){
              body =  Text("上拉加载");
            }
            else if(mode==LoadStatus.loading){
              body =  CupertinoActivityIndicator();
            }
            else if(mode == LoadStatus.failed){
              body = Text("加载失败！点击重试！");
            }
            else{
              body = Text("我是有底线的~");
            }
            return Container(
              height: 55.0,
              child: Center(child:body),
            );
          },
        ),
           child: ListView(
          padding: EdgeInsets.only(top: 0),
          children: <Widget>[

            cYMW(15),

            getBannerView(), //轮播图

            getMarqueeView(),//跑马灯

            getGridBtnView(), //图片按钮

            cYM(10),

            getRowTextView("热门会议"),//热门会议标题栏

            getHotVideo(["1","2"]),//热门会议视频横向列表
            cYM(10),
            getRowTextView("往期会议"),//热门会议标题栏
            getHisVideoView(),
            getHisVideoView(),
            cYM(10),
            getRowTextView("名医分享"),//往期会议标题栏
            getDocView(),
            getDocView()
            

          ],

        ),
      )
    );
  }


  Widget getBannerView() {
    return BannerSwiper(
      //width  和 height 是图片的高宽比  不用传具体的高宽   必传
      height: 108,
      width: 54,
      //轮播图数目 必传
      length: imageList.length,
      //轮播的item  widget 必传
      getwidget: (index) {
        return new GestureDetector(
            child: Image.network(
              imageList[index % imageList.length],
              fit: BoxFit.fill,
            ),
            onTap: () {
              //点击后todo
            });
      },
    );
  }

  Widget   getMarqueeView(){

    return Container(
      padding: EdgeInsets.all(20),
     height: 60,
     color: Colors.white,
      child: Row(

        children: <Widget>[

          Icon(Icons.notifications,size: 22,color: Colors.blueAccent,),
          cXM(5),
          Container(
            height:60,
            width: 300,
            child:  FlutterMarquee(
                texts: ["药监局发布医疗器械唯一标识系统规则", "国家药监局：无资质零售药店不得再进购氨酚进必考通片", "绿叶制药发布2019年上半年业绩公告", "国家药品监控目录冲击！中药注射剂板块业绩下滑严重"].toList(),
                onChange: (i) {
                  print(i);
                },
                duration: 4),
          )


        ],

      ),

    );

  }


  Widget getGridBtnView(){
    return Container(

      height: 80,
      color: Colors.white,
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: <Widget>[

          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.android,size: 30,),
              cYM(5),
              Text("会议直播")

            ],


          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.android,size: 30,),
              cYM(5),
              Text("往期会议")

            ],


          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.android,size: 30,),
              cYM(5),
              Text("专题视频")

            ],


          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(Icons.android,size: 30,),
              cYM(5),
              Text("医学园")

            ],


          )


        ],


      ),


    );
  }


  Widget getRowTextView(String type){


    return Container(
      color: Colors.white,
      height: 50,
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          
        new  Row(
            
            children: <Widget>[
              Text(type,style: TextStyle(color: Colors.black,fontSize: 18),),
              cXM(3),
              Visibility(
                visible: type=="热门会议"?true:false,
                  child:  Icon(Icons.whatshot,color: Colors.red,size: 18,)
              )
              
            ],
            
          ),


        new GestureDetector(

          child: Row(

            children: <Widget>[
              Text("更多",style: TextStyle(color: Colors.black26,fontSize: 14),),
              cXM(2),
              Icon(Icons.arrow_forward_ios,color: Colors.black12,size: 16,),

            ],

          ),
        
        onTap: (){
            
        },

        ),



          
          
        ],
        
        
      ),

    );

  }

  Widget getHotVideo(List list){

    return  Container(
      color: Colors.white,
      height: 100,
      child: Row(

        children: <Widget>[

        cXM(10),
       new  Expanded(
          child: Container(
            alignment: Alignment.center,
            color: Colors.deepPurple,
            child: Text(list[0]),
          ),

        )  ,
        cXM(10),
        new   Expanded(
          child: Container(
            alignment: Alignment.center,
            color: Colors.cyanAccent,
            child: Text(list[1]),
          ),

        )  ,
        cXM(10),

        ],

      ),


    );
  }


  Widget getHisVideoView(){

    return Container(
      height: 100,
      color: Colors.white,
      child: Row(

        children: <Widget>[

          Icon(Icons.apps,size: 100,color: Colors.blueAccent,),
          cXM(8),
         new Container(
             decoration: new BoxDecoration(
                 border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
             ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  padding: EdgeInsets.only(top: 15),
                  child: Text("山东省肛肠专业科室管理交流暨2019年济南医学会钢厂专业委员会学术会议",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),maxLines: 2,overflow: TextOverflow.ellipsis,),
                  width: 240,
                ),
                cYM(10),
                new Row(
                  children: <Widget>[
                    Icon(Icons.access_time,size: 16,color: Colors.black45,),
                    cXM(10),
                    Text("2019-07-20 08:30",style: TextStyle(color: Colors.black45,fontSize: 14),),
                  ],
                ),


              ],

            )





          )


        ],


      ),

    );

  }


  Widget getDocView(){
    
    return Container(
      color: Colors.white,
      height: 100,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Row(
        children: <Widget>[
          
          Icon(Icons.account_circle,size: 90,),
          cXM(5),
          Container(
            width: 240,
            decoration: new BoxDecoration(
                border: new Border(bottom:BorderSide(color: Colors.black12,width: 1) )
            ),
            child:   new  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                cYM(15),
                Text("张三十",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w700,fontSize: 16),),
                cYM(5),
                Text("该用户尚未填写简介....",style: TextStyle(color: Colors.black45,fontSize: 14),),
                cYM(5),
                new Row(
                  children: <Widget>[
                    Icon(Icons.person,size: 16,color: Colors.black45,),
                    cXM(10),
                    Text("石家庄市中医院分院",style: TextStyle(color: Colors.black45,fontSize: 14),),

                  ],

                ),
              ],

            ),

          )


          
          
        ],
        
        
      ),
      
      
    );
    
  }
  

}


