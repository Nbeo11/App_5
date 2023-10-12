import 'package:flutter/material.dart';
import 'package:project_dart/modules/sinhvien/page.one.sv.dart';
import '../login/login.screen.dart';
import '../user/profile.dart';
import '../user/individual_info.dart';
import '../../check_rated.dart';

class RatingPage extends StatefulWidget {
  const RatingPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  Check_RatingState checkRatingState = Check_RatingState();
  bool isLoggedOut = false;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(160.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(top: 15),
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
                  padding: EdgeInsets.only(top: 13),
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
                            const snackBar = SnackBar(
                              content: Text('Đã đăng xuất thành công'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            await Future.delayed(const Duration(seconds: 1));

                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          } else if (value == 'profile') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const Profile()),
                            );
                          }
                        },
                        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                          const PopupMenuItem<String>(
                            value: 'logout',
                            child: Text('Đăng xuất'),
                          ),
                        ],
                        icon: const Padding(
                          padding: EdgeInsets.only(bottom: 8.0),
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
                  child: const TabBar(
                    tabs: [
                      Tab(text: 'Đánh giá điểm\n    rèn luyện'),
                      Tab(text: 'Hồ sơ cá nhân'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: isLoggedOut
              ? const Center(
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
                    // FutureBuilder<void>(
                    //   future: checkRatingState.loadRates(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState == ConnectionState.done) {
                    //       if (checkRatingState.check == 0) {
                    //         return const RateForm();
                    //       } if (checkRatingState.check == 1) {
                    //         return RateFormFix();
                    //       } else {
                    //         return RateFormFix();
                    //       }
                    //     } else {
                    //       return const Center(child: CircularProgressIndicator());
                    //     }
                    //   },
                    // ),
                    PageOneSVScreen(),
                    IndividualInfo(),
                  ],
                ),
        ),
      ),
    );
  }
}
