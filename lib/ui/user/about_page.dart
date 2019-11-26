import 'package:flutter/material.dart';
import 'package:yqy_flutter/common/constant.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/user/bean/about_entity.dart';
import 'package:yqy_flutter/utils/user_utils.dart';


class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {



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
        title: Text("关于我们"),

      ),

      body: Column(

          children: <Widget>[

            buildTopIconLogo(context),

            SizedBox(height: 10,),

            buildVersion(context),
            SizedBox(height: 10,),
            buildUserAgreement(context),
            Divider(height: 1,),
            buildPlatformQualification(context),
            buildCopyright(context),

          ],

      ),

    );
  }

 Widget buildTopIconLogo(BuildContext context) {

    return Container(
      color: Colors.white,
      height: 180,
      width: double.infinity,
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[

          Image.network(_aboutInfo==null?"":_aboutInfo.logo),
          
      //    Text("药企源",style: TextStyle(color: Colors.black45,fontSize: 14),)


        ],

      ) ,

    );


  }

 Widget buildVersion(BuildContext context) {

    return Container(
      color: Colors.white,
      height: 100,
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Text("版本号",style: TextStyle(color: Colors.black87,fontSize: 16),),
              Text(_aboutInfo==null?"":_aboutInfo.versionCode,style: TextStyle(color: Colors.black87,fontSize: 16),),

            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Text("官方网站",style: TextStyle(color: Colors.black87,fontSize: 16),),
              Text(_aboutInfo==null?"":_aboutInfo.webName,style: TextStyle(color: Colors.black87,fontSize: 16),),


            ],

          )



        ],

      ),


    );

  }

 Widget buildUserAgreement(BuildContext context) {

   return  InkWell(
     onTap: (){
       RRouter.push(context, Routes.webPage,{"url":APPConfig.Agreement,"title":"用户协议"});

     },
     child: Container(
       height: 60,
       color: Colors.white,
       padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
       child: Row(

         crossAxisAlignment: CrossAxisAlignment.center,
         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: <Widget>[

           Text("用户协议",style: TextStyle(color: Colors.black87,fontSize: 16),),
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
  Widget buildPlatformQualification(BuildContext context) {

    return  InkWell(
      onTap: (){
        RRouter.push(context, Routes.webPage,{"url":APPConfig.WebIntro,"title":"平台资质"});
      },
      child: Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[

            Text("平台资质",style: TextStyle(color: Colors.black87,fontSize: 16),),
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

 Widget buildCopyright(BuildContext context) {

    return  Expanded(
        child: Align(

          alignment: Alignment.bottomCenter,
          child: Container(

            height: 80,
            child: Column(

              children: <Widget>[

                Text("水燕版权所有"),
                SizedBox(height: 5,),
                Text(_aboutInfo==null?"":_aboutInfo.copyright,textAlign: TextAlign.center,)


              ],

            ),



          ),
        )
    );


  }
}
