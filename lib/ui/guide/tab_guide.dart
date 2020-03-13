import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/guide/bean/guide_lists_entity.dart';
import 'package:yqy_flutter/ui/home/bean/news_list_entity.dart';
import 'package:yqy_flutter/ui/home/tab/bean/tab_news_index_entity.dart';
import 'package:yqy_flutter/ui/video/bean/video_list_entity.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:yqy_flutter/utils/margin.dart';


class TabGuidePage extends StatefulWidget {

  String id; // 当前页面分类ID


  TabGuidePage(this.id);

  @override
  _TabGuidePageState createState() => _TabGuidePageState();
}

class _TabGuidePageState extends State<TabGuidePage> with AutomaticKeepAliveClientMixin{



  //页面加载状态，默认为加载中
  LoadState _layoutState = LoadState.State_Loading;

  int page = 1;

  GuideListsInfo  _newsListEntity ;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);


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
  }



  void _onRefresh() async{
    page = 1;
    loadData();
  }

  void _onLoading() async{
    page ++;
    loadData();
  }

  loadData () async{
    NetUtils.requestDocumentLists(widget.id,page.toString())
        .then((res) {
      if(res.code==200){
        if(page>1){
          if (GuideListsInfo
              .fromJson(res.info)
              .lists.length == 0||GuideListsInfo
              .fromJson(res.info)
              .lists==null) {
            _refreshController.loadNoData();
          } else {
            _newsListEntity.lists.addAll(GuideListsInfo.fromJson(res.info).lists);
            _refreshController.loadComplete();
          }

        }else{
          _newsListEntity = GuideListsInfo.fromJson(res.info);
          _refreshController.refreshCompleted();
          _refreshController.resetNoData();
        }
      }
      setState(() {
        _layoutState = loadStateByCode(res.code);
      });
    });

  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(

      body:  LoadStateLayout(
      state: _layoutState,
      errorRetry: () {
        setState(() {
          _layoutState = LoadState.State_Loading;
        });
        this.loadData();
      },
      successWidget:
      SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child:  ListView.builder(
            itemCount:_newsListEntity==null?1:_newsListEntity.lists.length+1,
            itemBuilder: (context,index) {

              return  _newsListEntity==null?Container():index==0?cYMW(15):getLiveItemView(context,_newsListEntity.lists[index-1]);

            }

        ),

      ),

    ),


    );
  }

  Widget getLiveItemView(BuildContext context,GuideListsInfoList xlist) {
    return GestureDetector(

      onTap: (){

        RRouter.push(context, Routes.guideContentPage, {"id":xlist.id});
    //    RRouter.push(context, Routes.pdfViewPage, {"id":xlist.id});
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

                xlist.image==null?Container():wrapImageUrl(xlist.image, setW(200), setH(120))

              ],
            ),
            Divider(height: 1,color: Colors.black26,)



          ],


        ),

      ),
    );

  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}




