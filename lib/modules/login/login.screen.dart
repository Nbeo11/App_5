// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/common/loading.dart';
import 'package:project_dart/modules/sinhvien/rating_page_students.dart';
import 'package:project_dart/modules/loptruong/rating_page_monitor.dart';
import 'package:project_dart/modules/giaovien/rating_page_teacher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Map<String, dynamic> userData = {};
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  Future<void> saveUserIdLocally(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  Future<void> saveUserId(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }

  Future<void> authenticateUser(String username, String password) async {
    // final apiUrl = Uri.parse('${ApiConfig.ipAddress}/api/nguoi-dung/login');
    // print(apiUrl);

    try {
      Map<String, String> requesbody = {'username': username, 'password': password};
      var response = await httpPost("/api/nguoi-dung/login", requesbody);
      var bodyResponse = jsonDecode(response['body']);
      if (bodyResponse['success'] == true) {
        setState(() {
          saveUserId(bodyResponse['result']['id']);
          errorMessage = " ";
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login successful'),
            duration: Duration(seconds: 3), // Adjust the duration as needed
          ),
        );

        // Navigate to the respective page based on user role
        if (bodyResponse['result']['role'] == 3) {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RatingPage()),
          );
        }
        if (bodyResponse['result']['role'] == 2) {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RatingPageMonitor()),
          );
        }
        if (bodyResponse['result']['role'] == 1) {
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => RatingPageTeacher()),
          );
        }
      } else {
        Navigator.pop(context);
        setState(() {
          errorMessage = 'Tên đăng nhập hoặc mật khẩu không đúng.';
        });
      }
    } catch (error) {
      Navigator.pop(context);
      setState(() {
        errorMessage = 'Đã xảy ra lỗi: $error';
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Ảnh nền

            // Tiêu đề chính
            Padding(
              padding: const EdgeInsets.only(top: 45.0, bottom: 10),
              child: Image.asset(
                'assets/logo.jpg',
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: Text(
                'HỆ THỐNG ĐÁNH GIÁ\n ĐIỂM RÈN LUYỆN',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Form đăng nhập
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      labelText: 'Tên đăng nhập',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mật khẩu',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      onLoading(context);
                      final username = usernameController.text;
                      final password = passwordController.text;

                      if (username.isNotEmpty && password.isNotEmpty) {
                        await authenticateUser(username, password);
                      } else {
                        setState(() {
                          errorMessage = 'Vui lòng nhập tên đăng nhập và mật khẩu.';
                        });
                      }
                    },
                    child: Text('Đăng Nhập'),
                  ),
                  Text(
                    errorMessage,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),

            // Điều hướng đến trang quên mật khẩu
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 150.0), // Khoảng cách từ chân trang
                child: TextButton(
                  onPressed: () {
                    // Xử lý khi người dùng nhấn "Quên mật khẩu"
                  },
                  child: Text('Quên mật khẩu?'),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
