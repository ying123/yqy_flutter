import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
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


  AboutInfo _aboutInfo;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

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


          buildMobileView(context),
          Divider(height: 1,),
          buildServicePhoneView(context),
          Divider(height: 1,),
          buildAboutView(context),
          buildExitUser(context)

        ],

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
  Widget buildServicePhoneView(BuildContext context) {

    return  InkWell(
      onTap: (){
        launchURLToPhone(_aboutInfo.serviceTel3);
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
                    child: Text(_aboutInfo==null?"":_aboutInfo.serviceTel3,style: TextStyle(color: Colors.blueAccent,fontSize: 15),)
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
                  UserUtils.removeUserInfo();
                  RRouter.push(context, Routes.loginPage,{},clearStack: true);

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

}
