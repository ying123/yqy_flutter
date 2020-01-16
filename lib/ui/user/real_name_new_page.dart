import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/utils/city_picker.dart';
import 'package:yqy_flutter/utils/department_picker.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class RealNameNewPage extends StatefulWidget {
  @override
  _RealNameNewPageState createState() => _RealNameNewPageState();
}

class _RealNameNewPageState extends State<RealNameNewPage> {

  ///
  ///   需要上传的字段
  //------------------------------------
  String realName;// 	真实姓名

  String IdCard;// 身份证号码

  String address = "选择所在地区";// 地区

  String _department = "选择科室";// 选择科室

  String _provinceId,_cityId,_areaId; //省市区 ID
  String _province,_city,_area; // 省市区 字符串

  String hos_name;// 医院名称

  String hos_id;// 医院id


  String _department1Id,_department2Id; //一二级科室 ID
  String _department1,_department2; // 一二级科室 字符串

  String job = "选择职称",job_id;// 职称id

  String job_number;// 证书号码


  //-----------------------------------

  var jids = [99,100,101,102];


  File _imageFile;

  Future getImage() async {

    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _imageFile = image;


  /*  NetworkUtils.requestEditUserPhoto(_imageFile)
        .then((res){
      setState(() {
        showToast(res.message);
        if(res.status=="9999"){
          eventBus.fire(EventBusChange(_imageFile.path));
          // 延时1s执行返回
          Future.delayed(Duration(seconds: 1), (){
            Navigator.of(context).pop();
          });
        }

      });
    });*/


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        title: Text("实名认证"),
      ),

