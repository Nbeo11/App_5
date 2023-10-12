import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/model/dang.gia.cbl.model.dart';

import '../../common/style.dart';
import '../../model/dang.gia.sv.model.dart';

class NoiDung2CBL extends StatefulWidget {
  final DanhGiaSVModel danhGiaSVModel;
  final DanhGiaCBLModel danhGiaCBLModel;
  final Function callback;
  final bool edit;
  const NoiDung2CBL({super.key, required this.danhGiaSVModel, required this.callback, required this.edit, required this.danhGiaCBLModel});

  @override
  State<NoiDung2CBL> createState() => _NoiDung2CBLState();
}

class _NoiDung2CBLState extends State<NoiDung2CBL> {
  bool check1 = false;
  DanhGiaSVModel danhGiaSVModel = DanhGiaSVModel();
  DanhGiaCBLModel danhGiaCBLModel = DanhGiaCBLModel();
  TextEditingController tp2so1 = TextEditingController();
  TextEditingController tp2so3 = TextEditingController();
  TextEditingController tp2so4 = TextEditingController();
  TextEditingController tp2so6 = TextEditingController();

  int tinhDiem(DanhGiaCBLModel danhGiaCBLModel) {
    int diem = 25;
    diem = 25 - ((danhGiaCBLModel.tp2so1 ?? 0) * 5) - ((danhGiaCBLModel.tp2so2 ?? 0) * 2) - ((danhGiaCBLModel.tp2so3 ?? 0) * 5) - ((danhGiaCBLModel.tp2so4 ?? 0) * 5) - ((danhGiaCBLModel.tp2so5 ?? 0) * 5) - ((danhGiaCBLModel.tp2so6 ?? 0) * 10);
    if (danhGiaCBLModel.tp2kl == 1) {
      double myDouble = diem * 0.75;
      diem = myDouble.round();
    } else if (danhGiaCBLModel.tp2kl == 2) {
      double myDouble = diem * 0.5;
      diem = myDouble.round();
    } else if (danhGiaCBLModel.tp2kl == 3) {
      diem = 0;
    }
    if (diem < 0) {
      diem = 0;
    }
    danhGiaCBLModel.diemThanhPhan2 = diem;
    widget.callback(danhGiaCBLModel);
    return diem;
  }

  @override
  void initState() {
    super.initState();
    danhGiaSVModel = widget.danhGiaSVModel;
    danhGiaCBLModel = widget.danhGiaCBLModel;
    tp2so1.text = "${danhGiaCBLModel.tp2so1 ?? 0}";
    tp2so3.text = "${danhGiaCBLModel.tp2so3 ?? 0}";
    tp2so4.text = "${danhGiaCBLModel.tp2so4 ?? 0}";
    tp2so6.text = "${danhGiaCBLModel.tp2so6 ?? 0}";
    if (danhGiaCBLModel.status == 0) {
      danhGiaCBLModel.diemThanhPhan2 = 25;
    }
  }

