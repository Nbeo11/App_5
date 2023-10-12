// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/common/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/dang.gia.cbl.model.dart';
import '../../model/dang.gia.sv.model.dart';
import 'nd3.dart';
import 'nd1.dart';
import 'nd2.dart';
import 'nd4.dart';
import 'nd5.dart';

class PageOneSVScreen extends StatefulWidget {
  const PageOneSVScreen({super.key});

  @override
  State<PageOneSVScreen> createState() => _PageOneSVScreenState();
}

class _PageOneSVScreenState extends State<PageOneSVScreen> {
  DanhGiaSVModel danhGiaSVModel = DanhGiaSVModel(status: 0);
  DanhGiaCBLModel danhGiaCBLModel = DanhGiaCBLModel();
  bool editNoiDung = true;

  Future<int?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  bool statusData = false;
  callData() async {
    setState(() {
      statusData = false;
    });
    try {
      int idUer = await getUserId() ?? 0;
      print("id nguoi dung: $idUer");
      var responseDanhGiaSV = await httpGet("/api/danh-gia-sv/get/page?filter=idSv:$idUer");
      print(responseDanhGiaSV);
      if (responseDanhGiaSV.containsKey("body")) {
        setState(() {
          var resultLPV = jsonDecode(responseDanhGiaSV["body"]);
          var content = [];
          content = resultLPV['result']['content'];
          danhGiaSVModel = DanhGiaSVModel.fromMap(content.first);
        });
      } else {
        throw Exception('Không có data');
      }
      var responseDanhGiaCBL = await httpGet("/api/danh-gia-cbl/get/page?filter=idSv:$idUer");
      if (responseDanhGiaCBL.containsKey("body")) {
        setState(() {
          danhGiaCBLModel = DanhGiaCBLModel();
          var resultLPV = jsonDecode(responseDanhGiaCBL["body"]);
          var content = [];
          content = resultLPV['result']['content'];
          if (content.isNotEmpty) {
            if (content.first['status'] == 0) {
              editNoiDung = true;
            } else {
              editNoiDung = false;
            }
            danhGiaCBLModel = DanhGiaCBLModel.fromMap(content.first);
            print("danhGiaCBLModel.status: ${danhGiaCBLModel.status}");
            print(responseDanhGiaCBL);

          }
        });
      } else {
        throw Exception('Không có data');
      }
    } catch (e) {
      print("Error: $e");
    }
    setState(() {
      statusData = true;
    });


  }

  String getXepLoai(){
    int total_Points = (danhGiaSVModel.diemThanhPhan1 ?? 0) + (danhGiaSVModel.diemThanhPhan2 ?? 0) + (danhGiaSVModel.diemThanhPhan3 ?? 0) + (danhGiaSVModel.diemThanhPhan4 ?? 0) + (danhGiaSVModel.diemThanhPhan5 ?? 0);
    String type = "";
    if (total_Points >= 90)
      type = 'Xuất sắc';
    else if (total_Points >= 80 && total_Points < 90)
      type = 'Tốt';
    else if (total_Points >= 65 && total_Points < 80)
      type = 'Khá';
    else if (total_Points >= 50 && total_Points < 65)
      type = 'Trung Bình';
    else if (total_Points >= 35 && total_Points < 50)
      type = 'Yếu';
    else if (total_Points < 35) type = 'Kém';
    return type;
  }

