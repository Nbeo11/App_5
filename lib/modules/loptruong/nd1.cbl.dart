// ignore_for_file: empty_catches
import 'package:flutter/material.dart';
import 'package:project_dart/API/api.dart';
import 'package:project_dart/common/style.dart';
import '../../model/dang.gia.cbl.model.dart';
import '../../model/dang.gia.sv.model.dart';

class NoiDung1CBL extends StatefulWidget {
  final DanhGiaSVModel danhGiaSVModel;
  final DanhGiaCBLModel danhGiaCBLModel;
  final Function callback;
  final bool edit;
  const NoiDung1CBL({super.key, required this.danhGiaSVModel, required this.callback, required this.edit, required this.danhGiaCBLModel});

  @override
  State<NoiDung1CBL> createState() => _NoiDung1CBLState();
}

class _NoiDung1CBLState extends State<NoiDung1CBL> {
  DanhGiaSVModel danhGiaSVModel = DanhGiaSVModel();
  DanhGiaCBLModel danhGiaCBLModel = DanhGiaCBLModel();

  TextEditingController tp1so4 = TextEditingController();
  TextEditingController tp1so5 = TextEditingController();

  int tinhDiem(DanhGiaCBLModel danhGiaCBLModel) {
    int diem = 30;
    diem = 30 - ((danhGiaCBLModel.tp1so1 ?? 0) * 3) - ((danhGiaCBLModel.tp1so2 ?? 0) * 5) - ((danhGiaCBLModel.tp1so3 ?? 0) * 5) - ((danhGiaCBLModel.tp1so4 ?? 0) * 5) - ((danhGiaCBLModel.tp1so5 ?? 0) * 2);
    if (danhGiaCBLModel.tp1kl == 1) {
      double myDouble = diem * 0.75;
      diem = myDouble.round();
    } else if (danhGiaCBLModel.tp1kl == 2) {
      double myDouble = diem * 0.5;
      diem = myDouble.round();
    } else if (danhGiaCBLModel.tp1kl == 3) {
      diem = 0;
    }
    if (diem < 0) {
      diem = 0;
    }
    danhGiaCBLModel.diemThanhPhan1 = diem;
    widget.callback(danhGiaCBLModel);
    return diem;
  }

  @override
  void initState() {
    super.initState();
    danhGiaCBLModel = widget.danhGiaCBLModel;
    danhGiaSVModel = widget.danhGiaSVModel;
    tp1so4.text = "${danhGiaCBLModel.tp1so4 ?? 0}";
    tp1so5.text = "${danhGiaCBLModel.tp1so5 ?? 0}";
    if (danhGiaCBLModel.status == 0) {
      danhGiaCBLModel.diemThanhPhan1 = 30;
    }
  }

  @override
  void dispose() {
    tp1so4.dispose();
    tp1so5.dispose();
    super.dispose();
  }

