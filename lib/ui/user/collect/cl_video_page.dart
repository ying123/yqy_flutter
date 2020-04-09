import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/user/collect/bean/cl_video_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClVideoPage extends StatefulWidget {
  @override
  _ClVideoPageState createState() => _ClVideoPageState();
}

class _ClVideoPageState extends State<ClVideoPage> {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  int page = 1;

  ClVideoEntity _clVideoEntity;


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
    return    SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:
        _clVideoEntity==null?Container(): ListView.separated(
          shrinkWrap: true,
          itemCount: _clVideoEntity.info.length,
          itemBuilder: (context,index){
            return getVideoTabView(context,_clVideoEntity.info[index]);

          },
          separatorBuilder: (context,index){
            return Container(
              height: setH(1),
              color: Colors.black26,
            );

          },
        )

    );

  }
  ///
  ///  视频选项卡的页面
  ///
  getVideoTabView(BuildContext context,ClVideoInfo bean) {

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

     NetUtils.requestUsersCollectionVideo(page)
        .then((res){

      if(res.code==200){

        setState(() {
          _clVideoEntity =   ClVideoEntity.fromJson(res.toJson());
          if(page==1){

            _refreshController.refreshCompleted();

          }else{

            if(_clVideoEntity.info.length==0){
              _refreshController.loadNoData();
            }else{

              _clVideoEntity.info.addAll(ClVideoEntity.fromJson(res.toJson()).info);
              _refreshController.loadComplete();

            }

          }

        });

      }

    });

  }
}
