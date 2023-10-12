// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, library_private_types_in_public_api

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:project_dart/modules/login/login.screen.dart';
import 'package:project_dart/modules/loptruong/view_students.dart';
import '../user/profile.dart';
import '../user/individual_info.dart';
import 'view_students_gv.dart';

class RatingPageTeacher extends StatefulWidget {
  const RatingPageTeacher({Key? key}) : super(key: key);


  @override
  _RatingPageTeacherState createState() => _RatingPageTeacherState();
}

class _RatingPageTeacherState extends State<RatingPageTeacher> {
  bool isLoggedOut = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(160.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15),
                  height: 60.0,
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: Text(
                    'HỆ THỐNG ĐÁNH GIÁ ĐIỂM RÈN LUYỆN',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 13),
                  height: 60.0,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Profile(),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'logout') {
                            // Đánh dấu đã đăng xuất
                            setState(() {
                              isLoggedOut = true;
                            });
                            final snackBar = SnackBar(
                              content: Text('Đã đăng xuất thành công'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            // Đợi 3 giây trước khi chuyển trang
                            await Future.delayed(Duration(seconds: 1));

                            // Chuyển sang màn hình khác sau khi đăng xuất
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          } else if (value == 'profile') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Profile()),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          PopupMenuItem<String>(
                            value: 'logout',
                            child: Text('Đăng xuất'),
                          ),
                        ],
                        icon: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Icon(Icons.person),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 40.0,
                  color: Colors.green,
                  alignment: Alignment.center,
                  child: TabBar(
                    tabs: [
                      Tab(text: 'Xem điểm rèn\nluyện sinh viên'),
                      Tab(text: 'Hồ sơ cá nhân'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: isLoggedOut
              ? Center(
            child: Text(
              'Đã đăng xuất thành công',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
              : TabBarView(
            children: [
              StudentListScreenGV(),
              IndividualInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
