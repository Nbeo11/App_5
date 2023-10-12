// ignore_for_file: prefer_const_declarations, use_build_context_synchronously, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:project_dart/modules/login/login.screen.dart';
import '../sinhvien/page.one.sv.dart';
import '../user/profile.dart';
import 'package:project_dart/modules/loptruong/view_students.dart';
import '../user/individual_info.dart';
import '../../check_rated.dart';

class RatingPageMonitor extends StatefulWidget {
  const RatingPageMonitor({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _RatingPageMonitorState createState() => _RatingPageMonitorState();
}

class _RatingPageMonitorState extends State<RatingPageMonitor> {
  Check_RatingState checkRatingState = Check_RatingState();
  bool isLoggedOut = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
                  child: const Text(
                    'HỆ THỐNG ĐÁNH GIÁ ĐIỂM RÈN LUYỆN',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 13),
                  height: 60.0,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Expanded(
                        child: Profile(),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) async {
                          if (value == 'logout') {
                            setState(() {
                              isLoggedOut = true;
                            });

                            final snackBar = const SnackBar(
                              content: Text('Đã đăng xuất thành công'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);

                            // Đợi 3 giây trước khi chuyển trang
                            await Future.delayed(const Duration(seconds: 1));

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
                      Tab(text: 'Đánh giá điểm\n    rèn luyện'),
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
              PageOneSVScreen(),
              StudentListScreen(),
              IndividualInfo(),
            ],
          ),
        ),
      ),
    );
  }
}
