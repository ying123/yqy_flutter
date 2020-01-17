import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';


class AddAddressPage extends StatefulWidget {
  @override
  _AddAddressPageState createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("添加地址"),
      ),
      body: Column(

        children: <Widget>[

          Container(
            margin: EdgeInsets.all(setW(58)),
            color: Colors.white,
            child: Column(

              children: <Widget>[
              
                buildText("新增收获地址",size: 46,fontWeight: FontWeight.w500),
                cYM(setH(99)),
                //姓名
                buildInputName(context),
                //联系方式
                buildInputName(context),
                //所在地区
                buildInputName(context),
                //详细地址
                buildInputName(context),
                cYM(setH(58)),
                // 保存按钮
                buildSubmitBtnView(context)

              ],

            ),

          )


        ],
      ),
      
      
    );
  }

  buildInputName(BuildContext context) {

  }

  buildSubmitBtnView(BuildContext context) {

    return Container(

      width: setW(585),
      height: setH(98),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Color(0xFF68E0CF),Color(0xFF209CFF)]),
        borderRadius: BorderRadius.all(Radius.circular(setW(43)))
      ),
      child: buildText("保存并使用",size: 37,color: "#FFFEFFFF"),



    );


  }
}
