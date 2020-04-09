import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/user/collect/bean/cl_news_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClNewsPage extends StatefulWidget {
  @override
  _ClNewsPageState createState() => _ClNewsPageState();
}

class _ClNewsPageState extends State<ClNewsPage> {

  int page = 1;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  ClNewsEntity _clNewsEntity;

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
    return _clNewsEntity==null?Center(child: Text("暂无数据"),): SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:

        ListView.separated(itemBuilder: (context,index) {
          return getListItemView(context,_clNewsEntity.info[index]);
        }, separatorBuilder:  (context,index) {
          return Container(
            height: setH(1),
            color: Colors.black12,
          );

        }, itemCount: _clNewsEntity==null?0:_clNewsEntity.info.length)

    );
  }


  void initData() {

    NetUtils.requestUsersCollectionDocu(page)
        .then((res){

      if(res.code==200){

        setState(() {
          _clNewsEntity =   ClNewsEntity.fromJson(res.toJson());
          if(page==1){

            _refreshController.refreshCompleted();

          }else{

            if(_clNewsEntity.info.length==0){

              _refreshController.loadNoData();
            }else{

              _clNewsEntity.info.addAll(ClNewsEntity.fromJson(res.toJson()).info);
              _refreshController.loadComplete();

            }

          }

        });

      }

    });

  }

  Widget getListItemView(BuildContext context, ClNewsInfo info) {

    return  new GestureDetector(

      onTap: (){
        RRouter.push(context, Routes.newsContentPage, {"id":info.id});
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
                      child: Text(info.medical.title,style: TextStyle(color: Color(0xFF333333),fontSize: setSP(38),fontWeight: FontWeight.w500),maxLines: 2,overflow: TextOverflow.ellipsis,),
                    ),

                    cYM(setH(20)),

                    new  Container(

                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),

                      child:  new  Row(


                        children: <Widget>[

                          buildText(info.createTime??"",size: 32,color:"#FF7E7E7E"),


                          info.createTime==null?Container():cXM(setW(100)),

                          buildText(info.medical.pv.toString()+"次阅读",size: 32,color:"#FF7E7E7E"),

                        ],


                      ),
                    ),

                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                ),

                info.image.isEmpty?Container():wrapImageUrl(info.image, setW(200), setH(120)),

                cXM(setW(20))

              ],
            ),

          ],


        ),

      ),
    );


  }
}
