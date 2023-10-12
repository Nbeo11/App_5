// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/model/dang.gia.cbl.model.dart';
import 'package:project_dart/model/dang.gia.sv.model.dart';
import 'package:project_dart/modules/loptruong/danh.gia.sv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user.model.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentListScreenState createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  List<DanhGiaCBLModel> listDanhGiaCBL = [];
  List<DanhGiaSVModel> listDanhGiaSV = [];
  UserModel userModel = UserModel();
  @override
  void initState() {
    super.initState();
    callData();
  }

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

      final response = await httpGet("/api/nguoi-dung/get/$idUer");
      var bodyConvert = jsonDecode(response['body']);
      if (bodyConvert['success'] == true) {
        userModel = UserModel.fromMap(bodyConvert['result']);
      }

      var responseDanhGiaSV = await httpGet("/api/danh-gia-sv/get/page?filter=nguoiDung.idLh:${userModel.idLh} and idSv!$idUer");
      if (responseDanhGiaSV.containsKey("body")) {
        setState(() {
          var resultLPV = jsonDecode(responseDanhGiaSV["body"]);
          var content = [];
          content = resultLPV['result']['content'];
          listDanhGiaSV = content.map((e) {
            return DanhGiaSVModel.fromMap(e);
          }).toList();
        });
      } else {
        throw Exception('Không có data');
      }
      var responseDanhGiaCBL = await httpGet("/api/danh-gia-cbl/get/page?filter=nguoiDung.idLh:${userModel.idLh} and idSv!$idUer");
      if (responseDanhGiaCBL.containsKey("body")) {
        setState(() {
          var resultCBL = jsonDecode(responseDanhGiaCBL["body"]);
          var contentCBL = [];
          contentCBL = resultCBL['result']['content'];
          listDanhGiaCBL = contentCBL.map((e) {
            return DanhGiaCBLModel.fromMap(e);
          }).toList();
        });
      } else {
        throw Exception('Không có data');
      }
    } catch (e) {
      print("Error: $e");
    }
    Future.delayed(Duration(seconds: 1));
    setState(() {
      statusData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double doDai = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              "Lớp: ${(listDanhGiaCBL.isNotEmpty)?listDanhGiaCBL.first.nguoiDung?.lopHoc?.name ?? "":""}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            child: (statusData)
                ? SingleChildScrollView(
                    // scrollDirection: Axis.horizontal,
                    child: DataTable(
                        headingRowColor: MaterialStateProperty.resolveWith((states) {
                          return Color.fromARGB(255, 200, 200, 200);
                        }),
                        showCheckboxColumn: false,
                        columnSpacing: 0,
                        border: TableBorder.all(color: const Color.fromARGB(255, 110, 110, 110)),
                        columns: [
                          DataColumn(
                              label: SizedBox(
                            width: doDai / 8,
                            child: Text(
                              'Mã sinh\nviên',
                              textAlign: TextAlign.center,
                            ),
                          )),
                          DataColumn(label: SizedBox(width: doDai / 4, child: Text('Họ và tên'))),
                          DataColumn(label: Text('Điểm')),
                          DataColumn(label: SizedBox(width: doDai / 8 + 15, child: Text('Tình trạng'))),
                          DataColumn(label: Text('  Chi tiết')),
                        ],
                        rows: [
                          for (var i = 0; i < listDanhGiaSV.length; i++)
                            DataRow(
                              color: MaterialStateProperty.resolveWith((states) {
                                if (listDanhGiaCBL[i].status == 1) {
                                  return Colors.blue;
                                } else {
                                  return Colors.white;
                                }
                              }),
                              cells: [
                                DataCell(Text("${listDanhGiaSV[i].nguoiDung?.username ?? ''} ")),
                                DataCell(Text(" ${listDanhGiaSV[i].nguoiDung?.fullName ?? ''}")),
                                DataCell(Text(" ${(listDanhGiaSV[i].diemThanhPhan1 ?? 0) + (listDanhGiaSV[i].diemThanhPhan2 ?? 0) + (listDanhGiaSV[i].diemThanhPhan3 ?? 0) + (listDanhGiaSV[i].diemThanhPhan4 ?? 0) + (listDanhGiaSV[i].diemThanhPhan5 ?? 0)}")),
                                DataCell(Text((listDanhGiaCBL[i].status != 2) ? 'Chưa phê duyệt' : "Đã phê duyệt")),
                                DataCell(TextButton(
                                  onPressed: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => DanhGiaSinhVien(
                                          isGV: false,
                                          danhGiaCBLModel: listDanhGiaCBL[i],
                                          danhGiaSVModel: listDanhGiaSV[i],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Xem",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                )),
                              ],
                            )
                        ]),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ),
        ),
      ],
    );
  }
}
