// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/common/toast.dart';
import 'package:project_dart/model/dang.gia.cbl.model.dart';
import 'package:project_dart/model/dang.gia.sv.model.dart';
import 'package:project_dart/modules/loptruong/nd1.cbl.dart';
import 'package:project_dart/modules/loptruong/nd2.clb.dart';
import 'package:project_dart/modules/loptruong/nd3.cbl.dart';
import 'package:project_dart/modules/loptruong/nd4.cbl.dart';
import 'package:project_dart/modules/loptruong/nd5.cbl.dart';

class DanhGiaSinhVien extends StatefulWidget {
  final bool? isGV;
  final DanhGiaSVModel danhGiaSVModel;
  final DanhGiaCBLModel danhGiaCBLModel;
  const DanhGiaSinhVien({super.key, required this.danhGiaSVModel, required this.danhGiaCBLModel, required this.isGV});

  @override
  State<DanhGiaSinhVien> createState() => _DanhGiaSinhVienState();
}

class _DanhGiaSinhVienState extends State<DanhGiaSinhVien> {
  bool editNoiDung = false;
  DanhGiaSVModel danhGiaSVModel = DanhGiaSVModel();
  DanhGiaCBLModel danhGiaCBLModel = DanhGiaCBLModel();
  @override
  void initState() {
    super.initState();
    danhGiaSVModel = widget.danhGiaSVModel;
    danhGiaCBLModel = widget.danhGiaCBLModel;
    if (danhGiaSVModel.status == 1 && danhGiaCBLModel.status!=2) {
      editNoiDung = true;
      danhGiaCBLModel.diemThanhPhan1 =danhGiaCBLModel.diemThanhPhan1?? 30;
      danhGiaCBLModel.diemThanhPhan2 =danhGiaCBLModel.diemThanhPhan2?? 25;
      danhGiaCBLModel.diemThanhPhan3 =danhGiaCBLModel.diemThanhPhan3?? 0;
      danhGiaCBLModel.diemThanhPhan4 =danhGiaCBLModel.diemThanhPhan4?? 15;
      danhGiaCBLModel.diemThanhPhan5 =danhGiaCBLModel.diemThanhPhan5?? 0;
    } else {
      editNoiDung = false;
    }
    if (widget.isGV == true) {
      editNoiDung = false;
    }
    print (danhGiaCBLModel);
  }

  String getXepLoai(){
    int total_Points = (danhGiaCBLModel.diemThanhPhan1 ?? 0) + (danhGiaCBLModel.diemThanhPhan2 ?? 0) + (danhGiaCBLModel.diemThanhPhan3 ?? 0) + (danhGiaCBLModel.diemThanhPhan4 ?? 0) + (danhGiaCBLModel.diemThanhPhan5 ?? 0);
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            setState(() {
              danhGiaCBLModel = widget.danhGiaCBLModel;
            });
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("${danhGiaSVModel.nguoiDung?.username ?? ""} - ${danhGiaSVModel.nguoiDung?.fullName ?? ""}"),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text("Tổng điểm tự dánh giá: ${(danhGiaSVModel.diemThanhPhan1 ?? 0) + (danhGiaSVModel.diemThanhPhan2 ?? 0) + (danhGiaSVModel.diemThanhPhan3 ?? 0) + (danhGiaSVModel.diemThanhPhan4 ?? 0) + (danhGiaSVModel.diemThanhPhan5 ?? 0)}"),
              SizedBox(height: 30),
              NoiDung1CBL(
                edit: editNoiDung,
                danhGiaSVModel: danhGiaSVModel,
                danhGiaCBLModel: danhGiaCBLModel,
                callback: (value) {
                  setState(() {
                    danhGiaCBLModel = value;
                  });
                },
              ),
              SizedBox(height: 30),
              NoiDung2CBL(
                edit: editNoiDung,
                danhGiaSVModel: danhGiaSVModel,
                danhGiaCBLModel: danhGiaCBLModel,
                callback: (value) {
                  setState(() {
                    danhGiaCBLModel = value;
                  });
                },
              ),
              SizedBox(height: 30),
              NoiDung3CBL(
                edit: editNoiDung,
                danhGiaSVModel: danhGiaSVModel,
                danhGiaCBLModel: danhGiaCBLModel,
                callback: (value) {
                  setState(() {
                    danhGiaCBLModel = value;
                  });
                },
              ),
              SizedBox(height: 30),
              NoiDung4CBL(
                edit: editNoiDung,
                danhGiaSVModel: danhGiaSVModel,
                danhGiaCBLModel: danhGiaCBLModel,
                callback: (value) {
                  setState(() {
                    danhGiaCBLModel = value;
                  });
                },
              ),
              SizedBox(height: 30),
              NoiDung5CBL(
                edit: editNoiDung,
                danhGiaSVModel: danhGiaSVModel,
                danhGiaCBLModel: danhGiaCBLModel,
                callback: (value) {
                  setState(() {
                    danhGiaCBLModel = value;
                  });
                },
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text("Tổng điểm: ${(danhGiaCBLModel.diemThanhPhan1 ?? 0) + (danhGiaCBLModel.diemThanhPhan2 ?? 0) + (danhGiaCBLModel.diemThanhPhan3 ?? 0) + (danhGiaCBLModel.diemThanhPhan4 ?? 0) + (danhGiaCBLModel.diemThanhPhan5 ?? 0)}"),
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
                          danhGiaCBLModel.status = 1;
                          await httpPut("/api/danh-gia-cbl/put/${danhGiaCBLModel.id}", danhGiaCBLModel.toJson());
                          // ignore: use_build_context_synchronously
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
              if (widget.isGV == true && danhGiaCBLModel.status == 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          print(danhGiaCBLModel.toJson());
                          danhGiaCBLModel.status = 2;
                          await httpPut("/api/danh-gia-cbl/put/${danhGiaCBLModel.id}", danhGiaCBLModel.toJson());
                          // ignore: use_build_context_synchronously
                          showToast(
                            context: context,
                            msg: "Phê duyệt thành công",
                            color: Color.fromARGB(255, 59, 255, 111),
                            icon: const Icon(Icons.done),
                          );
                        },
                        child: Text("Phê duyệt")),
                  ],
                ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
