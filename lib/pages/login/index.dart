import 'package:dio/dio.dart';
import 'package:e_commerce/utils/toast_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../api/user.dart';
import '../../stores/user_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserController _userController = Get.find();
  bool _termsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "登录页面",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
        ),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(30),
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: 20),
                _buildHeader(),
                SizedBox(height: 30),
                _buildAccountTextField(),
                SizedBox(height: 20),
                _buildPasswordTextField(),
                SizedBox(height: 20),
                _buildTermsAggreement(),
                SizedBox(height: 20),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildAccountTextField() {
    return TextFormField(
      controller: _accountController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '账号不能为空';
        }
        if (!RegExp(r"^1[3-9]\d{9}$").hasMatch(value)) {
          return '请输入有效的手机号';
        }
        return null;
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        labelText: '请输入账号',
        fillColor: const Color.fromARGB(255, 243, 243, 243),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '密码不能为空';
        }
        if (!RegExp(r"^[a-zA-Z0-9_]{6,16}$").hasMatch(value)) {
          return '请输入6-16位字母、数字或下划线组成的密码';
        }
        return null;
      },
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 10),
        labelText: '请输入密码',
        fillColor: const Color.fromARGB(255, 243, 243, 243),
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildTermsAggreement() {
    return Row(
      children: [
        Checkbox(
          value: _termsAccepted,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (value) {
            setState(() {
              _termsAccepted = value ?? false;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: Colors.grey, width: 2.0),
        ),
        Text.rich(
          TextSpan(
            text: '我已阅读并同意',
            style: TextStyle(fontSize: 14, color: Colors.grey),
            children: <TextSpan>[
              TextSpan(
                text: '《用户协议》',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
              TextSpan(
                text: '和',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              TextSpan(
                text: '《隐私政策》',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            if (_termsAccepted) {
              _login();
            } else {
              ToastUtils.showToast(context, "请先同意用户协议和隐私政策");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          "登录",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      // LoadingDialog.show(context, "登录中...");
      final res = await loginAPI({
        "account": _accountController.text,
        "password": _passwordController.text,
      });
      if(!mounted) return;
      _userController.updateUserInfo(res);
      // tokenManager.setToken(res.token);
      // LoadingDialog.hide(context);
      ToastUtils.showToast(context, "登录成功");
      Navigator.pop(context);
    } catch (e) {
      // LoadingDialog.hide(context);
      if(!mounted) return;
      ToastUtils.showToast(context, (e as DioException).message);
    }
  }
}
