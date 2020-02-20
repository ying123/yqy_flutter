import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/ui/guide/bean/guide_index_entity.dart';
import 'package:yqy_flutter/ui/guide/tab_guide.dart';
import 'package:yqy_flutter/utils/margin.dart';


class _TabData {
  final Widget tab;
  final Widget body;
  _TabData({this.tab, this.body});
}

/*
final _tabDataList = <_TabData>[
  _TabData(tab: Text(''), body: TabGuidePage()),
  _TabData(tab: Text(''), body: TabGuidePage()),
  _TabData(tab: Text(''), body: TabGuidePage()),
  _TabData(tab: Text(''), body:TabGuidePage()),
  _TabData(tab: Text('建议'), body:TabGuidePage()),
  // _TabData(tab: Text('规范解读'), body: TabGFPage())
];
*/



class GuidePage extends StatefulWidget {
  @override
  _GuidePageState createState() => _GuidePageState();
}

class _GuidePageState extends State<GuidePage> with SingleTickerProviderStateMixin {

  GuideIndexInfo _guideIndexInfo; // 选项卡数据


 /* var tabBarList = _tabDataList.map((item) => item.tab).toList();
  var tabBarViewList = _tabDataList.map((item) => item.body).toList();*/
  var tabBarList;
  var tabBarViewList;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initTabData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
    return Scaffold(

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title:_guideIndexInfo==null?Container(): TabBar(
          controller: _tabController,
          tabs:tabBarList,
          indicatorColor: Colors.white, //指示器颜色 如果和标题栏颜色一样会白色
          isScrollable: true, //是否可以滑动
          labelPadding: EdgeInsets.only(right: ScreenUtil().setWidth(80)),
          labelColor: Color(0xFF333333) ,
          unselectedLabelColor: Color(0xFF7E7E7E),
          indicatorSize: TabBarIndicatorSize.label,
          unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(40)), //防止字体抖动 不用此方法
          labelStyle: TextStyle(fontSize: ScreenUtil().setSp(52),fontWeight: FontWeight.bold),  //防止字体抖动 不用此方法
        ),
        titleSpacing:  ScreenUtil().setWidth(35),
        actions: <Widget>[
           Material(
             color: Colors.white,
             child: InkWell(
               child: Container(
                 margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                 padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                 child:  Image.asset(wrapAssets("search.png"),width: ScreenUtil().setWidth(52),height: ScreenUtil().setHeight(52),),
               ),
             ),
           ),
          SizedBox(width: ScreenUtil().setWidth(10),),
        ],
      ),
      body:_guideIndexInfo==null?Container(): TabBarView(
          controller: _tabController,
          children: tabBarViewList,
      ),

    );
  }


  ///
  ///  请求导航栏选项卡的数据
  ///
  void initTabData() {

    NetUtils.requestDocumentIndex()
        .then((res){

          if(res.code==200){

           _guideIndexInfo =   GuideIndexInfo.fromJson(res.info);

            setState(() {

              _guideIndexInfo.cateList.insert(0,new GuideIndexInfoCateList(name: "推荐"));
              tabBarList = _guideIndexInfo.cateList.map((item)=>Text(item.name)).toList();
              tabBarViewList = _guideIndexInfo.cateList.map((item)=>TabGuidePage(item.id.toString())).toList();
              _tabController = TabController(vsync: this, length: tabBarList.length);


            });
          }


    });


  }
}
