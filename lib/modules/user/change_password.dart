// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/common/toast.dart';

import '../../API/api_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePasswordScreen extends StatefulWidget {
  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thay đổi mật khẩu'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Tự động co lại khi bàn phím hiện lên
          children: <Widget>[
            TextFormField(
              controller: newPasswordController,
              decoration: const InputDecoration(labelText: 'Mật khẩu mới'),
            ),
            TextFormField(
              controller: confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Nhập lại mật khẩu mới'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Đóng dialog khi nhấn nút "Hủy"
          },
          child: Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (newPasswordController.text == "" || confirmPasswordController.text == "") {
              showToast(
                context: context,
                msg: "Cần nhập đầy đủ thông tin",
                color: Color.fromARGB(255, 253, 158, 75),
                icon: const Icon(Icons.warning),
              );
            } else if (newPasswordController.text != confirmPasswordController.text) {
              showToast(
                context: context,
                msg: "Nhập lại mật khẩu không khớp",
                color: Color.fromARGB(255, 253, 158, 75),
                icon: const Icon(Icons.warning),
              );
            } else {
              int? userID = await getUserId();
              await httpPost("/api/nguoi-dung/change-pass/$userID", {"password": newPasswordController.text});
                Navigator.pop(context);
              showToast(
                context: context,
                msg: "Thay đổi mật khẩu thành công",
                color: Color.fromARGB(255, 59, 255, 111),
                icon: const Icon(Icons.done),
              );
            
            }
          },
          child: Text('Lưu'),
        ),
      ],
    );
  }
}

// Hàm để hiển thị hộp thoại chỉnh sửa thông tin cá nhân
void showPasswordEditDialog(BuildContext context, VoidCallback reloadPage) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ChangePasswordScreen(); // Truyền callback vào dialog
    },
  );
}
