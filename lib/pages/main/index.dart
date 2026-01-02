import 'package:e_commerce/api/user.dart';
import 'package:e_commerce/pages/cart/index.dart';
import 'package:e_commerce/pages/category/index.dart';
import 'package:e_commerce/pages/home/index.dart';
import 'package:e_commerce/pages/me/index.dart';
import 'package:e_commerce/stores/token_manager.dart';
import 'package:e_commerce/stores/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Map<String, String>> _tabList = [
    {
      "icon": "assets/icons/icon-home-normal.png",
      "active-icon": "assets/icons/icon-home-active.png",
      "text": "首页",
    },
    {
      "icon": "assets/icons/icon-category-normal.png",
      "active-icon": "assets/icons/icon-category-active.png",
      "text": "分类",
    },
    {
      "icon": "assets/icons/icon-cart-normal.png",
      "active-icon": "assets/icons/icon-cart-active.png",
      "text": "购物车",
    },
    {
      "icon": "assets/icons/icon-my-normal.png",
      "active-icon": "assets/icons/icon-my-active.png",
      "text": "我的",
    },
  ];

  int _currentIndex = 0;
  final UserController _userController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    await tokenManager.init();
    if (tokenManager.getToken().isNotEmpty) {
      // 获取用户信息
      _userController.updateUserInfo(await getUserProfileAPI());
    }
  }

  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (int index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active-icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }

  List<Widget> _getChildren() {
    return [HomeView(), CategoryView(), CartView(), MeView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex, 
        children: _getChildren()
        ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: _getTabBarWidget(),
        currentIndex: _currentIndex,
      ),
    );
  }
}
