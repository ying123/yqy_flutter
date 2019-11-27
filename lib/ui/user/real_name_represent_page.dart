import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/bean/personal_entity.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/utils/city_picker.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:yqy_flutter/utils/user_utils.dart';


class RealNameRepresentPage extends StatefulWidget {
  @override
  _RealNameRepresentPageState createState() => _RealNameRepresentPageState();
}

class _RealNameRepresentPageState extends State<RealNameRepresentPage> {

  TextEditingController _nameController,_cardController,_hosController,_jobController;

  String _userName,_userCard,_address = "选择地区";

  String _hName,_jobNumber;

  String _province,_city,_area;

  String _provinceId,_cityId,_areaId; //省市区 ID

  String _department = "选择科室",_job = "选择职称";

  String _tId,_tIds,_jId; // 科室 和 职称 ID

  var jids = [99,100,101,102];

  var tids = [1304,1156,1170,1185,1211,1216,1288,1237,1265,1273,1299,1284,1231,1287,1281,1225,1240];

  GlobalKey _formKey= new GlobalKey<FormState>();
  GlobalKey _addressKey= new GlobalKey<FormState>();

  GlobalKey  _scaffoldKey= new GlobalKey<FormState>();

  PersonalInfo _personalInfo;

  bool isVisible = true;// 是否显示提交审核按钮  当审核成功的时候  为false

  // 创建 focusNode
  FocusNode focusNode = new FocusNode();//获取焦点  是否获取焦点  之前填写过 为 false


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();

    //initTextControllerListener();

  }

  void loadData() {

    NetworkUtils.requestUserIndex(UserUtils.getUserInfo().userId)
        .then((res) {

      int statusCode = int.parse(res.status);

      if(statusCode==9999){

        _personalInfo = PersonalInfo.fromJson(res.info);


        initPageData(_personalInfo);

      }
      setState(() {


      });
    });



  }


  @override
  Widget build(BuildContext context) {
    return  new Scaffold(
      key: _scaffoldKey,
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
                          focusNode: focusNode,
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: "姓名",
                            hintText: "输入您的姓名",
                          ),
                          // 校验用户名
                          onSaved: (v){
                            _userName = v;
                            },
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
                          onSaved: (v){
                            _userCard = v;
                          },
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
                                      child:  InkWell(
                                        child: Text(_address,style: TextStyle(fontSize: 16),key: _addressKey,),
                                        onTap: (){
                                          CityPicker.showCityPicker(
                                            context,
                                            selectProvince: (province) {
                                              _province = province["name"];
                                              _provinceId = province["code"];
                                            },
                                            selectCity: (city) {
                                              _city = city["name"];
                                              _cityId = city["code"];
                                            },
                                            selectArea: (area) {
                                              _area = area["name"];
                                              _areaId = area["code"];
                                              setState(() {
                                                _address = _province+_city+_area;
                                              });

                                            },
                                          );
                                        },
                                      )
                                  )
                              ),
                              IconButton(
                                onPressed: (){
                                  CityPicker.showCityPicker(
                                    context,
                                    selectProvince: (province) {
                                      _province = province["name"];
                                      _provinceId = province["code"];
                                    },
                                    selectCity: (city) {
                                      _city = city["name"];
                                      _cityId = city["code"];
                                    },
                                    selectArea: (area) {
                                      _area = area["name"];
                                      _areaId = area["code"];
                                      setState(() {
                                        _address = _province+_city+_area;
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
                      Divider(height: 1,color: Colors.black,),
                      cYM(10),
                      TextFormField(
                          controller: _hosController,
                          decoration: InputDecoration(
                            labelText: "企业名称",
                            hintText: "请填写您的企业名称",
                          ),
                          // 校验用户名
                          onSaved: (v){
                            _hName = v;
                          },
                          validator: (v) {
                            return v
                                .trim()
                                .length > 0 ? null : "企业名称不能为空";
                          }
                      ),
                      cYM(10),
                      TextFormField(
                          controller: _jobController,
                          decoration: InputDecoration(
                            labelText: "企业代码",
                            hintText: "请输入统一社会信用代码",
                          ),
                          // 校验用户名
                          onSaved: (v){
                            _jobNumber = v;
                          },
                          validator: (v) {
                            return v
                                .trim()
                                .length > 0 ? null : "企业代码不能为空";
                          }

                      ),
                      cYM(60),

                      Visibility(
                          visible: isVisible,
                          child: FlatButton(
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

                                (_formKey.currentState as FormState).save();

                                uploadData();


                                //验证通过提交数据
                              }


                            },
                          ))


                    ],
                  )
              )


          )


      ),
    );
  }


  void uploadData() {


    if(_areaId==null){
      showToast("地区不能为空！");
      return;
    }

    Map<String, dynamic> map  =  new Map();

    map["realName"] = _userName;//姓名
    map["idCard"] = _userCard;//身份证号

    map["provinceId"] = _provinceId;//省
    map["cityId"] = _cityId;//市
    map["areaId"] = _areaId;//区


    map["company_name"] = _hName;// 公司名称
    map["company_code"] = _jobNumber;//公司信用号码

   // map["t_id"] = _tId;//科室一级ID
    //  map["t_ids"] = _tIds;//科室二级ID
  //  map["j_id"] = _jId;//职称ID

  //  map["h_id"] = "0";//医院id
    map["userId"] = UserUtils.getUserInfo().userId;

    NetworkUtils.requestEditInfo(map)
        .then((res){

      showToast(res.message);
      print(res.toString());
      int statusCode= int.parse(res.status.toString());

      if(statusCode==9999){

        // 延时1s执行返回
        Future.delayed(Duration(seconds: 1), (){
          Navigator.of(context).pop();
        });

      }
    });

  }


  ///
  ///  初始化页面数据
  ///
  void initPageData(PersonalInfo personalInfo) {


    String status =   personalInfo.userInfoStatus;


    _nameController = new TextEditingController();
    _cardController = new TextEditingController();
    _hosController = new TextEditingController();
    _jobController = new TextEditingController();


    //认证成功 隐藏提交按钮
    if(status=="1"){
      isVisible = false;
    }

    //是否自动获取焦点
    if(status!="1"&&status!="2"&&status!="3"){

      FocusScope.of(context).requestFocus(focusNode);

    }




    _nameController.text = personalInfo.realName;

    _cardController.text = personalInfo.idCard;

    _address = personalInfo.provinceidName+personalInfo.cityidName+personalInfo.areaidName;

    _hosController.text = personalInfo.companyName;

   // _department = personalInfo.tName;

   // _job = personalInfo.jName;

   _jobController.text = personalInfo.companyCode;


    _provinceId = personalInfo.provinceId;
    _cityId = personalInfo.cityId;
    _areaId = personalInfo.areaId;


   // _tId = personalInfo.tId;
   // _jId = personalInfo.jId;

    setState(() {
    });

  }

}



