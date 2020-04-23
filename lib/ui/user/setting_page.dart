import 'dart:io';

import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/bean/upload_image_entity.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/user/bean/about_entity.dart';
import 'package:yqy_flutter/utils/user_utils.dart';

///
///  系统设置页面
///
class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}





class _SettingPageState extends State<SettingPage> {


  String _appVersion = "";  // 当前本地的版本

  AboutInfo _aboutInfo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // loadData();
    initData();

  }



  loadData () async{


    NetworkUtils.requestAbout(UserUtils.getUserInfo().userId)
        .then((res) {

      int statusCode = int.parse(res.status);

      if(statusCode==9999){

        _aboutInfo = AboutInfo.fromJson(res.info);
          setState(() {

          });

      }

    });

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,
        title: Text("系统设置"),

      ),
      body:Column(

        children: <Widget>[

        /*  buildMobileView(context),
          Divider(height: 1,),
          buildUpdateInfoView(context),
          Divider(height: 1,),
          buildServicePhoneView(context),
          Divider(height: 1,),
          buildAboutView(context),*/

          //buildVersion(context),
          //Divider(height: 1,),
          buildUpdateAvatar(context),
          Divider(height: 1,),
          buildUserAgreement("用户协议和隐私政策",context),
          Divider(height: 1,),
          buildServicePhoneView("0531-62308369",context),
          Divider(height: 1,),
          buildVersion("当前版本"),
          Divider(height: 1,),


          buildExitUser(context)

        ],

      ),


    );

  }


  ///
  ///  当前版本
  ///  
  Widget buildVersion(String v) {

    return new  InkWell(
      onTap: (){

      },
      child: Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Text(v,style: TextStyle(color: Colors.black87,fontSize: 16),),
            new Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                  child: Text(_appVersion),
                )

            ),


          ],
        ),

      ),
    );

  }
  Widget buildUserAgreement(String v,BuildContext context) {

    return new  InkWell(
      onTap: (){

        NetUtils.requestAgreements()
            .then((res){

              if(res.code==200){
                RRouter.push(context, Routes.webPage,{"url":res.info["content"],"title":v});
              }

        });
      },
      child: Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Text(v,style: TextStyle(color: Colors.black87,fontSize: 16),),
            new Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                )

            ),

            Icon(Icons.keyboard_arrow_right,size: 30,color: Colors.black26,),

          ],
        ),

      ),
    );


  }

  launchURLToPhone(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget buildMobileView(BuildContext context) {

    return InkWell(
      onTap: (){

      },
      child:  Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[


            Text("手机号码",style: TextStyle(color: Colors.black87,fontSize: 16),),

            new Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 5),
                  alignment: Alignment.centerRight,
                  child: Text(_aboutInfo==null?"":_aboutInfo.userPhone??"",style: TextStyle(color: Colors.black38,fontSize: 15),)
                )

            ),

        //    Icon(Icons.keyboard_arrow_right,size: 30,color: Colors.black26,),



          ],
        ),

      ),
    );


  }
  Widget buildServicePhoneView(String phone,BuildContext context) {

    return  InkWell(
      onTap: (){
        launchURLToPhone(phone);
      },
      child: Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Text("客服电话",style: TextStyle(color: Colors.black87,fontSize: 16),),
            new Expanded(
                child: Container(
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: Text(phone,style: TextStyle(color: Colors.blueAccent,fontSize: 15),)
                )

            ),

            Icon(Icons.keyboard_arrow_right,size: 30,color: Colors.black26,),

          ],
        ),

      ),
    );


  }

 Widget  buildAboutView(BuildContext context) {

   return  InkWell(
     onTap: (){
       RRouter.push(context, Routes.aboutPage,{});
     },
     child: Container(
       height: 60,
       color: Colors.white,
       padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
       child: Row(

         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[


           Text("关于我们",style: TextStyle(color: Colors.black87,fontSize: 16),),

           new Expanded(
               child: Container(
                   padding: EdgeInsets.only(right: 10),
                   alignment: Alignment.centerRight,
               )

           ),

           Icon(Icons.keyboard_arrow_right,size: 30,color: Colors.black26,),

         ],
       ),

     ),
   );
  }

  Widget  buildExitUser(BuildContext context) {

    return Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 55,
            margin: EdgeInsets.only(bottom: 60),
            color: Colors.white,
            child: FlatButton(
                onPressed: (){
                  RRouter.push(context, Routes.loginPage,{},clearStack: true);
                  UserUtils.removeToken();
                  UserUtils.removeUserInfo();
                },
                child: Container(
                  height: 55,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text("退出登录"),

                )),

          ),

        )

    );

  }

  buildUpdateInfoView(BuildContext context) {

    return  InkWell(
      onTap: (){
        RRouter.push(context, Routes.personalPage,{});
      },
      child: Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Text("个人资料",style: TextStyle(color: Colors.black87,fontSize: 16),),
            new Expanded(
                child: Container(
                    padding: EdgeInsets.only(right: 10),
                    alignment: Alignment.centerRight,
                    child: Text(_aboutInfo==null?"":_aboutInfo.serviceTel3,style: TextStyle(color: Colors.blueAccent,fontSize: 15),)
                )

            ),

            Icon(Icons.navigate_next,size: 30,color: Colors.black26,),

          ],
        ),

      ),
    );

  }

  Future<void> initData() async {

    //获取当前版本
    PackageInfo packageInfo = await PackageInfo.fromPlatform();


    setState(() {

      _appVersion =   packageInfo.version;

    });




  }


  File _imageFile;
  Future getImage() async {

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _imageFile = image;

    NetUtils.requestUploadsImages(_imageFile,"certification")
        .then((res){

            if(res.code==200){
              UploadImageInfo  _uploadImageInfo = UploadImageInfo.fromJson(res.info);
              updateAvatarUrl(_uploadImageInfo.src);
            }

    });


  }
  buildUpdateAvatar(BuildContext context) {
    return new  InkWell(
      onTap: (){
        getImage();
      },
      child: Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Text("修改头像",style: TextStyle(color: Colors.black87,fontSize: 16),),
            new Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 10),
                  alignment: Alignment.centerRight,
                )
            ),

            Icon(Icons.keyboard_arrow_right,size: 30,color: Colors.black26,),

          ],
        ),

      ),
    );

  }

  void updateAvatarUrl(String url) {

    NetUtils.requestUsersUpdateAvatar(url)
        .then((res){


          if(res.code==200){

             FLToast.showSuccess(text: "修改成功");

          }


    });


  }

}
