import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/model/dang.gia.cbl.model.dart';
import 'package:project_dart/model/dang.gia.sv.model.dart';

import '../../common/style.dart';

class NoiDung3CBL extends StatefulWidget {
  final DanhGiaSVModel danhGiaSVModel;
  final DanhGiaCBLModel danhGiaCBLModel;
  final Function callback;
  final bool edit;
  const NoiDung3CBL({super.key, required this.danhGiaSVModel, required this.callback, required this.edit, required this.danhGiaCBLModel});

  @override
  State<NoiDung3CBL> createState() => _NoiDung3CBLState();
}

class _NoiDung3CBLState extends State<NoiDung3CBL> {
  bool check1 = false;
  DanhGiaSVModel danhGiaSVModel = DanhGiaSVModel();
  DanhGiaCBLModel danhGiaCBLModel = DanhGiaCBLModel();
  TextEditingController tp3so2 = TextEditingController();
  TextEditingController tp3so3 = TextEditingController();

  int tinhDiem(DanhGiaCBLModel danhGiaCBLModel) {
    int diem = 0;
    diem = 0 + ((danhGiaCBLModel.tp3so1 ?? 0) * 10) + ((danhGiaCBLModel.tp3so2 ?? 0) * 2) - ((danhGiaCBLModel.tp3so3 ?? 0) * 2);
    if (diem < 0) {
      diem = 0;
    }
    if (diem > 20) {
      diem = 20;
    }
    danhGiaCBLModel.diemThanhPhan3 = diem;
    widget.callback(danhGiaCBLModel);
    return diem;
  }

  @override
  void initState() {
    super.initState();
    danhGiaCBLModel = widget.danhGiaCBLModel;
    danhGiaSVModel = widget.danhGiaSVModel;
    tp3so2.text = "${danhGiaCBLModel.tp3so2 ?? 0}";
    tp3so3.text = "${danhGiaCBLModel.tp3so3 ?? 0}";
    if (danhGiaCBLModel.status == 0) {
      danhGiaCBLModel.diemThanhPhan3 = 0;
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
                onChanged: (bool? value) {},
              )),
              DataCell((danhGiaSVModel.tp3so1url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp3so1url ?? "");
                      },
                      icon: const Icon(
                        Icons.download,
                        color: Colors.black,
                      ),
                    )
                  : Container()),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaCBLModel.tp3so1 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaCBLModel.tp3so1 = 1;
                      } else {
                        danhGiaCBLModel.tp3so1 = 0;
                      }
                      tinhDiem(danhGiaCBLModel);
                    });
                  }
                },
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("2", style: textDataRow)),
              DataCell(Text("Tham gia (có giấy xác nhận) các hoạt động văn nghệ, thể thao, câu lạc bộ, hoạt động tình nguyện….: +2đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaSVModel.tp3so2 ?? 0}"),
                  ),
                ),
              )),
              DataCell((danhGiaSVModel.tp3so2url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp3so2url ?? "");
                      },
                      icon: const Icon(
                        Icons.download,
                        color: Colors.black,
                      ),
                    )
                  : Container()),
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
                        danhGiaCBLModel.tp3so2 = valueConvert;
                        tinhDiem(danhGiaCBLModel);
                      } else {
                        tp3so2.text = "0";
                        danhGiaCBLModel.tp3so2 = 0;
                        tinhDiem(danhGiaCBLModel);
                      }
                    },
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
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaSVModel.tp3so3 ?? 0}"),
                  ),
                ),
              )),
              DataCell((danhGiaSVModel.tp3so3url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp3so3url ?? "");
                      },
                      icon: const Icon(
                        Icons.download,
                        color: Colors.black,
                      ),
                    )
                  : Container()),
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
                        danhGiaCBLModel.tp3so3 = valueConvert;
                        tinhDiem(danhGiaCBLModel);
                      } else {
                        tp3so3.text = "0";
                        danhGiaCBLModel.tp3so3 = 0;
                        tinhDiem(danhGiaCBLModel);
                      }
                    },
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
