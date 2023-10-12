// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/common/loading.dart';
import 'package:project_dart/common/toast.dart';
import 'package:project_dart/model/dang.gia.cbl.model.dart';
import 'package:project_dart/model/dang.gia.sv.model.dart';
import 'package:project_dart/model/lop.hoc.model.dart';
import 'package:project_dart/modules/loptruong/danh.gia.sv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/user.model.dart';
import 'package:dropdown_search/dropdown_search.dart';

class StudentListScreenGV extends StatefulWidget {
  const StudentListScreenGV({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StudentListScreenGVState createState() => _StudentListScreenGVState();
}

class _StudentListScreenGVState extends State<StudentListScreenGV> {
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

  LopHocModel selectLopHoc = LopHocModel(id: 0, name: "Tất cả");
  Future<List<LopHocModel>> getLopHoc() async {
    List<LopHocModel> listCareer = [LopHocModel(id: 0, name: "Tất cả")];
    var response = await httpGet("/api/lop-hoc/get/page");
    print(response);
    var body = jsonDecode(response['body']);
    var content = [];
    content = body['content'];
    for (var element in content) {
      LopHocModel item = LopHocModel.fromMap(element);
      listCareer.add(item);
    }
    return listCareer;
  }

  bool statusData = false;
  callData() async {
    setState(() {
      statusData = false;
    });
    if (selectLopHoc.id == 0) {
      setState(() {
        listDanhGiaCBL = [];
        listDanhGiaSV = [];
      });
    } else {
      try {
        var responseDanhGiaSV = await httpGet("/api/danh-gia-sv/get/page?filter=nguoiDung.idLh:${selectLopHoc.id}");
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
        var responseDanhGiaCBL = await httpGet("/api/danh-gia-cbl/get/page?filter=nguoiDung.idLh:${selectLopHoc.id}");
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
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  "Lớp học",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
              ),
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  height: 40,
                  child: DropdownSearch<LopHocModel>(
                    asyncItems: (String? filter) => getLopHoc(),
                    itemAsString: (LopHocModel? u) => "${u!.name}",
                    selectedItem: selectLopHoc,
                    onChanged: (value) {
                      setState(() {
                        selectLopHoc = value!;
                        callData();
                      });
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        if (listDanhGiaCBL.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    onLoading(context);
                    for (var i = 0; i < listDanhGiaCBL.length; i++) {
                      if (listDanhGiaCBL[i].status == 1) {
                        setState(() {
                          listDanhGiaCBL[i].status = 2;
                        });
                         await httpPut("/api/danh-gia-cbl/put/${listDanhGiaCBL[i].id}", listDanhGiaCBL[i].toJson()); 
                      }
                    }
                    showToast(
                            context: context,
                            msg: "Phê duyệt thành công",
                            color: Color.fromARGB(255, 59, 255, 111),
                            icon: const Icon(Icons.done),
                          );
                    Navigator.pop(context);
                  },
                  child: Text("Duyệt tất cả")),
              SizedBox(width: 10),
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
                                if (listDanhGiaCBL[i].status == 2) {
                                  return Colors.blue;
                                } else {
                                  return Colors.white;
                                }
                              }),
                              cells: [
                                DataCell(Text("${listDanhGiaSV[i].nguoiDung?.username ?? ''} ")),
                                DataCell(Text(" ${listDanhGiaSV[i].nguoiDung?.fullName ?? ''}")),
                                (listDanhGiaCBL[i].status==0)?  DataCell(Text(""))
                                :DataCell(Text(" ${(listDanhGiaCBL[i].diemThanhPhan1 ?? 0) + (listDanhGiaCBL[i].diemThanhPhan2 ?? 0) + (listDanhGiaCBL[i].diemThanhPhan3 ?? 0) + (listDanhGiaCBL[i].diemThanhPhan4 ?? 0) + (listDanhGiaCBL[i].diemThanhPhan5 ?? 0)}")),
                                DataCell(Text((listDanhGiaCBL[i].status != 2) ? 'Chưa phê duyệt' : "Đã phê duyệt")),
                                DataCell(TextButton(
                                  onPressed: () {
                                    Navigator.push<void>(
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) => DanhGiaSinhVien(
                                          isGV: true,
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
