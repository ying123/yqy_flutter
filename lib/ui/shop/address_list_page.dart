import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_address_list_entity.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';


class AddressListPage extends StatefulWidget {
  @override
  _AddressListPageState createState() => _AddressListPageState();
}

class _AddressListPageState extends State<AddressListPage> {


  ShopAddressListInfo _addressListInfo;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initData();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("添加地址"),
      ),

      body: ListView(

        children: <Widget>[

        ],
      ),

    );
  }
  
  void initData() {

      NetUtils.requestAddressLists()
          .then((res){

            if(res.code==200){

             _addressListInfo =   ShopAddressListInfo.fromJson(res.info);

            }

      });

  }
}
