import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/doctor/bean/doctor_info_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';


class DoctorHomePage extends StatefulWidget {

  final String userId;

  const DoctorHomePage({Key key, this.userId}) : super(key: key);


  @override
  _DoctorHomePageState createState() => _DoctorHomePageState();
}

class _DoctorHomePageState extends State<DoctorHomePage> with SingleTickerProviderStateMixin {


  TabController _tabController;

  DoctorInfoInfo _doctorInfoInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    loadData();
  }
  void loadData() {

    NetworkUtils.requestDoctorHome(widget.userId)
        .then((res){

      int statusCode = int.parse(res.status);
      if(statusCode==9999){
        _doctorInfoInfo = DoctorInfoInfo.fromJson(res.info);
        setState(() {

        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return _doctorInfoInfo==null?Container(): new  CustomScrollView(

      slivers: <Widget>[

        SliverAppBar(
          title: Text("医生主页"),
          centerTitle: true,
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios,color: Colors.white,),
          ),
          pinned: true,
          expandedHeight: 360.0,
          bottom: TopCommonView(_tabController),
          flexibleSpace: new FlexibleSpaceBar(
              background: Container(

                child: new Stack(
                  children: <Widget>[
                    Image.network(_doctorInfoInfo.background,width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
                    Center(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 100,
                          ),
                          Image.network(_doctorInfoInfo.userPhoto,width: 80,height: 80,fit: BoxFit.fill,),
                          cYM(10),
                          Text(_doctorInfoInfo.realName,style: TextStyle(color: Colors.white,fontSize: 18),),
                          cYM(10),
                          Text(_doctorInfoInfo.hName,style: TextStyle(color: Colors.white,fontSize: 14),),
                          cYM(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("关注：0",style: TextStyle(color: Colors.white,fontSize: 14),),
                              SizedBox(
                                width: 20,
                              ),
                              Text("粉丝：0",style: TextStyle(color: Colors.white,fontSize: 14),),

                            ],

                          )
                        ],


                      ),


                    )
                  ],
                ),
              )

          ),
        ),


        SliverToBoxAdapter(
            child: Container(

              color: Colors.white,

              height:1000 ,

              child: TabBarView(
                  controller: _tabController,
                  children: [ Container(
                    height: 100,
                    child: Text("暂无数据",style: TextStyle(fontSize: 16,color: Colors.black45),),
                  ),Container(
                    height: 100,
                    child: Text("暂无数据",style: TextStyle(fontSize: 16,color: Colors.black45),),
                  )]
              ),
            )



        )


      ],



    );
  }

  getView() {
    return ListView(

      children: <Widget>[
        getListItemView(0),
        getListItemView(0),
        getListItemView(0),
        getListItemView(0),
        getListItemView(0),
        getListItemView(0),
        getListItemView(0),
        getListItemView(0),

      ],
    );
  }



}
getListItemView(int v) {
  return Container(
      height: 200,
      color: Colors.white,
  );

}


class TopCommonView extends StatefulWidget  implements PreferredSizeWidget {

  TabController _tabController;

  TopCommonView(this._tabController);

  @override
  _TopCommonViewState createState() => _TopCommonViewState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);
}

class _TopCommonViewState extends State<TopCommonView> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
          height: 50,
          width: double.infinity,
          color: Colors.white,
          child:  TabBar(
            controller: widget._tabController,
            tabs: [Text('简介'),Text('专栏')],
            indicatorColor: Colors.blueAccent, //指示器颜色 如果和标题栏颜色一样会白色
        //    isScrollable: true, //是否可以滑动
            labelColor: Colors.blueAccent ,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            unselectedLabelStyle: TextStyle(fontSize: 16),
            labelStyle: TextStyle(fontSize: 16),
            indicatorPadding: EdgeInsets.only(top: 5),
          ),
    );
  }
}

