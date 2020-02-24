import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/common/constant.dart';

Widget cYM(double y) {
  return SizedBox(
    height: y,
  );
}

Widget cXM(double x) {
  return SizedBox(
    width: x,
  );
}

Widget cYMW(double y) {
  return SizedBox(
    height: y,
    child: Container(
      color: Colors.white,
    ),
  );
}





 double setW(double w){
  return ScreenUtil.getInstance().setWidth(w);
 }


double setH(double h){
  return ScreenUtil.getInstance().setHeight(h);
}

double setSP(double sp){
  return ScreenUtil.getInstance().setSp(sp);
}


Text buildText(String v,{String color="#FF333333",double size=40,FontWeight fontWeight=FontWeight.w400}){

  return  Text(v,style: TextStyle(color: Color(int.parse(color.replaceAll("#", "0x"))),fontSize: ScreenUtil().setSp(size),fontWeight: fontWeight),);

}



///
///  统一标题栏抽取
///
AppBar getCommonAppBar(String v){

  return AppBar(

    title: Text(v),

  );

}

///  普通列表标题的样式
Widget getTitleText(String str){

  return Text(str,style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black,fontSize: 15),maxLines: 2,overflow: TextOverflow.ellipsis,);
}



///  普通列表内容的样式
Text getContentText(String str){

  return  Text(str,style: TextStyle(color: Colors.black45,fontSize: 14),);
}




///
///  网络图片添加
///
Widget wrapImageUrl(String url,double w,double h){

  return CachedNetworkImage(
    width: w,
    height: h,
    fit: BoxFit.fill,
    imageUrl: url,
  //  placeholder: (context, url) => Icon(Icons.picture_in_picture,size: 110,color: Colors.black45,),
    errorWidget: (context, url, error) => new Icon(Icons.error,size:w,color: Colors.black45,),
  );
}




///
///  本地图片添加
///
String wrapAssets(String url) {
return "assets/imgs/" + url;
}