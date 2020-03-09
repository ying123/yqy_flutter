import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/bean/personal_entity.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/user_utils.dart';


class PersonalPage extends StatefulWidget {


  @override
  _PersonalPageState createState() => _PersonalPageState();

}

class _PersonalPageState extends State<PersonalPage> {


  String _avatarUrl;

  File _imageFile;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    _imageFile = image;
    NetUtils.requestUploadsImages(_imageFile,"")
          .then((res){
      setState(() {
          showToast(res.message);
          if(res.code==200){

            eventBus.fire(EventBusChange(_imageFile.path));
            // 延时1s执行返回
            Future.delayed(Duration(seconds: 1), (){
              Navigator.of(context).pop();
            });
          }

      });
    });


  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        centerTitle: true,
        title: Text("个人中心"),
      ),

      body: Column(

       children: <Widget>[

         buildAvatarView(context),
         Divider(height: 1,),
         buildContentView(context)

       ],

      ),

    );



  }

 Widget buildAvatarView(BuildContext context) {

    return InkWell(
      onTap: (){
          getImage();
      },
      child:  Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[


            Text("头像",style: TextStyle(color: Colors.black87,fontSize: 16),),

            new Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 15),
                  alignment: Alignment.centerRight,
                  child: ClipOval(
                      child: _imageFile==null?Image.network("",width: 40,height: 40,fit: BoxFit.fill,):
                      Image.file(_imageFile,width: 40,height: 40,fit: BoxFit.fill,)
                  ),
                )

            ),

            Icon(Icons.keyboard_arrow_right,size: 30,color: Colors.black26,),



          ],
        ),

      ),
    );

  }



  Widget buildContentView(BuildContext context) {

    return  InkWell(
      onTap: (){
        Navigator.pop(context);
        RRouter.push(context, Routes.updateExplainPage,{},transition:TransitionType.cupertino);
      },

      child: Container(
        height: 60,
        color: Colors.white,
        padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
        child: Row(

          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[


            Text("个人简介",style: TextStyle(color: Colors.black87,fontSize: 16),),

            new Expanded(
                child: Container(
                    padding: EdgeInsets.only(right: 15),
                    alignment: Alignment.centerRight,
                    child: Text("该用户尚未填写简介",style: TextStyle(color: Colors.black26),)
                )

            ),


          //  Icon(Icons.keyboard_arrow_right,size: 30,color: Colors.black26,),

          ],
        ),

      ),
    );


  }
}
