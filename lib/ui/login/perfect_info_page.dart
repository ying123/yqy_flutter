import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yqy_flutter/utils/city_picker.dart';
import 'package:yqy_flutter/utils/margin.dart';

///
///   完善资料
///
class PerfectInfoPage extends StatefulWidget {
  @override
  _PerfectInfoPageState createState() => _PerfectInfoPageState();
}

class _PerfectInfoPageState extends State<PerfectInfoPage> with SingleTickerProviderStateMixin {
  GlobalKey _addressKey= new GlobalKey<FormState>();
  String _userName,_userCard,_address = "选择地区";

  int seleType = 0; // 当前选择角色  0 医生   1推广经理

  String _provinceId,_cityId,_areaId; //省市区 ID
  String _province,_city,_area; // 省市区 字符串

  TabController _tabController;

  var tabTitle = [
    '我是医生',
    '我是推广经理',
  ];
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: tabTitle.length);
    _tabController.addListener((){

      setState(() {
        _tabController.previousIndex==0?seleType=1:seleType=0;
      });


    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 1080, height: 1920)..init(context);
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
             left: ScreenUtil().setWidth(450),
            child: Image.asset(wrapAssets("logo_login.png"),width:  ScreenUtil().setWidth(180),height: ScreenUtil().setHeight(230),fit: BoxFit.fill,),
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

          Visibility(visible: seleType==0?true:false,child:  // 医院名称输入
          buildHosInputView(context),),

          Visibility(visible: seleType==0?true:false,child:
          buildLine(),),


          Visibility(visible: seleType==0?true:false,child:  // 科室输入
          buildDepartmentInputView(context),),

          Visibility(visible: seleType==0?true:false,child:
          buildLine(),),


          cYM(ScreenUtil().setHeight(40)),
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

  buildPwdInputView(BuildContext context,int type) {

    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Image.asset(wrapAssets(type==1?"login/ic_pwd.png":"login/ic_sms.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          obscureText: true,
          decoration: InputDecoration(
            hintText: type==1?"请输入登陆密码":"请输入验证码",
            hintStyle: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),
            border: InputBorder.none, // 去除下划线
          ),
          cursorColor: Color(0xFF2CAAEE),  // 光标颜色
          style: TextStyle(color: Color(0xFF2CAAEE),fontSize: ScreenUtil().setSp(40)),
        )),
        type==1?Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Icon(Icons.visibility_off,color: Color(0xFFAAAAAA),),
        ):Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(0), 0),
          width:   ScreenUtil().setWidth(200),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
          child:  Text("获取验证码",style: TextStyle(color: Color(0xFF4AB1F2),fontSize: ScreenUtil().setSp(32)),),
        ),
      ],

    );
  }


  buildForgetPwdView(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
      padding: EdgeInsets.only(top: ScreenUtil().setHeight(32)),
      alignment: Alignment.centerRight,
      child: Text("忘记密码?",style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(32)),),


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
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(40),
          height:   ScreenUtil().setWidth(40),
          child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),

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
          keyboardType: TextInputType.phone,
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
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(40),
          height:   ScreenUtil().setWidth(40),
          child:  Image.asset(wrapAssets("login/ic_close.png"),width:  ScreenUtil().setWidth(43),height: ScreenUtil().setWidth(46),fit: BoxFit.fill,),
        ),

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


    return  new Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(ScreenUtil().setWidth(60), 0, ScreenUtil().setWidth(60), 0),
          width:   ScreenUtil().setWidth(50),
          height:   ScreenUtil().setWidth(50),
          alignment: Alignment.center,
        ),
        Expanded(child: TextFormField(
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          textAlign: TextAlign.start,
          maxLines: 1,
          decoration: InputDecoration(
            hintText: "请选择科室",
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
            child: Text(_address,style: TextStyle(color: Color(0xFF999999),fontSize: ScreenUtil().setSp(40)),),
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

}
