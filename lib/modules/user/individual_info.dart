// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/model/user.model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'change_info.dart';
import 'change_password.dart';

class IndividualInfo extends StatefulWidget {
  @override
  _IndividualInfoState createState() => _IndividualInfoState();
}

class _IndividualInfoState extends State<IndividualInfo> {
  bool isFormVisible = false;

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  void toggleFormVisibility() {
    setState(() {
      isFormVisible = !isFormVisible;
      //MyDialog1.totalPoints;
    });
  }

  void reloadPage() {
    setState(() {
      // Update any necessary data or state before reloading
      fetchDataFromApi(); // Gọi lại hàm để cập nhật dữ liệu từ API
    });
  }

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  UserModel userModel = UserModel();
  bool statusData = false;
  Future<void> fetchDataFromApi() async {
    setState(() {
      statusData = false;
    });
    try {
      int? userID = await getUserId();
      final response = await httpGet("/api/nguoi-dung/get/$userID");
      var bodyConvert = jsonDecode(response['body']);
      if (bodyConvert['success'] == true) {
        userModel = UserModel.fromMap(bodyConvert['result']);
      } else {
        userModel = UserModel();
      }
    } catch (e) {
      print('Error: $e');
    }
    setState(() {
      statusData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Ngăn tránh lỗi bottom overflowed khi hiển thị bàn phím
      body: SingleChildScrollView(
        // Sử dụng SingleChildScrollView để bọc nội dung
        child: Opacity(
          opacity: isFormVisible ? 0.2 : 1.0,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Text(
                      'Thông tin cá nhân',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: statusData
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Họ và tên:  ${userModel.fullName}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Username:  ${userModel.username}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Ngày sinh:  ${(userModel.ngaySinh != null && userModel.ngaySinh != "") ? DateFormat('dd-MM-yyyy').format(DateTime.parse(userModel.ngaySinh!)) : ""}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Giới tính:  ${userModel.gioiTinh == true ? 'Nữ' : 'Nam'}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Email:  ${userModel.email}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Số điện thoại:  ${userModel.sdt}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Địa chỉ:  ${userModel.address}',
                                  style: TextStyle(
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  ElevatedButton(
                                    onPressed: () {
                                      showProfileEditDialog(context:context, reloadPage:(value){
                                        setState(() {
                                          userModel = value;
                                        });
                                      }, userModel: userModel);
                                    },
                                    child: Text('Chỉnh sửa thông tin cá nhân', style: TextStyle(fontSize: 14)),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () {
                                      showPasswordEditDialog(context, reloadPage);
                                    },
                                    child: Text('Đổi mật khẩu', style: TextStyle(fontSize: 14)),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
