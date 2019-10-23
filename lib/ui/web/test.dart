import 'package:flutter/material.dart';


/*void main() {

  runApp(AppPage());

}*/

class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home: Scaffold(

        body: ListView(
          children: <Widget>[
            TextField(
              autofocus: true,
              decoration: InputDecoration(
                  labelText: "姓名",
                  hintText: "输入您的姓名",
               //   prefixIcon: Icon(Icons.person)
                //  prefixText: "姓名"
              ),
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "身份证件号",
                  hintText: "输入您的身份证件号",
               //   prefixIcon: Icon(Icons.lock)
             //   prefixText: "身份证件号"
              ),
              obscureText: true,
            ),


          ],

        ),


      )

    );
  }

  getListItemView() {

    return Container(

      height: 90,
      color: Colors.black
    );

  }

  itemView() {




  }
}

