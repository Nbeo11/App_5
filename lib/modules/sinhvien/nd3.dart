import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/model/dang.gia.sv.model.dart';

import '../../common/style.dart';
import '../../model/dang.gia.cbl.model.dart';

class NoiDung3 extends StatefulWidget {
  final DanhGiaSVModel danhGiaSVModel;
  final DanhGiaCBLModel danhGiaCBLModel;
  final Function callback;
  final bool edit;
  const NoiDung3({super.key, required this.danhGiaSVModel, required this.callback, required this.edit, required this.danhGiaCBLModel});

  @override
  State<NoiDung3> createState() => _NoiDung3State();
}

class _NoiDung3State extends State<NoiDung3> {
  bool check1 = false;
  DanhGiaSVModel danhGiaSVModel = DanhGiaSVModel();
  DanhGiaCBLModel danhGiaCBLModel = DanhGiaCBLModel();
  TextEditingController tp3so2 = TextEditingController();
  TextEditingController tp3so3 = TextEditingController();

  int tinhDiem(DanhGiaSVModel danhGiaSVModel) {
    int diem = 0;
    diem = 0 + ((danhGiaSVModel.tp3so1 ?? 0) * 10) + ((danhGiaSVModel.tp3so2 ?? 0) * 2) - ((danhGiaSVModel.tp3so3 ?? 0) * 2);
    if (diem < 0) {
      diem = 0;
    }
    if (diem > 20) {
      diem = 20;
    }
    danhGiaSVModel.diemThanhPhan3 = diem;
    widget.callback(danhGiaSVModel);
    return diem;
  }

  @override
  void initState() {
    super.initState();
    danhGiaCBLModel = widget.danhGiaCBLModel;
    danhGiaSVModel = widget.danhGiaSVModel;
    tp3so2.text = "${danhGiaSVModel.tp3so2 ?? 0}";
    tp3so3.text = "${danhGiaSVModel.tp3so3 ?? 0}";
    if (danhGiaSVModel.status == 0) {
      danhGiaSVModel.diemThanhPhan3 = 0;
    }
  }

  @override
  void dispose() {
    tp3so2.dispose();
    tp3so3.dispose();
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
                'III. Ý thức và kết quả tham gia hoạt động chính trị - xã hội, văn hoá, văn nghệ, thể thao, phòng chống các tệ nạn xã hội (0đ)',
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
          dataRowHeight: 85,
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
              DataCell(SizedBox(child: Text("Tham gia đầy đủ các hoạt động của chi đoàn và tham gia đầy đủ các buổi sinh hoạt chính trị theo triệu tập của Nhà trường: +10đ", style: textDataRow))),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp3so1 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaSVModel.tp3so1 = 1;
                      } else {
                        danhGiaSVModel.tp3so1 = 0;
                      }
                      tinhDiem(danhGiaSVModel);
                    });
                  }
                },
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp3so1url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp3so1url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaCBLModel.tp3so1 == 1,
                onChanged: (bool? value) {},
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("2", style: textDataRow)),
              DataCell(Text("Tham gia (có giấy xác nhận) các hoạt động văn nghệ, thể thao, câu lạc bộ, hoạt động tình nguyện….: +2đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: widget.edit,
                    controller: tp3so2,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaSVModel.tp3so2 = valueConvert;
                        tinhDiem(danhGiaSVModel);
                      } else {
                        tp3so2.text = "0";
                        danhGiaSVModel.tp3so2 = 0;
                        tinhDiem(danhGiaSVModel);
                      }
                    },
                  ),
                ),
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp3so2url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp3so2url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaCBLModel.tp3so2 ?? 0}"),
                  ),
                ),
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("3", style: textDataRow)),
              DataCell(Text("Không tham gia Sinh hoạt chính trị theo Quy định: -2đ/buổi", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: widget.edit,
                    controller: tp3so3,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaSVModel.tp3so3 = valueConvert;
                        tinhDiem(danhGiaSVModel);
                      } else {
                        tp3so3.text = "0";
                        danhGiaSVModel.tp3so3 = 0;
                        tinhDiem(danhGiaSVModel);
                      }
                    },
                  ),
                ),
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp3so3url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp3so3url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaCBLModel.tp3so3 ?? 0}"),
                  ),
                ),
              )),
            ]),
          ],
        ),
      ],
    );
  }
}
