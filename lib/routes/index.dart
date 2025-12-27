// 管理路由
import 'package:e_commerce/pages/login/index.dart';
import 'package:e_commerce/pages/main/index.dart';
import 'package:flutter/material.dart';

Widget getRootWidget(){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: "/",
    routes: getRootRoutes(),
  );
}

Map<String, Widget Function(BuildContext)> getRootRoutes(){
  return {
    "/": (context)=> MainPage(),
    "/login":(context)=> LoginPage()
  };
}