      body: ListView(
        children: <Widget>[

        new Container(
          
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(58),  ScreenUtil().setHeight(60), 0, 0),
          child:  new Row(
            children: <Widget>[
              Image.asset(wrapAssets("user/ic_prove.png"),width:  ScreenUtil().setWidth(49),height: ScreenUtil().setWidth(49),fit: BoxFit.fill,),
              cXM(ScreenUtil().setWidth(16)),
              Text("认证信息",style: TextStyle(color: Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(46))),
            ],
          ),
        ),

        new  Container(
            padding: EdgeInsets.fromLTRB(ScreenUtil().setWidth(20), ScreenUtil().setHeight(40), ScreenUtil().setWidth(20), 0),
            child: Column(
              children: <Widget>[
                // 姓名输入
                buildNameInputView(context),
                buildLine(),
                // 身份证输入
                buildIDCardInputView(context),
                buildLine(),
                // 医院地区选择
                buildAddressView(context),
                buildLine(),
                // 医院名称
                buildHosNameInputView(context),
                buildLine(),
                // 科室选择
                buildDepartmentInputView(context),
                buildLine(),
                //职称选择
                buildJobNameInputView(context),
                buildLine(),
                // 职业证书号码
                buildJobNumberInputView(context),
                buildLine(),
                new Container(
                  margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(58),  ScreenUtil().setHeight(80), 0, 0),
                  child:  new Row(
                    children: <Widget>[
                      Image.asset(wrapAssets("user/ic_prove.png"),width:  ScreenUtil().setWidth(49),height: ScreenUtil().setWidth(49),fit: BoxFit.fill,),
                      cXM(ScreenUtil().setWidth(16)),
                      Text("认证资料",style: TextStyle(color: Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(46))),
                    ],
                  ),
                ),
                cYM(ScreenUtil().setHeight(43)),
                buildImageView(),
                //提交按钮
                cYM(ScreenUtil().setHeight(100)),
                buildBtnRegisterView(context),
                cYM(ScreenUtil().setHeight(60)),
                buildBottomTipView(),
                cYM(ScreenUtil().setHeight(60)),


              ],
            ),

          ),

        ],
      ),

    );
  }

  buildLine() {

    return Container(
      width: ScreenUtil().setWidth(962),
      color: Color(0xFF2CAAEE),
      height: ScreenUtil().setWidth(1),
    );

  }


  buildBtnRegisterView(BuildContext context) {

    return  InkWell(
      onTap: (){

      },
      child: Container(
        width: ScreenUtil().setWidth(585),
        height: ScreenUtil().setHeight(98),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF68E0CF),Color(0xFF209CFF)]),
            borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(43)))
        ),
        alignment: Alignment.center,
        child: Text("提交审核",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),),
      ),
    );

  }


  buildIDCardInputView(BuildContext context) {

    return  new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("user/ic_card.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "请输入身份证号码",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          onChanged: (v){
            IdCard = v;
          },
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
        )),
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(36),
          height:   ScreenUtil().setWidth(36),
          child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),

      ],

    );

  }


  buildNameInputView(BuildContext context) {
    return new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("login/ic_user.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "请输入姓名",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
          onChanged: (v){
            realName = v;
          },
        )),
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(36),
          height:   ScreenUtil().setWidth(36),
          child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(30),height: ScreenUtil().setWidth(30),fit: BoxFit.fill,),
        ),

      ],

    );

  }


   ///
  ///  科室选择
  ///
  buildDepartmentInputView(BuildContext context) {


    return new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
        ),
        Expanded(child: InkWell(
            onTap: (){
              DepartmentPicker.showDepartmentPicker(
                context,
                selectProvince: (province) {
                 _department1 = province["name"];
                 _department1Id = province["code"];
                },
                selectCity: (city) {

               _department2 = city["name"];
                _department2Id = city["code"];
                  setState(() {
                   _department = _department1+" - "+_department2;
                  });
                },

              );
            },
            child: Container(
              alignment: Alignment.centerLeft,
              height: ScreenUtil().setHeight(120),
              child: Text(_department,style: TextStyle(color: Color(_department=="选择科室"?0xFF999999:0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),),
            )
        )),
        Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
            width: ScreenUtil().setWidth(60),
            height:   ScreenUtil().setWidth(60),
            child:   Icon(Icons.keyboard_arrow_down,color: Colors.black26,size: ScreenUtil().setWidth(80),)
        ),

      ],

    );
  }

  buildCheckBoxAgreementView(BuildContext context) {

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Checkbox(value: true, onChanged: null,tristate: true,focusColor: Colors.red,),
        Text("我已阅读并同意",style: TextStyle(color:  Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
        Text("《用户服务协议》",style: TextStyle(color:  Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(32)),)


      ],


    );


  }

  buildHosNameInputView(BuildContext context) {

    return new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("user/ic_hos.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "请输入医院全称",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
          onChanged: (v){
            hos_name = v;
          },
        )),
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(36),
          height:   ScreenUtil().setWidth(36),
          child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(30),height: ScreenUtil().setWidth(30),fit: BoxFit.fill,),
        ),

      ],

    );
  }



  buildAddressView(BuildContext context) {

    return new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("user/ic_address.png"),width:  ScreenUtil().setWidth(40),height: ScreenUtil().setHeight(60),fit: BoxFit.fill,),
        ),
        Expanded(child: InkWell(
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
                  address  = _province+" - "+_city+" - "+_area;
                  });

                },
              );
            },
            child: Container(
              alignment: Alignment.centerLeft,
              height: ScreenUtil().setHeight(120),
              child: Text(address,style: TextStyle(color: Color(address=="选择所在地区"?0xFF999999:0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),),
            )
        )),
        Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
            width: ScreenUtil().setWidth(60),
            height:   ScreenUtil().setWidth(60),
            child:   Icon(Icons.keyboard_arrow_down,color: Colors.black26,size: ScreenUtil().setWidth(80),)
        ),

      ],

    );

  }


  buildJobNameInputView(BuildContext context) {
    return new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
        ),
        Expanded(child: InkWell(
            onTap: (){
              rootBundle.loadString('data/job.json').then((v) {
                List data = json.decode(v);

                Picker picker = new Picker(
                    cancelText: "取消",
                    confirmText: "确定",
                    adapter: PickerDataAdapter<String>(pickerdata:data,isArray: true),
                    changeToFirst: true,
                    textAlign: TextAlign.left,
                    columnPadding: const EdgeInsets.all(8.0),
                    onConfirm: (Picker picker, List value) {
                      setState(() {
                        job = picker.getSelectedValues()[0];
                        job_id =  jids[value[0]].toString();
                      });

                    }
                );
                picker.showModal(context);
              });
            },
            child: Container(
              alignment: Alignment.centerLeft,
              height: ScreenUtil().setHeight(120),
              child: Text(job,style: TextStyle(color: Color(job=="选择职称"?0xFF999999:0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),),
            )
        )),
        Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
            width: ScreenUtil().setWidth(60),
            height:   ScreenUtil().setWidth(60),
            child:   Icon(Icons.keyboard_arrow_down,color: Colors.black26,size: ScreenUtil().setWidth(80),)
        ),

      ],

    );
  }



  buildJobNumberInputView(BuildContext context) {
    return new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("user/ic_id.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "请输入医师执业证书号",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
        )),
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(36),
          height:   ScreenUtil().setWidth(36),
          child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(30),height: ScreenUtil().setWidth(30),fit: BoxFit.fill,),
        ),
      ],
    );
  }


  buildImageView() {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

       new InkWell(

         onTap: (){
           getImage();

           },
         child:  new  DottedBorder(
           padding: EdgeInsets.all(1),
           color: Color(0xFF2CAAEE),
           radius: Radius.circular(ScreenUtil().setWidth(14)),
           dashPattern: [9, 5],
           child: Container(
             width: ScreenUtil().setWidth(461),
             height: ScreenUtil().setHeight(328),
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: <Widget>[
                 Image.asset(wrapAssets("user/ic_add.png"),
                   width: ScreenUtil().setWidth(60),
                   height: ScreenUtil().setWidth(60),
                   fit: BoxFit.fill,),
                 cYM(ScreenUtil().setHeight(39)),
                 Text("请上传医师执业证 \r\n(头像页)", style: TextStyle(color: Color(0xFF999999),
                     fontSize: ScreenUtil().setSp(35)),)
               ],
             ),

           ),

         ),

       ),
      cXM(setW(30)),
      new  InkWell(

        onTap: (){

          getImage();
        },
        child: DottedBorder(
          padding: EdgeInsets.all(1),
          color: Color(0xFF2CAAEE),
          radius: Radius.circular(ScreenUtil().setWidth(14)),
          dashPattern: [9, 5],
          child: Container(
            width: ScreenUtil().setWidth(461),
            height: ScreenUtil().setHeight(328),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(wrapAssets("user/ic_add.png"),
                  width: ScreenUtil().setWidth(60),
                  height: ScreenUtil().setWidth(60),
                  fit: BoxFit.fill,),
                cYM(ScreenUtil().setHeight(39)),
                Text("请上传医师执业证 \r\n(资料页)", style: TextStyle(color: Color(0xFF999999),
                    fontSize: ScreenUtil().setSp(35)),)
              ],
            ),

          ),

        ),

      )

      ],


    );


  }

  buildBottomTipView() {
    
    return Container(
      
      child: Text("*请务必填写真实的个人信息，一经发现作假，将做封号处理！",style: TextStyle(color: Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(32)),),
      
    );
    
  }


  ///
  ///   上传资料
  ///
  void uploadInfoData(BuildContext context) {
    Map<String, dynamic> map = new Map();

    if(realName.isEmpty){
      showToast("请先输入姓名");
      return;
    }
    map["realName"] = realName;


    // 医院
    if(hos_name.isEmpty){
      showToast("请先输入医院名称");
      return;
    }
    map["hospital_name"] = hos_name;
    map["hospital_id"] = 0;

    // 地区
    if(address.isEmpty||address=="选择地区"){
      showToast("请先选择地区");
      return;
    }

    // 科室
    if(_department2Id.isEmpty||_department=="选择科室"){
      showToast("请先选择地区");
      return;
    }
    map["depart_id"] = _department1Id;
    map["depart_ids"] = _department2Id;


    NetUtils.requestFinishInfo(map)
        .then((res){

      if(res.code==200){
        print(res.toString());
      }else{
        showToast(res.msg);
      }

    });

  }
}
