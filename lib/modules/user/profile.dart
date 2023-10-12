// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/model/user.model.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  UserModel userModel = UserModel();

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  bool statusData = false;

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

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
      backgroundColor: Colors.white,
      body: Align(
        alignment: Alignment.centerRight,
        child: statusData
            ? Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text('${userModel.fullName}'),
                    if ('${userModel.role}' == '2')
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Cán bộ lớp',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    if ('${userModel.role}' == '1')
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Cố vấn học tập',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.red,
                          ),
                        ),
                      ),

                    if ('${userModel.role}' == '3')
                      Container(
                        padding: EdgeInsets.only(top: 5),
                        child: Text(
                          'Sinh viên',
                          style: TextStyle(
                            fontSize: 13.0,
                            color: Colors.red,
                          ),
                        ),
                      ),

                    // Hiển thị thông tin khác của người dùng
                  ],
                ),
              )
            : CircularProgressIndicator(), // Hiển thị tiêu đề khi đang tải dữ liệu
      ),
    );
  }
}
