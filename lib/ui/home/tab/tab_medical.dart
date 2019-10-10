import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/ui/video/video_details.dart';
import 'package:yqy_flutter/ui/web/webview_page.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
///
///   医学园页面
///

 class TabMedicalPage extends StatefulWidget {
   @override
   _MedicalPageState createState() => _MedicalPageState();
 }

 class _MedicalPageState extends State<TabMedicalPage> with AutomaticKeepAliveClientMixin{
   // TODO: implement wantKeepAlive

   //页面加载状态，默认为加载中
   LoadState _layoutState = LoadState.State_Loading;

   RefreshController _refreshController;



   @override
  void initState() {
    // TODO: implement initState
     super.initState();
     _refreshController =   RefreshController(initialRefresh: false);

     loadData();



  }
  void loadData() async{





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

      body: new Column(

        children: <Widget>[

          cYM(15),
          getTopLabelView(),

        new   Expanded(
              child:
              Container(
                child: new SmartRefresher(
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    enablePullDown: false,
                    enablePullUp: true,
                    child: ListView(
                      children: <Widget>[
                        getListViewItem(context,1),
                        getListViewItem(context,1),
                      ],

                    )
                ),

              ))

        ],

      ),

     );
   }


   ///
   ///   顶部分类导航栏
   ///
   Widget getTopLabelView(){

     return new Row(

       mainAxisAlignment: MainAxisAlignment.spaceAround,
       children: <Widget>[



         new GestureDetector(

           child:  new   Container(

             decoration: new BoxDecoration(
               //   border: new Border(BorderSide(color: Colors.black12,width: 1) ),
                 border: new Border.all(color: Colors.black12,width: 1),
                 color: Colors.white
             ),
             width: 115,
             height: 85,

             child: Column(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[

                 Icon(Icons.android,size: 30,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     Text("按疾病分类",style: TextStyle(color: Color(0xFFFF9802),fontSize: 14),),
                     cXM(2),
                     Icon(Icons.arrow_forward_ios,color: Color(0xFFFF9802),size: 12,)
                   ],

                 )
               ],
             ),
           )  ,
           onTap: (){

             showToast("点击按照疾病分类");

           },


         ),

         new GestureDetector(

           child:  new   Container(

             decoration: new BoxDecoration(
               //   border: new Border(BorderSide(color: Colors.black12,width: 1) ),
                 border: new Border.all(color: Colors.black12,width: 1),
                 color: Colors.white

             ),
             width: 115,
             height: 85,


             child: Column(

               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[

                 Icon(Icons.android,size: 30,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[

                     Text("按科室分类",style: TextStyle(color:Colors.blue,fontSize: 14),),
                     cXM(2),
                     Icon(Icons.arrow_forward_ios,color:Colors.blue,size: 12,)

                   ],

                 )


               ],

             ),


           )  ,
           onTap: (){

             showToast("点击按科室分类");

           },


         ),

         new GestureDetector(

           child:  new   Container(

             decoration: new BoxDecoration(
               //   border: new Border(BorderSide(color: Colors.black12,width: 1) ),
                 border: new Border.all(color: Colors.black12,width: 1),
                 color: Colors.white

             ),
             width: 115,
             height: 85,


             child: Column(

               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[

                 Icon(Icons.android,size: 30,),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[

                     Text("按研究分类",style: TextStyle(color: Color(0xFFFF4D4D),fontSize: 14),),
                     cXM(2),
                     Icon(Icons.arrow_forward_ios,color: Color(0xFFFF4D4D),size: 12,)

                   ],

                 )


               ],

             ),


           )  ,
           onTap: (){

             showToast("点击研究分类");

           },


         ),






       ],

     );


   }

  Widget getListViewItem(BuildContext buildContext,int pos) {

     return  new GestureDetector(
       child: new Container(
         height: 100,
         child: Row(
           children: <Widget>[

             Icon(Icons.apps,size: 110,color: Colors.black45,),
             Expanded(
                 child: Container(
                   padding: EdgeInsets.only(right: 15),
                   decoration: new BoxDecoration(
                       border: Border(bottom: BorderSide(color: Colors.black12,width: 1))

                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                       cYM(5),
                       Text("比套题标题比套题比套题标题比套题比套题标题比套题",style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 15),maxLines: 2,overflow: TextOverflow.ellipsis,),
                       new  Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Row(
                             children: <Widget>[
                               Icon(Icons.android,size: 14,color: Colors.black45,),
                               cXM(3),
                               Text("作者名称",style: TextStyle(color: Colors.black45,fontSize: 14),),
                             ],

                           ),
                           Container(
                             alignment: Alignment.centerRight,
                             child: Text("阅读量：0",style:  TextStyle(color: Colors.black45,fontSize: 12),),


                           )

                         ],

                       ),
                     ],

                   ),

                 )
             )


           ],



         ),


       ),
       onTap:(){
         RRouter.push(buildContext,Routes.webPage ,{'title': '嘻嘻嘻','url':'https://www.baidu.com'});
       },

     );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;








 }




