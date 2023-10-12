import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';

import '../../common/style.dart';
import '../../model/dang.gia.cbl.model.dart';
import '../../model/dang.gia.sv.model.dart';

class NoiDung4 extends StatefulWidget {
  final DanhGiaCBLModel danhGiaCBLModel;
  final DanhGiaSVModel danhGiaSVModel;
  final Function callback;
  final bool edit;
  const NoiDung4({super.key, required this.danhGiaSVModel, required this.callback, required this.edit, required this.danhGiaCBLModel});

  @override
  State<NoiDung4> createState() => _NoiDung4State();
}

class _NoiDung4State extends State<NoiDung4> {
  DanhGiaSVModel danhGiaSVModel = DanhGiaSVModel();
  DanhGiaCBLModel danhGiaCBLModel = DanhGiaCBLModel();
  TextEditingController tp4so1 = TextEditingController();
  TextEditingController tp4so2 = TextEditingController();

  int tinhDiem(DanhGiaSVModel danhGiaSVModel) {
    int diem = 15;
    diem = 15 - ((danhGiaSVModel.tp4so1 ?? 0) * 5) - ((danhGiaSVModel.tp4so2 ?? 0) * 5);
    if (diem < 0) {
      diem = 0;
    }
    danhGiaSVModel.diemThanhPhan4 = diem;
    widget.callback(danhGiaSVModel);
    return diem;
  }

  @override
  void initState() {
    super.initState();
    danhGiaSVModel = widget.danhGiaSVModel;
    danhGiaCBLModel = widget.danhGiaCBLModel;
    tp4so1.text = "${danhGiaSVModel.tp4so1 ?? 0}";
    tp4so2.text = "${danhGiaSVModel.tp4so2 ?? 0}";
    if (danhGiaSVModel.status == 0) {
      danhGiaSVModel.diemThanhPhan4 = 15;
    }
  }

  @override
  void dispose() {
    tp4so1.dispose();
    tp4so2.dispose();
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
                'IV. Về phẩm chất công dân và quan hệ với cộng đồng (15đ)',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
        DataTable(
          dataRowHeight: 90,
          showCheckboxColumn: false,
          columnSpacing: 5,
          border: TableBorder.all(color: const Color.fromARGB(255, 110, 110, 110)),
          columns: [
            DataColumn(label: SizedBox(width: doDai - 20, child: Center(child: Text('STT     ', style: textDataColumn)))),
            DataColumn(label: SizedBox(width: doDai * 3, child: Center(child: Text('Nội dung', style: textDataColumn)))),
            DataColumn(label: SizedBox(width: doDai, child: Center(child: Text('SVTDG', style: textDataColumn)))),
            DataColumn(label: SizedBox(width: doDai - 10, child: Center(child: Text('SV_MC', style: textDataColumn)))),
            DataColumn(label: SizedBox(width: doDai - 10, child: Center(child: Text('CBLDG', style: textDataColumn)))),
          ],
          rows: [
            DataRow(cells: [
              DataCell(Text("1", style: textDataRow)),
              DataCell(SizedBox(child: Text("Có thông báo bằng văn bản về việc không chấp hành các chủ trương của Đảng, CSPL Nhà nước, vi phạm ANCT, TTATXH, ATGT: -5đ/lần", style: textDataRow))),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: widget.edit,
                    controller: tp4so1,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaSVModel.tp4so1 = valueConvert;
                        tinhDiem(danhGiaSVModel);
                      } else {
                        tp4so1.text = "0";
                        danhGiaSVModel.tp4so1 = 0;
                        tinhDiem(danhGiaSVModel);
                      }
                    },
                  ),
                ),
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp4so1url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp4so1url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaCBLModel.tp4so1 ?? 0}"),
                  ),
                ),
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("2", style: textDataRow)),
              DataCell(Text("Không có tinh thần giúp đỡ bạn bè, không thể hiện tinh thần đoàn kết tập thể: -5đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: widget.edit,
                    controller: tp4so2,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaSVModel.tp4so2 = valueConvert;
                        tinhDiem(danhGiaSVModel);
                      } else {
                        tp4so2.text = "0";
                        danhGiaSVModel.tp4so2 = 0;
                        tinhDiem(danhGiaSVModel);
                      }
                    },
                  ),
                ),
              )),
              DataCell(IconButton(
                onPressed: () async {
                  danhGiaSVModel.tp4so2url = await handleUploadFile();
                  tinhDiem(danhGiaSVModel);
                },
                icon: Icon(
                  Icons.upload_file,
                  color: (danhGiaSVModel.tp4so2url != null) ? Colors.blue : Colors.black,
                ),
              )),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaCBLModel.tp4so2 ?? 0}"),
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