  @override
  void initState() {
    super.initState();
    callData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: statusData
          ? SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                    Row(
                      children: [
                        if (danhGiaSVModel.status == 0)
                          Text(
                            "Bạn chưa đánh giá",
                            style: TextStyle(
                              color: Colors.red, // Change the text color to red
                              fontSize: 20, // Change the font size to 20 (you can adjust the size as needed)
                            ),
                          ),
                        if (danhGiaSVModel.status == 1 && danhGiaCBLModel.status == 0)
                          Text(
                            "Bạn đã đánh giá",
                            style: TextStyle(
                              color: Colors.red, // Change the text color to red
                              fontSize: 20, // Change the font size to 20 (you can adjust the size as needed)
                            ),
                          ),

                        if (danhGiaSVModel.status == 1 && danhGiaCBLModel.status == 1)
                          Text(
                            "Đã được lớp trưởng đánh giá: ${(danhGiaCBLModel.diemThanhPhan1 ?? 0) + (danhGiaCBLModel.diemThanhPhan2 ?? 0) + (danhGiaCBLModel.diemThanhPhan3 ?? 0) + (danhGiaCBLModel.diemThanhPhan4 ?? 0) + (danhGiaCBLModel.diemThanhPhan5 ?? 0)}đ",
                            style: TextStyle(
                              color: Colors.red, // Change the text color to red
                              fontSize: 20, // Change the font size to 20 (you can adjust the size as needed)
                            ),
                          ),

                        if (danhGiaSVModel.status == 1 && danhGiaCBLModel.status == 2)
                          Text(
                            "Đã được duyệt: ${(danhGiaCBLModel.diemThanhPhan1 ?? 0) + (danhGiaCBLModel.diemThanhPhan2 ?? 0) + (danhGiaCBLModel.diemThanhPhan3 ?? 0) + (danhGiaCBLModel.diemThanhPhan4 ?? 0) + (danhGiaCBLModel.diemThanhPhan5 ?? 0)}đ",
                            style: TextStyle(
                              color: Colors.red, // Change the text color to red
                              fontSize: 18, // Change the text color to black
                            ),
                          ),
                      ],
                    ),
                  SizedBox(height: 10),
                  NoiDung1(
                    edit: editNoiDung,
                    danhGiaCBLModel: danhGiaCBLModel,
                    danhGiaSVModel: danhGiaSVModel,
                    callback: (value) {
                      setState(() {
                        danhGiaSVModel = value;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  NoiDung2(
                    edit: editNoiDung,
                    danhGiaCBLModel: danhGiaCBLModel,
                    danhGiaSVModel: danhGiaSVModel,
                    callback: (value) {
                      setState(() {
                        danhGiaSVModel = value;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  NoiDung3(
                    edit: editNoiDung,
                    danhGiaSVModel: danhGiaSVModel,
                    danhGiaCBLModel: danhGiaCBLModel,
                    callback: (value) {
                      setState(() {
                        danhGiaSVModel = value;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  NoiDung4(
                    edit: editNoiDung,
                    danhGiaSVModel: danhGiaSVModel,
                    danhGiaCBLModel: danhGiaCBLModel,
                    callback: (value) {
                      setState(() {
                        danhGiaSVModel = value;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  NoiDung5(
                    edit: editNoiDung,
                    danhGiaSVModel: danhGiaSVModel,
                    danhGiaCBLModel: danhGiaCBLModel,
                    callback: (value) {
                      setState(() {
                        danhGiaSVModel = value;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Text("Tổng điểm: ${(danhGiaSVModel.diemThanhPhan1 ?? 0) + (danhGiaSVModel.diemThanhPhan2 ?? 0) + (danhGiaSVModel.diemThanhPhan3 ?? 0) + (danhGiaSVModel.diemThanhPhan4 ?? 0) + (danhGiaSVModel.diemThanhPhan5 ?? 0)}"),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [Text("Xếp loại: ${getXepLoai()}")],
                  ),
                  SizedBox(height: 20),
                  if (editNoiDung)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              danhGiaSVModel.status = 1;
                              print(danhGiaSVModel.toJson());
                              await httpPut("/api/danh-gia-sv/put/${danhGiaSVModel.id}", danhGiaSVModel.toJson());
                              showToast(
                                context: context,
                                msg: "Cập nhật thành công",
                                color: Color.fromARGB(255, 59, 255, 111),
                                icon: const Icon(Icons.done),
                              );
                            },
                            child: Text("Cập nhật"))
                      ],
                    ),
                  SizedBox(height: 30),

                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
