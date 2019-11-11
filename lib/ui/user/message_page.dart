import 'package:flutter/material.dart';
import 'package:yqy_flutter/net/network_utils.dart';


class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {


  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

   loadData() {

     NetworkUtils.requestMessageList(page.toString())
         .then((res){

       int statusCode = int.parse(res.status);

       if(statusCode==9999){




       }


     });

   }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("系统通知"),
        centerTitle: true,
      ),

      body: ListView.builder(
          itemBuilder: (content,index){

            return Container(



            );


          }


      ),



    );
  }


}
