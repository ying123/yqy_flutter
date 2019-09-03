import 'package:flutter_banner_swiper/flutter_banner_swiper.dart';
import 'package:flutter/material.dart';
import  'package:yqy_flutter/utils/margin.dart';


  class TaskHome extends StatefulWidget {
    @override
    _TaskHomeState createState() => _TaskHomeState();
  }

  class _TaskHomeState extends State<TaskHome> {


    // 声明一个list，存放image Widget
    List<String> imageList = List();

    @override
    void initState() {
      // TODO: implement initState
      imageList.add(
          "http://minimg.hexun.com/i4.hexunimg.cn/mobile_show/image/20190701/20190701121331_376_621x310.jpg");
      imageList.add(
          "http://minimg.hexun.com/i7.hexun.com/2015-11-16/180596378_c324x234.jpg");
      imageList.add(
          "http://minimg.hexun.com/i7.hexun.com/2014-09-02/168105362_c324x234.jpg");
      super.initState();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

        body: new Column(
          children: <Widget>[


            new Container(

              child: new Text(
                  "赚取积分", style: TextStyle(color: Colors.black, fontSize: 22)),
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 50),

            ),

            cYM(15),

            ///轮播图
            getList(),

            Container(
              
              child: Text("今日任务"),
              
            )
            
        
            
            
          ],

        ),


      );
    }

    Widget getList() {
      return BannerSwiper(
        //width  和 height 是图片的高宽比  不用传具体的高宽   必传
        height: 108,
        width: 54,
        //轮播图数目 必传
        length: imageList.length,
        //轮播的item  widget 必传
        getwidget: (index) {
          return new GestureDetector(
              child: Image.network(
                imageList[index % imageList.length],
                fit: BoxFit.fill,
              ),
              onTap: () {
                //点击后todo
              });
        },
      );
    }



  }