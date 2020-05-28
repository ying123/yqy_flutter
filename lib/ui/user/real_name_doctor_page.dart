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


class RealNameDoctorPage extends StatefulWidget {
  @override
  _RealNameDoctorPageState createState() => _RealNameDoctorPageState();
}

class _RealNameDoctorPageState extends State<RealNameDoctorPage> {

  ///   需要上传的字段
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

  ///-----------------------------------

  var jids = [99,100,101,102];

  TextEditingController _nameC = new TextEditingController();
  TextEditingController _idCardC = new TextEditingController();
  TextEditingController _hosNameC = new TextEditingController();
  TextEditingController _jobCodeC = new TextEditingController();


  
  UploadImageInfo _uploadImageInfo;

  File _imageFile;


  String _urlImage1,_urlImage2;

 String  _urlImage1Upload; // 只用于上传图片使用  没有添加域名 相对路径
  String  _urlImage2Upload; // 只用于上传图片使用  没有添加域名 相对路径

  Future getImage(int type) async {

    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _imageFile = image;


    NetUtils.requestUploadsImages(_imageFile,"certification")
        .then((res){
      setState(() {

        if(res.code==200){
          _uploadImageInfo = UploadImageInfo.fromJson(res.info);

          if(type==1){
            setState(() {
              _urlImage1 = _uploadImageInfo.cdn+_uploadImageInfo.src;
              _urlImage1Upload = _uploadImageInfo.src;
            });



          }else{
            _urlImage2 = _uploadImageInfo.cdn+_uploadImageInfo.src;
            _urlImage2Upload = _uploadImageInfo.src;
          }



        }

      });
    });
  }


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
                Visibility(visible:  UserUtils.getUserInfoX().userInfoStatus==1&&(_urlImage1==""||_urlImage1==null)?false:true,child: Column(
                  children: <Widget>[
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

                  ],
                )),
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
          controller: _jobCodeC,
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
        InkWell(
          onTap: (){
            setState(() {
              _jobCodeC.text = "";

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


  buildImageView() {
    return Row(
    mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

       new InkWell(

         onTap: (){
           getImage(1);
           },
         child: new  DottedBorder(
           padding: EdgeInsets.all(1),
           color: Color(0xFF2CAAEE),
           radius: Radius.circular(ScreenUtil().setWidth(14)),
           dashPattern: [9, 5],
           child: Container(
             width: ScreenUtil().setWidth(461),
             height: ScreenUtil().setHeight(328),
             child: _urlImage1==null?  Column(
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
             ):wrapImageUrl(_urlImage1, setW(450), setH(320)),

           ),

         )

       ),
      cXM(setW(30)),
      new  InkWell(

        onTap: (){

          getImage(2);
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
            child: _urlImage2==null? Column(
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
            ):wrapImageUrl(_urlImage2, setW(450), setH(320)),

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
    if(_hosNameC.text.isEmpty){
      showToast("请先输入医院名称");
      return;
    }
    map["hospital_name"] = _hosNameC.text;
    map["h_id"] = 0;

    // 地区
    if(address.isEmpty||address=="选择地区"){
      showToast("请先选择地区");
      return;
    }
    map["provinceId"] = _provinceId;
    map["cityId"] = _cityId;
    map["areaId"] = _areaId;

    // 职称
    if(job.isEmpty||job=="选择职称"){
      showToast("请先选择职称");
      return;
    }
    map["job_id"] = job_id;


    // 科室
    if(_department2Id.isEmpty||_department=="选择科室"){
      showToast("选择科室");
      return;
    }
    map["t_id"] = _department1Id;
    map["t_ids"] = _department2Id;


    // 职业编号
    if(_jobCodeC.text.isEmpty){
      showToast("请先填写职业证书号");
      return;
    }
    map["job_code"] = _jobCodeC.text;


    // 当前表示 之前提交过资料 但是需要补充图片资料
    if(true){

        if(_urlImage1==null&&_urlImage1Upload==null){

          FLToast.error(text:"请上传执业证书正面");
          return;

        }
      if(_urlImage2==null&&_urlImage2Upload==null){
        FLToast.error(text: "请上传执业证书背面");
        return;
      }
      map["job_img1"] = _urlImage1Upload??_urlImage1.substring(_urlImage1.lastIndexOf("/uploads"));
      map["job_img2"] = _urlImage2Upload??_urlImage2.substring(_urlImage1.lastIndexOf("/uploads"));
    }


    // 认证的状态
    map["userInfoStatus"] = UserUtils.getUserInfoX().userInfoStatus;

    NetUtils.requestCertificationDoctor(map)
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



 /* void initJobNameData() {

    NetUtils.requestJobList()
        .then((res){

          if(res.code==200){

          }

    });

  }*/


  ///
  ///  认证状态 0未认证 1成功 2待审核 3认证失败 4需要补充资料
  ///
  void initCurrentPageData() {

    UserInfoInfo info =  UserUtils.getUserInfoX();

    if(info.userInfoStatus!=0){


        setState(() {

          _nameC.text = info.realName ;

          _idCardC.text = info.idCard;



          if(info.pro!=null){

            StringBuffer stringBuffer = new StringBuffer();

            stringBuffer..write(info.pro.areaName)
              ..write("-")
              ..write(info.city.areaName)
              ..write("-")
              ..write(info.area.areaName);

            address = stringBuffer.toString();

          }


          _provinceId = info.provinceId.toString();
          _cityId = info.cityId.toString();
          _areaId = info.areaId.toString();

          _hosNameC.text = info.hospitalName.toString();

          _department = info.departName.toString()+"-"+info.departsName.toString();

          _department1Id = info.tId.toString();

          _department2Id = info.tIds.toString();

          job = info.jobName.toString();

          job_id = info.jId.toString();

          _jobCodeC.text = info.jobCode;

          _urlImage1 = info.jobImg1;

          _urlImage2 = info.jobImg2;




        });



    }

  }
}
