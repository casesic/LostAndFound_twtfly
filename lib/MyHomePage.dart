import 'package:flutter/material.dart';
import 'package:lost_and_found/Cache.dart';
import 'package:lost_and_found/MyInformation.dart';
import 'package:lost_and_found/RouterManager.dart';

import 'LostandFoundMenu.dart';
import 'MapPage.dart';
import 'Config.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final List<Widget> _tabs = <Widget>[
    LostandFoundMenu(), //主页，就是带搜索和发帖功能的那个
    MapPage(mode: '0'), //不知道有什么用的地图
    MyInformationPage(), //我的个人主页
    Container(
      alignment: Alignment.center,
      child: Text('尚在天国的个人主页'),
    )
  ];

  ///底部导航栏
  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.cloud),
      label: '主页',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.map),
      label: '地图',
    ),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
  ];
  var currentPage;
  var currentIndex = 0;
  @override
  void initState() {
    super.initState();
    getToken();
    currentPage = _tabs[currentIndex];
  }

  void getToken()async{
    Store store = await Store.getInstance();
    var token=await store.getString('token');

    if(token==null||token.length!=32||token=='none'){
      RouterManager.router.navigateTo(context, 'login');
    }else{
      Config.token=token;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          items: _bottomTabs,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              currentPage = _tabs[currentIndex];
            });
          },
          fixedColor: Colors.green,
        ),
        body: currentPage);
  }
}
