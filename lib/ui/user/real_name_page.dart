import 'package:flutter/material.dart';
import 'package:yqy_flutter/utils/city_picker.dart';
import 'package:yqy_flutter/utils/margin.dart';


class RealNamePage extends StatefulWidget {
  @override
  _RealNamePageState createState() => _RealNamePageState();
}

class _RealNamePageState extends State<RealNamePage> {
  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      appBar: AppBar(
        title: Text("实名认证"),
        centerTitle: true,
      ),
      body: Builder(
          builder: (context) => Padding(
              padding: EdgeInsets.all(20),

              child:  ListView(

                children: <Widget>[

                  getItemTextInput("姓名","输入您的姓名",0),

                  getItemTextInput("身份证","输入您的身份证号",1),

                  cYM(10),
                  new  InkWell(
                    child: Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Center(
                                child:  Text("选择地区",style: TextStyle(fontSize: 16),),
                              )
                          ),
                          IconButton(
                            onPressed: (){
                              CityPicker.showCityPicker(
                                context,
                                selectProvince: (province) {
                                  print(province);
                                },
                                selectCity: (city) {
                                  print(city);
                                },
                                selectArea: (area) {
                                  print(area);
                                },
                              );
                            },
                            icon: Icon(Icons.add,color: Colors.blueAccent,),

                          )
                        ],

                      ),

                    ),
                  ),

                  Divider(height: 2,color: Colors.black,),
                  cYM(10),
                  getItemTextInput("医院","输入您所在医院名称",2),
                  cYM(10),
                  new  InkWell(
                    child: Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Center(
                                child:  Text("选择科室",style: TextStyle(fontSize: 16),),
                              )
                          ),
                          IconButton(
                            onPressed: (){
                              CityPicker.showCityPicker(
                                context,
                                selectProvince: (province) {
                                  print(province);
                                },
                                selectCity: (city) {
                                  print(city);
                                },
                                selectArea: (area) {
                                  print(area);
                                },
                              );
                            },
                            icon: Icon(Icons.add,color: Colors.blueAccent,),

                          )
                        ],

                      ),

                    ),
                  ),
                  Divider(height: 2,color: Colors.black,),
                  cYM(10),
                  new  InkWell(
                    child: Container(
                      height: 50,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Center(
                                child:  Text("选择职称",style: TextStyle(fontSize: 16),),
                              )
                          ),
                          IconButton(
                            onPressed: (){
                              CityPicker.showCityPicker(
                                context,
                                selectProvince: (province) {
                                  print(province);
                                },
                                selectCity: (city) {
                                  print(city);
                                },
                                selectArea: (area) {
                                  print(area);
                                },
                              );
                            },
                            icon: Icon(Icons.add,color: Colors.blueAccent,),

                          )
                        ],

                      ),

                    ),
                  ),
                  Divider(height: 2,color: Colors.black,),
                  getItemTextInput("职业号","输入您的职业号",3),
                  cYM(60),

                  FlatButton(
                    color: Colors.blue,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      child: Text("提交审核",style: TextStyle(color: Colors.white,fontSize: 16),),

                    ),
                    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {},
                  )



                ],
              )


          )


      ),
    );
  }
}




getItemTextInput(String t,  String hint,  int type) {

    return  TextField(

 //     autofocus: true,
      decoration: InputDecoration(

        labelText: t,
        hintText: hint

      ),

    );

  }
