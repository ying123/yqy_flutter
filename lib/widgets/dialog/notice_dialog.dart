import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';


///
///   0 为成功    1为提示
///

YYDialog YYNoticeDialog(String tip,int type) {
  return YYDialog().build()
    ..width = 120
    ..height = 110
    ..backgroundColor = Colors.black.withOpacity(0.8)
    ..borderRadius = 10.0
    ..widget(Padding(
      padding: EdgeInsets.only(top: 21),
      child: Image.asset(
        type==0?'imgs/success.png':'imgs/tip.png',
        width: 38,
        height: 38,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 10),
      child: Text(
        tip,
        style: TextStyle(
          fontSize: 15,
          color: Colors.white,
        ),
      ),
    ))
    ..show();
}