import 'package:flutter/material.dart';


class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
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

            SizedBox(height: 5,),

            buildVersion(context),


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

          ClipRRect(
            
            borderRadius: BorderRadius.all(Radius.circular(30)),
            child: Image.network("",width: 40,height: 40,fit: BoxFit.fill,),
          ),
          
          Text("药企源",style: TextStyle(color: Colors.black45,fontSize: 14),)


        ],

      ) ,

    );


  }

 Widget buildVersion(BuildContext context) {

    return Container(
      color: Colors.white,
      height: 90,
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Text("版本号",style: TextStyle(color: Colors.black87,fontSize: 16),),
              Text("1.1.2",style: TextStyle(color: Colors.black87,fontSize: 16),),

            ],

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Text("官方网站",style: TextStyle(color: Colors.black87,fontSize: 16),),
              Text("1.1.2",style: TextStyle(color: Colors.black87,fontSize: 16),),

            ],

          )



        ],

      ),


    );

  }
}
