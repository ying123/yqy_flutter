import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/user/collect/bean/cl_video_entity.dart';
import 'package:yqy_flutter/ui/user/goods/bean/my_goods_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///
///  我的点赞列表
///
class MyGoodsPage extends StatefulWidget {
  @override
  _MyGoodsPageState createState() => _MyGoodsPageState();
}

class _MyGoodsPageState extends State<MyGoodsPage> {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  int page = 1;

  MyGoodsEntity _myGoodsEntity;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }

  void _onRefresh() async{
    page = 1;
    initData();
  }

  void _onLoading() async{
    page ++;
    initData();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: getCommonAppBar("我的点赞"),
      body:  new SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child:
          _myGoodsEntity==null?Container(): ListView.separated(
            shrinkWrap: true,
            itemCount: _myGoodsEntity.info.length,
            itemBuilder: (context,index){
              return getVideoTabView(context,_myGoodsEntity.info[index]);

            },
            separatorBuilder: (context,index){
              return Container(
                height: setH(1),
                color: Colors.black26,
              );

            },
          )

      ),
    );

  }
  ///
  ///  视频选项卡的页面
  ///
  getVideoTabView(BuildContext context,MyGoodsInfo bean) {

    return  InkWell(

      onTap: (){

        RRouter.push(context, Routes.doctorVideoInfoPage,{"id":bean.id});

      },

      child:  Container(
        margin: EdgeInsets.fromLTRB(0, setH(0), 0, setH(20)),
        padding: EdgeInsets.all(setW(30)),
        color: Colors.white,
        child:  new Column(

          children: <Widget>[

            Container(
              height: setH(450),
              child: wrapImageUrl(bean.video==null?"":bean.video.image, double.infinity, double.infinity),
            ),
            cYM(setH(28)),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child:  buildText(bean.video==null?"":bean.video.title,size: 40),)
              ],
            ),
            cYM(setH(28)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[

                buildText(bean.video==null?"":bean.video.pv.toString()+"次播放",color: "#ff999999",size: 36),

                //  buildText("收藏"),

                //  buildText("点赞"),
              ],
            )

          ],
        ),

      ),
    );


  }
  void initData() {

     NetUtils.requestUsersMyGood(page)
        .then((res){

      if(res.code==200){


          if(page==1){
            _myGoodsEntity =   MyGoodsEntity.fromJson(res.toJson());
            _refreshController.refreshCompleted();

          }else{

            if(MyGoodsEntity.fromJson(res.toJson()).info.length==0){
              _refreshController.loadNoData();
            }else{
              _myGoodsEntity.info.addAll(MyGoodsEntity.fromJson(res.toJson()).info);
              _refreshController.loadComplete();

            }

          }
        setState(() {

        });
      }

    });

  }
}
