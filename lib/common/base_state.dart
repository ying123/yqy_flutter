import 'package:flutter/material.dart';
class BaseWidget extends StatefulWidget {
  @override
  State<BaseWidget> createState() => BaseWidgetState();
}

class BaseWidgetState<T extends BaseWidget> extends State<T> {
  BuildContext context;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this.context=context;
    return Scaffold(
      appBar: appbar("测试",null),
      body: new Container(
        color: Color.fromRGBO(0, 0, 0, 0),
      ),
    );
  }



  Widget appbar(String title,List<Widget> actions){
    return AppBar(title: Text(title),
      centerTitle: true,
      leading: GestureDetector(
        child: Image.asset("images/back.png",fit: BoxFit.contain,),
        onTap: (){
          dispose();
        },
      ),
      actions: actions,
    );
  }

  void showToast(String msg){
  }


}