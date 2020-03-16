import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:yqy_flutter/net/net_utils.dart';
import 'package:yqy_flutter/route/r_router.dart';
import 'package:yqy_flutter/route/routes.dart';
import 'package:yqy_flutter/ui/login/bean/send_sms_entity.dart';
import 'package:yqy_flutter/utils/city_picker.dart';
import 'package:yqy_flutter/utils/department_picker.dart';
import 'package:yqy_flutter/utils/margin.dart';
import 'package:yqy_flutter/utils/user_utils.dart';

///
///   完善资料
///
class PerfectInfoPage extends StatefulWidget {


  String phone;// 手机号

  String code;

  PerfectInfoPage(this.phone, this.code); // 	短信验证码


  @override
  _PerfectInfoPageState createState() => _PerfectInfoPageState();
}

class _PerfectInfoPageState extends State<PerfectInfoPage> with SingleTickerProviderStateMixin {


  ///
  ///  需要上传的字段
  ///
  int seleType = 1; // 当前选择角色  1 医生   2推广经理

  String realName;// 	真实姓名

  String hospital_name; // 	医院名称（当医生用户的hospital_id为0时必传）

  String hospital_id; // 		医院编号

  GlobalKey _addressKey= new GlobalKey<FormState>();
  String _address = "选择地区",_department = "选择科室";


  String _provinceId,_cityId,_areaId; //省市区 ID
  String _province,_city,_area; // 省市区 字符串


  String _department1Id,_department2Id; //一二级科室 ID
  String _department1,_department2; // 一二级科室 字符串

  bool _check = true;


  TabController _tabController;


  TextEditingController _nameController = new TextEditingController();
  TextEditingController _hosController = new TextEditingController();

  var tabTitle = [
    '我是医生',
    '我是推广经理',
  ];
  

