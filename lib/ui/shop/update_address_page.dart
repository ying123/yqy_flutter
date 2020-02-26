import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:oktoast/oktoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/net/network_utils.dart';
import 'package:yqy_flutter/ui/shop/bean/shop_home_entity.dart';
import 'package:yqy_flutter/utils/city_picker.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:html_unescape/html_unescape.dart';


class UpdateAddressPage extends StatefulWidget {

 final String id;

  UpdateAddressPage(this.id);

  @override
  _UpdateAddressPageState createState() => _UpdateAddressPageState();
}

class _UpdateAddressPageState extends State<UpdateAddressPage> {

  ///
  ///   需要上传的字段
  //------------------------------------
  String _name;// 	收件人姓名

  String _tel;// 联系方式

  String _address = "所在地区";// 地区

  String _provinceId,_cityId,_areaId; //省市区 ID
  String _province,_city,_area; // 省市区 字符串

  String _detailedAddress;// 详细地址

  //-----------------------------------

  TextEditingController _nameController = new TextEditingController();
  TextEditingController _telController = new TextEditingController();
  TextEditingController _detailedAddressController = new TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();

  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("编辑地址"),
      ),
      body: Column(

        children: <Widget>[

          Container(
            padding: EdgeInsets.all(setW(58)),
            color: Colors.white,
            child: Column(

              children: <Widget>[


                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[

                    buildText("收货地址",size: 46,fontWeight: FontWeight.w600),
                    cYM(setH(99)),
                    // 姓名输入
                    buildNameInputView(context),
                    buildLine(),
                    // 联系方式
                    buildIDCardInputView(context),
                    buildLine(),
                    // 所在地区
                    buildAddressView(context),
                    buildLine(),
                    // 详细地址
                    buildHosNameInputView(context),
                    buildLine(),

                  ],
                ),

                cYM(setH(58)),
                // 保存按钮
                buildSubmitBtnView(context)

              ],

            ),

          )


        ],
      ),
      
      
    );
  }

  buildInputName(BuildContext context) {

    return Container(

    );

  }

  buildSubmitBtnView(BuildContext context) {
    return FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
              // 上传地址数据
            uploadAddressData(context);
        },
        child: Container(
          width: setW(585),
          height: setH(98),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF68E0CF), Color(0xFF209CFF)]),
              borderRadius: BorderRadius.all(Radius.circular(setW(43)))
          ),
          child: buildText("保存并使用", size: 37, color: "#FFFEFFFF"),


        ));


  }
  buildLine() {

    return Container(
      width: ScreenUtil().setWidth(962),
      color: Color(0xFF2CAAEE),
      height: ScreenUtil().setWidth(1),
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
          controller: _nameController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "请输入收货人姓名",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
          onChanged: (v){
            _name = v;
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
          controller: _telController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "请输入手机号码",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          onChanged: (v){
            _tel = v;
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
                    _address  = _province+" - "+_city+" - "+_area;
                  });

                },
              );
            },
            child: Container(
              alignment: Alignment.centerLeft,
              height: ScreenUtil().setHeight(120),
              child: Text(_address,style: TextStyle(color: Color(_address=="选择所在地区"?0xFF999999:0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),),
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
          controller: _detailedAddressController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "填写详细地址",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
          onChanged: (v){
            _detailedAddress = v;
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

  void uploadAddressData(BuildContext context) {


    if(_name.isEmpty){

      showToast("请填写收货人姓名");

      return;

    }
    if(_tel.isEmpty){

      showToast("请填写联系人方式");

      return;

    }

    if(_address=="所在地区"){

      showToast("请选择收货地区");

      return;

    }
    if(_detailedAddress=="填写详细地址"){

      showToast("请填写详细地址");

      return;

    }

    Map<String,dynamic>  map = new Map();

    map["id"] = widget.id;
    map["name"] = _name;
    map["tel"] = _tel;
    map["address"] = _detailedAddress;
    map["pro_id"] = _provinceId;
    map["city_id"] = _cityId;
    map["area_id"] = _areaId;


    NetUtils.requestEditAddress(map)
      .then((res){


        showToast(res.msg);

        if(res.code==200){

            Navigator.pop(context);

        }



    });





  }

  void initData() {

    NetUtils.requestGetAddress(widget.id)
        .then((res){


          if(res.code==200){


             _name = res.info["name"];// 	收件人姓名

             _tel = res.info["tel"];// 	收件人姓名

             _detailedAddress = res.info["address"];// 	详细地址

             _provinceId = res.info["pro_id"].toString();// 	省ID
             _cityId = res.info["city_id"].toString();// 	市ID
             _areaId = res.info["area_id"].toString();// 	区ID

             _province = res.info["pro"];// 	省
             _city = res.info["city"];// 	市
             _area = res.info["area"];// 	区


            setState(() {

              _nameController.text = _name;
              _telController.text = _tel;
              _detailedAddressController.text = _detailedAddress;

              _address = _province+" - "+_city+" - "+_area;

            });


          }



    });

  }

}
