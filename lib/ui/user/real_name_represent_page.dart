import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:yqy_flutter/bean/upload_image_entity.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/user/bean/user_info_entity.dart';
import 'package:yqy_flutter/utils/city_picker.dart';
import 'package:yqy_flutter/utils/department_picker.dart';
import 'package:yqy_flutter/utils/eventbus.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/utils/user_utils.dart';


class RealNameRepresentPage extends StatefulWidget {
  @override
  _RealNameRepresentPageState createState() => _RealNameRepresentPageState();
}

class _RealNameRepresentPageState extends State<RealNameRepresentPage> {

  ///
  ///   需要上传的字段
  //------------------------------------
  String realName;// 	真实姓名

  String IdCard;// 身份证号码

  String address = "选择所在地区";// 地区


  String _provinceId,_cityId,_areaId; //省市区 ID
  String _province,_city,_area; // 省市区 字符串

  String hos_name;// 医院名称

  String hos_id;// 医院id

  TextEditingController _nameC = new TextEditingController();
  TextEditingController _idCardC = new TextEditingController();
  TextEditingController _hosNameC = new TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // 判断当前用户是否 之前上传过数据  如果审核过 显示之前填写的数据
    // 成功 和 需要补充资料
    initCurrentPageData();

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
                // 地区选择
                buildAddressView(context),
                buildLine(),
              /*  // 医院名称
                buildHosNameInputView(context),
                buildLine(),*/
                //提交按钮
                Visibility(visible: UserUtils.getUserInfoX().userInfoStatus!=1,child: Column(

                  children: <Widget>[
                    cYM(ScreenUtil().setHeight(100)),
                    buildBtnRegisterView(context),
                    cYM(ScreenUtil().setHeight(60)),
                    buildBottomTipView(),
                    cYM(ScreenUtil().setHeight(60)),
                  ],
                ))

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
        uploadInfoData(context);
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
          controller: _idCardC,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          inputFormatters: <TextInputFormatter>[
            WhitelistingTextInputFormatter.digitsOnly,//只输入数字
            LengthLimitingTextInputFormatter(18)//限制长度
          ],
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
        InkWell(
          onTap: (){
            setState(() {
              _idCardC.text = "";

            });
          },
          child:  Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
            width:   ScreenUtil().setWidth(36),
            height:   ScreenUtil().setWidth(36),
            child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(30),height: ScreenUtil().setWidth(30),fit: BoxFit.fill,),
          ),
        )

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
        Expanded(
            child: TextFormField(
              controller: _nameC,
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
        InkWell(
          onTap: (){
            setState(() {
              _nameC.text = "";

            });
          },
          child:  Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
            width:   ScreenUtil().setWidth(36),
            height:   ScreenUtil().setWidth(36),
            child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(30),height: ScreenUtil().setWidth(30),fit: BoxFit.fill,),
          ),
        )

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
          controller: _hosNameC,
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
        InkWell(
          onTap: (){
            setState(() {
              _hosNameC.text = "";

            });
          },
          child:  Container(
            margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
            width:   ScreenUtil().setWidth(36),
            height:   ScreenUtil().setWidth(36),
            child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(30),height: ScreenUtil().setWidth(30),fit: BoxFit.fill,),
          ),
        )

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

    if(_nameC.text.isEmpty){
      showToast("请先输入姓名");
      return;
    }
    map["realName"] = _nameC.text;


    if(_idCardC.text.isEmpty){
      showToast("请先输入身份证号");
      return;
    }
    map["idCard"] = _idCardC.text;


    // 医院
   /* if(_hosNameC.text.isEmpty){
      showToast("请先输入医院名称");
      return;
    }
    map["hospital_name"] = _hosNameC.text;
    map["h_id"] = 0;*/

    // 地区
    if(address.isEmpty||address=="选择地区"){
      showToast("请先选择地区");
      return;
    }
    map["provinceId"] = _provinceId;
    map["cityId"] = _cityId;
    map["areaId"] = _areaId;



    // 认证的状态
    map["userInfoStatus"] = UserUtils.getUserInfoX().userInfoStatus;

    NetUtils.requestCertificationStaff(map)
        .then((res){

      if(res.code==200){
        FLToast.showSuccess(text:res.msg);
        eventBus.fire(EventBusChange(""));
        // 延时1s执行返回
        Future.delayed(Duration(seconds: 1), (){
          Navigator.of(context).pop();
        });
      }else{
        FLToast.error(text:res.msg);
      }

    });

  }
  ///
  ///  认证状态 0未认证 1成功 2待审核 3认证失败 4需要补充资料
  ///
  void initCurrentPageData() {

    UserInfoInfo info =  UserUtils.getUserInfoX();

    if(info.userInfoStatus!=0){


      setState(() {

        _nameC.text = info.realName ;

        _idCardC.text = info.idCard;


        StringBuffer stringBuffer = new StringBuffer();

        stringBuffer..write(info.proName.toString())
                    ..write("-")
                    ..write(info.cityName.toString())
                    ..write("-")
                    ..write(info.areaName.toString());

        address = stringBuffer.toString();



        _provinceId = info.provinceId.toString();
        _cityId = info.cityId.toString();
        _areaId = info.areaId.toString();

        _hosNameC.text = info.hospitalName.toString();


      });



    }

  }
}