  String _agreementsContent; // 用户协议的内容

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabTitle.length);
    _tabController.addListener((){
      setState(() {
        _tabController.previousIndex==0?seleType=2:seleType=1;
      });

    });
    initTextControllerListener();

    // 获取 用户协议的内容
    initAgreementsData();
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 1080, height: 1920);
    return new  Scaffold(

      resizeToAvoidBottomPadding: false,//防止键盘谈起的时候导致背景视图升起*********
      body: Stack(

        children: <Widget>[

          // 背景图
          new Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(

                gradient: LinearGradient(colors: [Color(0xFF68E0CF),Color(0xFF209CFF)],begin: Alignment.topCenter,end: Alignment.bottomCenter)
            ),
          ),
          //logo
          new Positioned(
              top:ScreenUtil().setHeight(300),left: ScreenUtil().setWidth(438),
              child: Text("完善资料",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: ScreenUtil().setSp(52)),)
          ),
          // 选项卡
          new Positioned(
              child: Container(
                height: ScreenUtil().setHeight(80),
                margin: EdgeInsets.only(top: ScreenUtil().setHeight(450)),
                alignment: Alignment.center,
                child: TabBar(
                  controller: _tabController,
                  tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                  indicatorColor:Colors.white, //指示器颜色 如果和标题栏颜色一样会白色
                  isScrollable: true, //是否可以滑动
                  labelColor: Colors.white ,
                  unselectedLabelColor:  Colors.white,
                  indicatorSize: TabBarIndicatorSize.label,
                  unselectedLabelStyle: TextStyle(fontSize: ScreenUtil().setSp(40)),
                  labelStyle: TextStyle(fontSize: ScreenUtil().setSp(50),fontWeight: FontWeight.bold),
                  indicatorPadding: EdgeInsets.only(top: 5),
                ),
              )),

          // 选项内容
          new  Positioned(
              top: ScreenUtil().setHeight(550),
              left: ScreenUtil().setWidth(115),
              child:  Container(
                width: ScreenUtil().setWidth(861),
                height: ScreenUtil().setHeight(900),
                child:   buildContainerHosLogin(context),//医生登录

              )
          ),
          // logo
         new Positioned(
           bottom: ScreenUtil().setHeight(100),
             left: ScreenUtil().setWidth(440),
            child: Image.asset(wrapAssets("logo_login.png"),width:  ScreenUtil().setWidth(200),height: ScreenUtil().setHeight(230),fit: BoxFit.fill,),
         )


        ],
      ),
    );
  }


  buildContainerHosLogin(BuildContext context) {

    return new Container(
      padding: EdgeInsets.fromLTRB(ScreenUtil().setHeight(30), ScreenUtil().setHeight(50), ScreenUtil().setHeight(30),  ScreenUtil().setHeight(50)),
      width: ScreenUtil().setWidth(861),
      height: ScreenUtil().setHeight(1277),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(ScreenUtil().setWidth(72))),
          // 生成俩层阴影，一层绿，一层黄， 阴影位置由offset决定,阴影模糊层度由blurRadius大小决定（大就更透明更扩散），阴影模糊大小由spreadRadius决定
          boxShadow: [ BoxShadow(
              color: Colors.black12,
              offset: Offset(0.0, 15.0), //阴影xy轴偏移量
              blurRadius: 15.0, //阴影模糊程度
              spreadRadius: 1.0 //阴影扩散程度
          )],
          color: Colors.white
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          cYM(ScreenUtil().setHeight(30)),

          // 姓名输入
          buildNameInputView(context),
          buildLine(),

          // 地区选择
          buildAddressView(context),
          buildLine(),

          Visibility(visible: seleType==1?true:false,child:  // 医院名称输入
          buildHosInputView(context),),

          Visibility(visible: seleType==1?true:false,child:
          buildLine(),),

          Visibility(visible: seleType==1?true:false,child:  // 科室输入
          buildDepartmentInputView(context),),

          Visibility(visible: seleType==1?true:false,child:
          buildLine(),),

          cYM(ScreenUtil().setHeight(40)),
          // 用户协议的按钮
          buildCheckBoxAgreementView(context),
          cYM(ScreenUtil().setHeight(20)),
          //注册按钮
          buildBtnRegisterView(context),


        ],
      ),


    );
  }

  buildMobileInputView(BuildContext context) {

    return  new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("login/ic_user.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "请输入手机号号码",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
        )),
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(40),
          height:   ScreenUtil().setWidth(40),
          child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),

      ],

    );

  }

  buildLine() {

    return Container(
      width: ScreenUtil().setWidth(723),
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
        child: Text("完成",style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(37),fontWeight: FontWeight.w500),),
      ),
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
            hintText: "请输入姓名",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
        )),

        InkWell(
          onTap: (){
            setState(() {
              _nameController.text = "";

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



  buildHosInputView(BuildContext context) {
    return  new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("login/ic_hos.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        Expanded(child: TextFormField(
          controller: _hosController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "请输入医院名称",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
        )),
        InkWell(
          onTap: (){
            setState(() {
              _hosController.text = "";

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

  ///
  ///  密码输入框
  ///
  buildPwdContinueInputView(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets("login/ic_pwd.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          obscureText: true,
          decoration: InputDecoration(
            hintText: "请再次输入密码",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
        )),
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Icon(Icons.visibility_off,color: Color(0xFFAAAAAA),),
        )
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

              child: Text(_department,style: TextStyle(color:_address=="选择科室"?Color(0xFF999999):Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),),
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


  ///
  ///  用户协议相关
  ///
  buildCheckBoxAgreementView(BuildContext context) {

    return Row(
       mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Checkbox(value: _check, onChanged: (bool v){
          setState(() {
            this._check = !this._check;
          });
        },tristate: true,focusColor: Colors.red,activeColor:  Color(0xFF4AB1F2) ,),
        Text("我已阅读并同意",style: TextStyle(color:  Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),
        InkWell(

          onTap: (){
            //弹出用户协议弹窗
            showAgreementDialog(context);

           },
          child: Text("《用户服务协议》",style: TextStyle(color:  Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(32)),) ,

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
                  _address = _province+" - "+_city+" - "+_area;
                });

              },
            );
          },
          child: Container(
            alignment: Alignment.centerLeft,
              height: ScreenUtil().setHeight(120),
            child: Text(_address,style: TextStyle(color: _address=="选择地区"?Color(0xFF999999):Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),),
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

  void initTextControllerListener() {

    _nameController.addListener((){
      realName = _nameController.text;
    });
    _hosController.addListener((){
      hospital_name = _hosController.text;
    });


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
    map["regtype"] = seleType.toString();
    map["phone"] = widget.phone;
    map["code"] = widget.code;
    map["realName"] = realName;


    // 地区
    if(_address.isEmpty||_address=="选择地区"){
      showToast("请先选择地区");
      return;
    }
    map["provinceId"] = _provinceId;
    map["cityId"] = _cityId;
    map["areaId"] = _areaId;


    // 医院
    if(hospital_name.isEmpty){
      showToast("请先输入医院名称");
      return;
    }
    map["hospital_name"] = hospital_name;
    map["hospital_id"] = 0;




    // 科室
    if(_department.isEmpty||_department=="选择科室"){
      showToast("请先选择地区");
      return;
    }
    map["depart_id"] = _department1Id;
    map["depart_ids"] = _department2Id;

    if(!_check){

      FLToast.showError(text: "请先阅读并勾选用户服务协议");

      return;

    }

    NetUtils.requestFinishInfo(map)
        .then((res){

       if(res.code==200){
         SendSmsInfo _loginInfo = SendSmsInfo.fromJson(res.info);
         UserUtils.saveToken(_loginInfo.token.toString());
         RRouter.push(context, Routes.homePage, {},clearStack: true);
       }else{
         FLToast.showError(text: res.msg);
       }

    });

  }


  ///
  ///  用户协议弹窗
  ///
  void showAgreementDialog(BuildContext context) {

    showDialog(context: context,
        builder: (_)=> Material(
        color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(setW(55)))
            ),
            margin: EdgeInsets.fromLTRB(setW(80), setH(260), setW(80), setH(300)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                cYM(setH(40),),
                buildText("药企源用户协议",size: 52),
                cYM(setH(40),),
                Container(
                  height: setH(900),
                  child: ListView(

                    children: <Widget>[
                      Html(

                        padding: EdgeInsets.all(setW(26)),
                        data: _agreementsContent,

                      ),
                    ],
                  )
                ),
                cYM(setH(40),),
                FlatButton(onPressed: (){

                  Navigator.pop(_);

                }, child: Container(
                  width: setW(585),
                  height: setH(98),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(Radius.circular(setW(43))),
                    color: Colors.white,
                    border: Border.all(color: Color(0xFF999999),width: setW(1))

                  ),
                  child: buildText("阅读同意",size: 52,color: "#FF999999"),

                ))

              ],

            ),

          ),
        )
    );
  }

  void initAgreementsData() {

    NetUtils.requestAgreements()
        .then((res){

       if(res.code==200){

       _agreementsContent =   res.info["content"];

       }

    });
  }

}