  bool check1 = false;
  @override
  Widget build(BuildContext context) {
    double doDai = MediaQuery.of(context).size.width / 8;
    return Column(
      children: [
        const Row(
          children: [
            Expanded(
              child: Text(
                'I. Ý thức học tập (30đ)',
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
              DataCell(Text("Học lực yếu -3đ", style: textDataRow)),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp1so1 == 1,
                onChanged: (bool? value) {},
              )),
              DataCell((danhGiaSVModel.tp1so1url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp1so1url ?? "");
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
                value: danhGiaCBLModel.tp1so1 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaCBLModel.tp1so1 = 1;
                      } else {
                        danhGiaCBLModel.tp1so1 = 0;
                      }
                      tinhDiem(danhGiaCBLModel);
                    });
                  }
                },
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("2", style: textDataRow)),
              DataCell(Text("Bị cảnh báo học vụ -5đ", style: textDataRow)),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp1so2 == 1,
                onChanged: (bool? value) {},
              )),
              DataCell((danhGiaSVModel.tp1so2url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp1so2url ?? "");
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
                value: danhGiaCBLModel.tp1so2 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaCBLModel.tp1so2 = 1;
                      } else {
                        danhGiaCBLModel.tp1so2 = 0;
                      }
                      tinhDiem(danhGiaCBLModel);
                    });
                  }
                },
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("3", style: textDataRow)),
              DataCell(Text("Đăng ký không đủ tín chỉ theo Quy định -5đ", style: textDataRow)),
              DataCell(Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.blue,
                value: danhGiaSVModel.tp1so3 == 1,
                onChanged: (bool? value) {},
              )),
              DataCell((danhGiaSVModel.tp1so3url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp1so3url ?? "");
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
                value: danhGiaCBLModel.tp1so3 == 1,
                onChanged: (bool? value) {
                  if (widget.edit) {
                    setState(() {
                      if (value == true) {
                        danhGiaCBLModel.tp1so3 = 1;
                      } else {
                        danhGiaCBLModel.tp1so3 = 0;
                      }
                      tinhDiem(danhGiaCBLModel);
                    });
                  }
                },
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("4", style: textDataRow)),
              DataCell(Text("Không tham gia NCKH theo Quy định (đối với sinh viên NVCL): -5đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaSVModel.tp1so4 ?? 0}"),
                  ),
                ),
              )),
              DataCell((danhGiaSVModel.tp1so4url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp1so4url ?? "");
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
                    controller: tp1so4,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaCBLModel.tp1so4 = valueConvert;
                        tinhDiem(danhGiaCBLModel);
                      } else {
                        tp1so4.text = "0";
                        danhGiaCBLModel.tp1so4 = 0;
                        tinhDiem(danhGiaCBLModel);
                      }
                    },
                  ),
                ),
              )),
            ]),
            DataRow(cells: [
              DataCell(Text("5", style: textDataRow)),
              DataCell(Text("Bị cấm thi hoặc bỏ thi cuối kì không có lý do: -2đ/lần", style: textDataRow)),
              DataCell(Center(
                child: SizedBox(
                  width: doDai / 2,
                  child: TextField(
                    enabled: false,
                    controller: TextEditingController(text: "${danhGiaSVModel.tp1so5 ?? 0}"),
                  ),
                ),
              )),
              DataCell((danhGiaSVModel.tp1so5url != null)
                  ? IconButton(
                      onPressed: () async {
                        await downloadFile(context, danhGiaSVModel.tp1so5url ?? "");
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
                    controller: tp1so5,
                    decoration: const InputDecoration(border: InputBorder.none),
                    onChanged: (value) {
                      int? valueConvert = int.tryParse(value);
                      if (valueConvert != null && valueConvert > -1) {
                        danhGiaCBLModel.tp1so5 = valueConvert;
                        tinhDiem(danhGiaCBLModel);
                      } else {
                        tp1so5.text = "0";
                        danhGiaCBLModel.tp1so5 = 0;
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
              "Kỷ luật thi (SV):",
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
                      value: danhGiaSVModel.tp1kl == 1,
                      onChanged: (bool? value) {},
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Đình chỉ",
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
                      value: danhGiaSVModel.tp1kl == 2,
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
                      value: danhGiaSVModel.tp1kl == 3,
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
            )
          ],
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Kỷ luật thi(CBL):",
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
                      value: danhGiaCBLModel.tp1kl == 1,
                      onChanged: (bool? value) {
                        if (widget.edit) {
                          setState(() {
                            if (value == true) {
                              danhGiaCBLModel.tp1kl = 1;
                            } else {
                              danhGiaCBLModel.tp1kl = 0;
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
                        "Đình chỉ",
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
                      value: danhGiaCBLModel.tp1kl == 2,
                      onChanged: (bool? value) {
                        if (widget.edit) {
                          setState(() {
                            if (value == true) {
                              danhGiaCBLModel.tp1kl = 2;
                            } else {
                              danhGiaCBLModel.tp1kl = 0;
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
                      value: danhGiaCBLModel.tp1kl == 3,
                      onChanged: (bool? value) {
                        if (widget.edit) {
                          setState(() {
                            if (value == true) {
                              danhGiaCBLModel.tp1kl = 3;
                            } else {
                              danhGiaCBLModel.tp1kl = 0;
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
            )
          ],
        ),

      ],
    );
  }
}
