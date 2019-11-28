import 'package:flutter/material.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/common/constant.dart' as AppColors;
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';

import 'bean/special_list_entity.dart';

class SpecialPage extends StatefulWidget {

  String type;


  SpecialPage(this.type);

  @override
  _SpecialPageState createState() => _SpecialPageState();
}

class _SpecialPageState extends State<SpecialPage> {

  RefreshController _refreshController ;

  SpecialListEntity _specialListEntity;
  
  int page = 1;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController  = RefreshController(initialRefresh: false);
    loadData();
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  void loadData() async{

    NetworkUtils.requestSpecialList(page)
        .then((res){
          print("res:"+res.toString());

      if(res.status==9999){
        if(page>1){
          if(_specialListEntity.lists==null||_specialListEntity.lists.length==0){
            _refreshController.loadNoData();
          }else{
            _specialListEntity.lists.addAll(SpecialListEntity.fromJson(res.info).lists);
            _refreshController.loadComplete();
          }

        }else{
          _specialListEntity = SpecialListEntity.fromJson(res.info);
          _refreshController.refreshCompleted();
          _refreshController.resetNoData();
        }

      }
          setState(() {
          });
    });


  }


  void _onRefresh() async{
    // monitor network fetch
    //   await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    page = 1;
    loadData();
  }

  void _onLoading() async{
    page ++;
    loadData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(


        appBar: AppBar(
          brightness: Brightness.light,
          backgroundColor: widget.type==null?Colors.white:Colors.blue,
          centerTitle: true,

          title: Text("专题视频",style: TextStyle(color: widget.type==null?Colors.black:Colors.white),),

          leading: widget.type==null?Container():GestureDetector(
            child: Icon(Icons.arrow_back,color: widget.type==null?Colors.black:Colors.white,),
            onTap: (){
              Navigator.pop(context);
            },
          ),

        ),

      body: _specialListEntity == null ? Container() : SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(

          itemCount: _specialListEntity.lists.length ?? 0,
          itemBuilder: (content, index) {
            return getItemView(_specialListEntity.lists[index]);
          },

        ),
      ),


    );
  }




  Widget getItemView(SpecilaListList bean) {

    return GestureDetector(
      onTap: (){
        RRouter.push(context, Routes.specialDetailsPage,{"title":bean.title,"id":bean.id,});
      },

      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 6),
        child: Container(

          height: setH(450),
          child: Stack(

            alignment: Alignment.bottomCenter,

            children: <Widget>[
              Image.network(bean.image,width: double.infinity,height: 180,fit: BoxFit.fill,),
              Container(
                color: Colors.black38,
                width: double.infinity,
                alignment: Alignment.center,
                height: 40,
                child: Text(bean.title,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w600),),
              )



            ],
          ),
        ),
      ),


    );



  }


}