  @override
  void dispose() {
    tp2so1.dispose();
    tp2so3.dispose();
    tp2so4.dispose();
    tp2so6.dispose();
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
                'II. Ý thức và kết quả chấp hành nội quy, quy chế trong nhà trường (25đ)',
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
              DataCell(Text("Nộp hoặc nhận không đúng một khoản kinh phí: -5đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaSVModel.tp2so1 ?? 0}"),
                  ),
                ),
              )),
              DataCell((danhGiaSVModel.tp2so1url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp2so1url ?? "");
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
                    controller: tp2so1,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaCBLModel.tp2so1 = valueConvert;
                        tinhDiem(danhGiaCBLModel);
                      } else {
                        tp2so1.text = "0";
                        danhGiaCBLModel.tp2so1 = 0;
                        tinhDiem(danhGiaCBLModel);
                      }
                    },
                  ),
                ),
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("2", style: textDataRow)),
              DataCell(Text("Đăng ký học quá hạn (nếu được chấp nhận) -2đ", style: textDataRow)),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp2so2 == 1,
                onChanged: (bool? value) {},
              )),
              DataCell((danhGiaSVModel.tp2so2url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp2so2url ?? "");
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
                value: danhGiaCBLModel.tp2so2 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaCBLModel.tp2so2 = 1;
                      } else {
                        danhGiaCBLModel.tp2so2 = 0;
                      }
                      tinhDiem(danhGiaCBLModel);
                    });
                  }
                },
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("3", style: textDataRow)),
              DataCell(Text("Không thực hiện theo Giấy triệu tập/Yêu cầu của Nhà trường: -5đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaSVModel.tp2so3 ?? 0}"),
                  ),
                ),
              )),
              DataCell((danhGiaSVModel.tp2so3url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp2so3url ?? "");
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
                    controller: tp2so3,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaCBLModel.tp2so3 = valueConvert;
                        tinhDiem(danhGiaCBLModel);
                      } else {
                        tp2so3.text = "0";
                        danhGiaCBLModel.tp2so3 = 0;
                        tinhDiem(danhGiaCBLModel);
                      }
                    },
                  ),
                ),
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("4", style: textDataRow)),
              DataCell(Text("Trả quá hạn giấy tờ/hồ sơ đã được phép mượn: -5đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaSVModel.tp2so4 ?? 0}"),
                  ),
                ),
              )),
              DataCell((danhGiaSVModel.tp2so4url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp2so4url ?? "");
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
                    controller: tp2so4,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaCBLModel.tp2so4 = valueConvert;
                        tinhDiem(danhGiaCBLModel);
                      } else {
                        tp2so4.text = "0";
                        danhGiaCBLModel.tp2so4 = 0;
                        tinhDiem(danhGiaCBLModel);
                      }
                    },
                  ),
                ),
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("5", style: textDataRow)),
              DataCell(Text("Không tham gia Bảo hiểm Y tế: -5đ", style: textDataRow)),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp2so5 == 1,
                onChanged: (bool? value) {},
              )),
              DataCell((danhGiaSVModel.tp2so5url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp2so5url ?? "");
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
                value: danhGiaCBLModel.tp2so5 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaCBLModel.tp2so5 = 1;
                      } else {
                        danhGiaCBLModel.tp2so5 = 0;
                      }
                      tinhDiem(danhGiaCBLModel);
                    });
                  }
                },
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("6", style: textDataRow)),
              DataCell(Text("Vi phạm quy định nơi cư trú: -10đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaSVModel.tp2so6 ?? 0}"),
                  ),
                ),
              )),
              DataCell((danhGiaSVModel.tp2so6url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp2so6url ?? "");
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
                    controller: tp2so6,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaCBLModel.tp2so6 = valueConvert;
                        tinhDiem(danhGiaCBLModel);
                      } else {
                        tp2so6.text = "0";
                        danhGiaCBLModel.tp2so6 = 0;
                        tinhDiem(danhGiaCBLModel);
                      }
                    },
                  ),
                ),
              )),
            ]),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Có quyết định kỷ\nluật: (SV)",
              style: textDataRow,
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: danhGiaSVModel.tp2kl == 1,
                      onChanged: (bool? value) {},
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Cảnh cáo",
                        style: textDataRow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: danhGiaSVModel.tp2kl == 2,
                      onChanged: (bool? value) {},
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Khiển trách",
                        style: textDataRow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: danhGiaSVModel.tp2kl == 3,
                      onChanged: (bool? value) {},
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phê bình",
                        style: textDataRow,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Có quyết định kỷ\nluật:(CBL)",
              style: textDataRow,
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: danhGiaCBLModel.tp2kl == 1,
                      onChanged: (bool? value) {
                        if (widget.edit) {
                          setState(() {
                            if (value == true) {
                              danhGiaCBLModel.tp2kl = 1;
                            } else {
                              danhGiaCBLModel.tp2kl = 0;
                            }
                            tinhDiem(danhGiaCBLModel);
                          });
                        }
                      },
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Cảnh cáo",
                        style: textDataRow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: Colors.blue,
                      value: danhGiaCBLModel.tp2kl == 2,
                      onChanged: (bool? value) {
                        if (widget.edit) {
                          setState(() {
                            if (value == true) {
                              danhGiaCBLModel.tp2kl = 2;
                            } else {
                              danhGiaCBLModel.tp2kl = 0;
                            }
                            tinhDiem(danhGiaCBLModel);
                          });
                        }
                      },
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Khiển trách",
                        style: textDataRow,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: Colors.blue,
                    value: danhGiaCBLModel.tp2kl == 3,
                    onChanged: (bool? value) {
                      if (widget.edit) {
                        setState(() {
                          if (value == true) {
                            danhGiaCBLModel.tp2kl = 3;
                          } else {
                            danhGiaCBLModel.tp2kl = 0;
                          }
                          tinhDiem(danhGiaCBLModel);
                        });
                      }
                    },
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phê bình",
                        style: textDataRow,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
