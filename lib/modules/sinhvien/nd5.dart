import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/common/style.dart';
import 'package:project_dart/model/dang.gia.sv.model.dart';

import '../../model/dang.gia.cbl.model.dart';

class NoiDung5 extends StatefulWidget {
  final DanhGiaSVModel danhGiaSVModel;
  final DanhGiaCBLModel danhGiaCBLModel;
  final Function callback;
  final bool edit;
  const NoiDung5({super.key, required this.danhGiaSVModel, required this.callback, required this.edit, required this.danhGiaCBLModel});

  @override
  State<NoiDung5> createState() => _NoiDung5State();
}

class _NoiDung5State extends State<NoiDung5> {
  bool check1 = false;
  DanhGiaCBLModel danhGiaCBLModel = DanhGiaCBLModel();

  DanhGiaSVModel danhGiaSVModel = DanhGiaSVModel();
  TextEditingController tp5so3 = TextEditingController();
  TextEditingController tp5so4 = TextEditingController();

  int tinhDiem(DanhGiaSVModel danhGiaSVModel) {
    int diem = 0;
    diem = 0 + ((danhGiaSVModel.tp5so1 ?? 0) * 10) + ((danhGiaSVModel.tp5so2 ?? 0) * 10) + ((danhGiaSVModel.tp5so3 ?? 0) * 5) + ((danhGiaSVModel.tp5so4 ?? 0) * 5) + ((danhGiaSVModel.tp5so5 ?? 0) * 5) + ((danhGiaSVModel.tp5so6 ?? 0) * 5) + ((danhGiaSVModel.tp5so7 ?? 0) * 100);
    if (diem < 0) {
      diem = 0;
    }
    if (diem > 10) {
      diem = 10;
    }
    danhGiaSVModel.diemThanhPhan5 = diem;
    widget.callback(danhGiaSVModel);
    return diem;
  }

  @override
  void initState() {
    super.initState();
    danhGiaCBLModel = widget.danhGiaCBLModel;
    danhGiaSVModel = widget.danhGiaSVModel;
    tp5so3.text = "${danhGiaSVModel.tp5so3 ?? 0}";
    tp5so4.text = "${danhGiaSVModel.tp5so4 ?? 0}";
    if (danhGiaSVModel.status == 0) {
      danhGiaSVModel.diemThanhPhan5 = 0;
    }
  }

  @override
  void dispose() {
    tp5so3.dispose();
    tp5so4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double doDai = MediaQuery.of(context).size.width / 8;
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Text(
                'V.  Ý thức và kết quả tham gia công tác phụ trách lớp, các đoàn thể, tổ chức trong nhà trường hoặc đạt được thành tích đặc biệt trong học tập, rèn luyện của học sinh, sinh viên (0đ)',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        DataTable(
          showCheckboxColumn: false,
          columnSpacing: 5,
          dataRowHeight: 70,
          border: TableBorder.all(color: const Color.fromARGB(255, 110, 110, 110)),
          columns: [
            DataColumn(label: SizedBox(width: doDai - 20, child: Center(child: Text('STT     ', style: textDataColumn)))),
            DataColumn(label: SizedBox(width: doDai * 3, child: Center(child: Text('Nội dung', style: textDataColumn)))),
            DataColumn(label: SizedBox(width: doDai - 10, child: Center(child: Text('SVTDG', style: textDataColumn)))),
            DataColumn(label: SizedBox(width: doDai - 10, child: Center(child: Text('SV_MC', style: textDataColumn)))),
            DataColumn(label: SizedBox(width: doDai - 10, child: Center(child: Text('CBLDG', style: textDataColumn)))),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text("1", style: textDataRow)),
              DataCell(Text("Giữ các chức vụ trong các tổ chức chính quyền, đoàn thể và được đánh giá hoàn thành tốt nhiệm vụ: +10đ", style: textDataRow)),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp5so1 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaSVModel.tp5so1 = 1;
                      } else {
                        danhGiaSVModel.tp5so1 = 0;
                      }
                      tinhDiem(danhGiaSVModel);
                    });
                  }
                },
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp5so1url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp5so1url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaCBLModel.tp5so1 == 1,
                onChanged: (bool? value) {},
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("2", style: textDataRow)),
              DataCell(Text("Học lực (Xuất sắc, Giỏi): +10đ", style: textDataRow)),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp5so2 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaSVModel.tp5so2 = 1;
                      } else {
                        danhGiaSVModel.tp5so2 = 0;
                      }
                      tinhDiem(danhGiaSVModel);
                    });
                  }
                },
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp5so2url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp5so2url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaCBLModel.tp5so2 == 1,
                onChanged: (bool? value) {},
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("3", style: textDataRow)),
              DataCell(Text("Tham gia các cuộc thi chuyên môn như Procon, Olympic,…: +5đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    controller: tp5so3,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaSVModel.tp5so3 = valueConvert;
                        tinhDiem(danhGiaSVModel);
                      } else {
                        tp5so3.text = "0";
                        danhGiaSVModel.tp5so3 = 0;
                        tinhDiem(danhGiaSVModel);
                      }
                    },
                  ),
                ),
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp5so3url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp5so3url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaCBLModel.tp5so3 ?? 0}"),
                  ),
                ),
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("4", style: textDataRow)),
              DataCell(Text("Đạt giải tại các cuộc thi chuyên môn: +5đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    controller: tp5so4,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaSVModel.tp5so4 = valueConvert;
                        tinhDiem(danhGiaSVModel);
                      } else {
                        tp5so4.text = "0";
                        danhGiaSVModel.tp5so4 = 0;
                        tinhDiem(danhGiaSVModel);
                      }
                    },
                  ),
                ),
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp5so4url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp5so4url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaCBLModel.tp5so4 ?? 0}"),
                  ),
                ),
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("5", style: textDataRow)),
              DataCell(Text("Tham gia NCKH (không phải là SV NVCL): +5đ", style: textDataRow)),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp5so5 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaSVModel.tp5so5 = 1;
                      } else {
                        danhGiaSVModel.tp5so5 = 0;
                      }
                      tinhDiem(danhGiaSVModel);
                    });
                  }
                },
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp5so5url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp5so5url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaCBLModel.tp5so5 == 1,
                onChanged: (bool? value) {},
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("6", style: textDataRow)),
              DataCell(Text("Đạt giải NCKH các cấp hoặc có báo cáo tại Hội nghị NCKH/bài báo đăng trên các tạp chí trong và ngoài nước: +5đ", style: textDataRow)),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp5so6 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaSVModel.tp5so6 = 1;
                      } else {
                        danhGiaSVModel.tp5so6 = 0;
                      }
                      tinhDiem(danhGiaSVModel);
                    });
                  }
                },
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp5so6url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp5so6url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaCBLModel.tp5so6 == 1,
                onChanged: (bool? value) {},
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("7", style: textDataRow)),
              DataCell(Text("Được kết nạp Đảng: +10đ", style: textDataRow)),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp5so7 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaSVModel.tp5so7 = 1;
                      } else {
                        danhGiaSVModel.tp5so7 = 0;
                      }
                      tinhDiem(danhGiaSVModel);
                    });
                  }
                },
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp5so7url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp5so7url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaCBLModel.tp5so7 == 1,
                onChanged: (bool? value) {},
              )),
            ]),
          ],
        ),
      ],
    );
  }
}
