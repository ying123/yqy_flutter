import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:yqy_flutter/ui/drugs/drugs_company_detail_page.dart';
import 'package:yqy_flutter/utils/margin.dart';


void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      HomePage()
    // 一行代码 搞定 全灰色主题
    //  ColorFiltered(colorFilter:  ColorFilter.mode(Colors.white, BlendMode.color),child: MainHomePage(),)

  );

}


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      home: DepartmentHomePage(),

    );
  }
}



///
///
class DepartmentHomePage extends StatefulWidget {
  @override
  _DepartmentHomePageState createState() => _DepartmentHomePageState();
}

class _DepartmentHomePageState extends State<DepartmentHomePage> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 1080, height: 1920);
    return Scaffold(

      body:  Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (context, bool) {
            return [
              SliverAppBar(
                title: Text("科室专题"),
                backgroundColor: Color(0xFF1DD5E6),
                centerTitle: true,
                leading: InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back_ios,color: Colors.white,),
                ),
                expandedHeight:setH(650),
                floating: true,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  //   title: Text("山东汉方制药有限公司"),
                    centerTitle: true,
                    background: Container(
                        height: ScreenUtil().setHeight(550),
                        child:  buildTopContainer(context)
                    )

                ),
                actions: <Widget>[

                ],
              ),
              SliverStickyHeader(
                header:  buildScreenView(context),
                sliver:
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, i) =>
                        getLiveItemView(context,""),
                    childCount: 10,
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[

            ],
          ),
        ),
      ),

    );
  }

  Container buildTopContainer(BuildContext context) {
    return Container(
      child: new Stack(
        children: <Widget>[
          Image.network("222",width: double.infinity,height: double.infinity,fit: BoxFit.fill,),
          Container(width: double.infinity,height: double.infinity,decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF1DD5E6),Color(0xFF46AEF7)])
          ),),
          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: ScreenUtil().setHeight(240),
                ),
                Image.network("",width: 80,height: 80,fit: BoxFit.fill,),
                cYM( ScreenUtil().setHeight(20)),
                Text("1111",style: TextStyle(color: Colors.white,fontSize: 18),),
                cYM( ScreenUtil().setHeight(20)),
                Text("222",style: TextStyle(color: Colors.white,fontSize: 14),),
                cYM( ScreenUtil().setHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("333 |",style: TextStyle(color: Colors.white,fontSize: 14),),
                    Text("444",style: TextStyle(color: Colors.white,fontSize: 14),),

                  ],

                )
              ],


            ),


          )
        ],
      ),
    );
  }

  ///
  ///  悬停布局
  ///
  buildScreenView(BuildContext context) {


    return ListView.builder(itemBuilder: (context,pis){

      return Container(
        margin: EdgeInsets.only(right: setW(58)),
         width: setW(206),
        height: setH(72),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.all(Radius.circular(setW(36))),
          color: Color(0xfff5f5f5)

        ),

      );


    });


  }


  ///
  ///  下方主要内容列表
  ///
  getLiveItemView(BuildContext context, String s) {





  }


}
