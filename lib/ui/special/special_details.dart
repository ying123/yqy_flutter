import 'package:flutter/material.dart';
import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/common/constant.dart' as AppColors;
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';

import 'bean/special_banner_entity.dart';
import 'bean/special_cate_entity.dart';
import 'bean/special_list_entity.dart';
import 'dart:convert';


class SpecialDetailsPage extends StatefulWidget {


  String title;
  var  id;


  SpecialDetailsPage(this.title,this.id);

  @override
  _SpecialDetailsPageState createState() => _SpecialDetailsPageState();


}

class _SpecialDetailsPageState extends State<SpecialDetailsPage>  with TickerProviderStateMixin{
  TabController _tabController;


  List<Widget> tabList = new List();


  int page = 1;

  var cid;
  List<SpecialCateInfo> lists;

  SpecialBannerEntity _bannerEntity;
  SpecialCateEntity _cateEntity;
  SpecialListEntity _listEntity;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }


  void loadData() async{

      Future.wait(
       [
         NetworkUtils.requestSpecialBanner(widget.id), //轮播图
         NetworkUtils.requestSpecialCate(widget.id), //分类
         NetworkUtils.requestSpecialCateList(widget.id,cid,page), //分类列表数据
       ]

      ).then((ress){
      //  json.decode(response.data)

        _bannerEntity = SpecialBannerEntity.fromJson(ress[0].toJson()) ;

        _cateEntity = SpecialCateEntity.fromJson(ress[1].toJson());

       _listEntity = SpecialListEntity.fromJson(ress[2].info);


     //   print("_bannerEntity=============="+_bannerEntity.toString());
      //  print("_cateEntity=============="+_cateEntity.toString());
   // / print("_listEntity=============="+_listEntity.toString());

        setState(() {

          lists = _cateEntity.info;
          List list =   lists.map((e)=>e.title).toList();

          _tabController = TabController(vsync: this, length: list.length??0);
          list.forEach((e){

              tabList.add(Text(e));

            });

        });

      });

  }


  void  syncData() async{


    page = 1;
    NetworkUtils.requestSpecialCateList(widget.id,cid,page)
        .then((res){

      setState(() {
        _listEntity = SpecialListEntity.fromJson(res.info);
      });
    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(widget.title.toString()),
        centerTitle: true,

      ),

      body: new Column(

        children: <Widget>[
          _bannerEntity==null?Container():getBannerView(_bannerEntity.info),
          tabList==null||_tabController==null?Container():Container(
            height: 40,
            child: TabBar(
              controller: _tabController,
              tabs: tabList,
              indicatorColor: Colors.blueAccent, //指示器颜色 如果和标题栏颜色一样会白色
              isScrollable: true, //是否可以滑动
              labelColor: Colors.blueAccent ,
              unselectedLabelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.label,
              unselectedLabelStyle: TextStyle(fontSize: 16),
              labelStyle: TextStyle(fontSize: 16),
              indicatorPadding: EdgeInsets.only(top: 5),
              onTap: (index){

                 cid = lists[index].id;

                 syncData();


              },
            ),


          ),
          _listEntity==null||_listEntity.lists==null?Container():Expanded(

            child: Padding(
                padding: EdgeInsets.all(10),
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    //纵轴间距
                    mainAxisSpacing: 10.0,
                    //横轴间距
                    crossAxisSpacing: 10.0,
                  ),
                  itemCount: _listEntity.lists.length,
                  itemBuilder: (BuildContext context, int index){
                    return getItemView(_listEntity.lists[index]);
                  }

              ),


            )
          )

        ],
      ),

      
      
    );
  }



  Widget getBannerView(	List<SpecialBannerInfo> data) {



    if(data==null){

      return Container();
    }

    return BannerSwiper(
      //width  和 height 是图片的高宽比  不用传具体的高宽   必传
      height: 108,
      width: 54,
      //轮播图数目 必传
      length: data.length??1,
      //轮播的item  widget 必传
      getwidget: (index) {
        return new GestureDetector(
            child:  Image.network(
              data[index % data.length].image,
              fit: BoxFit.fill,
            ),
            onTap: () {
              //点击后todo
            });
      },
    );
  }


  Widget getItemView(SpecilaListList bean) {


    return GestureDetector(

      onTap: (){
       bean.type==1?RRouter.push(context, Routes.specialDetailsVideoPage,{"id":bean.id,}):RRouter.push(context, Routes.specialDetailsWebPage,{"id":bean.id});
      },
      child:  new Container(
        child: Column(
          children: <Widget>[
            Image.network(bean.image,width: double.infinity,height: 120,fit: BoxFit.fill,),
            cYM(5),
            RichText(
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(

                  children: <TextSpan>[

                    new TextSpan(
                        text:  bean.type==1?"[视频]":"[文章]",
                        style: TextStyle(
                            color:   bean.type==1?Colors.red:Colors.blueAccent
                        )

                    ),

                    new TextSpan(
                        text: " "+bean.title,
                        style: TextStyle(
                            color: Colors.black
                        )

                    ),


                  ]


              ),

            )




          ],



        ),

      ),
    );



  }


}
