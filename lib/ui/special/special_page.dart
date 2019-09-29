import 'package:flutter/material.dart';
import  'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/common/constant.dart' as AppColors;
import 'package:yqy_flutter/widgets/load_state_layout_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';

class SpecialPage extends StatefulWidget {
  @override
  _SpecialPageState createState() => _SpecialPageState();
}

class _SpecialPageState extends State<SpecialPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


        appBar: AppBar(

          backgroundColor: Colors.white,

          centerTitle: true,

          title: Text("专题视频",style: TextStyle(color: Colors.black),),

          leading: Container(),

        ),



      body: SmartRefresher(
          controller: null



      ),



    );
  }
}

