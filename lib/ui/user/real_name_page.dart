import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yqy_flutter/utils/city_picker.dart';
import 'package:yqy_flutter/utils/margin.dart';


class RealNamePage extends StatefulWidget {
  @override
  _RealNamePageState createState() => _RealNamePageState();
}

class _RealNamePageState extends State<RealNamePage> {


  TextEditingController _nameController,_cardController,_hosController,_jobController;

  String vName,vCard,vAddress = "选择地区";

  GlobalKey _formKey= new GlobalKey<FormState>();
  GlobalKey _addressKey= new GlobalKey<FormState>();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initTextControllerListener();

  }


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

              child: Form(
                  key: _formKey,
                //  autovalidate: true, //开启自动校验,
                  child:  new ListView(

                    children: <Widget>[

                      TextFormField(
                          autofocus: true,
                          controller: _nameController,
                          decoration: InputDecoration(
                              labelText: "姓名",
                              hintText: "输入您的姓名",
                          ),
                          // 校验用户名
                          validator: (v) {
                            return v
                                .trim()
                                .length > 0 ? null : "姓名不能为空";
                          }

                      ),
                      TextFormField(
                        keyboardType: TextInputType.number,
                          controller: _cardController,
                          maxLength: 18,
                          inputFormatters:[WhitelistingTextInputFormatter.digitsOnly],//只允许输入数字
                          decoration: InputDecoration(
                            labelText: "身份证",
                            hintText: "输入您的身份证号",
                          ),
                          // 校验用户名
                          validator: (v) {

                            if( v
                                .trim()
                                .length == 0){
                              return "身份证号不能为空";
                            }

                            if( v
                                .trim()
                                .length >0&& v
                                .trim()
                                .length<18){

                              return "身份证号位数不正确";
                            }

                            return null;
                          }

                      ),

                      cYM(10),
                      new  InkWell(
                        child: Container(
                          height: 50,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Center(
                                    child:  Text(vAddress,style: TextStyle(fontSize: 16),key: _addressKey,),
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

                                        setState(() {
                                          vAddress = area.toString();
                                        });

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
                      TextFormField(
                          autofocus: true,
                          controller: _hosController,
                          decoration: InputDecoration(
                            labelText: "医院",
                            hintText: "输入您所在医院名称",
                          ),
                          // 校验用户名
                          validator: (v) {
                            return v
                                .trim()
                                .length > 0 ? null : "医院不能为空";
                          }

                      ),
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
                      TextFormField(
                          autofocus: true,
                          controller: _jobController,
                          decoration: InputDecoration(
                            labelText: "职业号",
                            hintText: "输入您的职业号",
                          ),
                          // 校验用户名
                          validator: (v) {
                            return v
                                .trim()
                                .length > 0 ? null : "职业号不能为空";
                          }

                      ),
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
                        onPressed: () {
                          if((_formKey.currentState as FormState).validate()){


                            //验证通过提交数据
                          }


                        },
                      )


                    ],
                  )
              )


          )


      ),
    );
  }

  void initTextControllerListener() {


    _nameController = TextEditingController();
    _cardController = TextEditingController();
    _hosController = TextEditingController();
    _jobController = TextEditingController();

    _nameController.addListener((){

      vName  = _nameController.text;
      print(vName);


    });
    _cardController.addListener((){

      vCard  = _cardController.text;

    });





  }
}






