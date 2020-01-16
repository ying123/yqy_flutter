import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/margin.dart';
///
/// 实名认证弹窗
///
void requestIsRZ(BuildContext context) async {
  //网络请求
  ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
  // 发起弹窗
  showDialog(context: context,
      builder: (_)=>  Material(
        color: Colors.transparent,
        child: Container(
          margin: EdgeInsets.fromLTRB(setW(0), setH(350), setW(40),  setH(500)),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(child:   Image.asset(wrapAssets("bg_rz.png"),width: double.infinity,height: double.infinity,fit: BoxFit.fill,),),

           //   Image.asset(wrapAssets("bg_wallet.png"),width: setW(81),height: setW(81),fit: BoxFit.fill,),
              Positioned(top:0,right:setW(60),child: InkWell(child:  Image.asset(wrapAssets("close.png"),width: setW(81),height: setW(81),fit: BoxFit.fill,),onTap: (){
                    Navigator.pop(_);
              },),),

            new  Positioned(
                  bottom: setH(60),
                  left: setW(180),
                  child: Column(
                children: <Widget>[
                          buildText("您还没有实名认证",size: 52,color: "#FF333333"),
                          cYM( setH(59)),
                          buildText("请您通过实名认证，才有权限执行此操作",size: 40,color: "#FF999999"),
                          cYM( setH(59)),
                          Container(
                            width: setW(516),
                            height: setH(139),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(

                              gradient: LinearGradient(colors: [Color(0xFF68E0CF),Color(0xFF209CFF)]),
                              borderRadius: BorderRadius.all(Radius.circular(setW(58))),
                            ),
                            child: Text("立即认证",style: TextStyle(color: Colors.white),)
                          ),
                          cYM( setH(59)),

                ],

              ))


            ],
          ),

        ),
      )
  );




}