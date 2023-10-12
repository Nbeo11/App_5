import 'user.model.dart';

class DanhGiaSVModel {
  int? id;
  int? idSv;
  UserModel? nguoiDung;
  //phan1
  int? diemThanhPhan1;
  int? tp1so1;
  String? tp1so1url;
  int? tp1so2;
  String? tp1so2url;
  int? tp1so3;
  String? tp1so3url;
  int? tp1so4;
  String? tp1so4url;
  int? tp1so5;
  String? tp1so5url;
  //0:la ko ky luat    1: dinh chi       2: canh cao        3: Khien trach
  int? tp1kl;

  //phan2
  int? diemThanhPhan2;
  int? tp2so1;
  String? tp2so1url;
  int? tp2so2;
  String? tp2so2url;
  int? tp2so3;
  String? tp2so3url;
  int? tp2so4;
  String? tp2so4url;
  int? tp2so5;
  String? tp2so5url;
  int? tp2so6;
  String? tp2so6url;
  //0:la ko ky luat    1: canh cao        2: Khien trach        3: Phe binh
  int? tp2kl;

  //pahn3
  int? diemThanhPhan3;
  int? tp3so1;
  String? tp3so1url;
  int? tp3so2;
  String? tp3so2url;
  int? tp3so3;
  String? tp3so3url;

  //pahn4
  int? diemThanhPhan4;
  int? tp4so1;
  String? tp4so1url;
  int? tp4so2;
  String? tp4so2url;

  //pahn5
  int? diemThanhPhan5;
  int? tp5so1;
  String? tp5so1url;
  int? tp5so2;
  String? tp5so2url;
  int? tp5so3;
  String? tp5so3url;
  int? tp5so4;
  String? tp5so4url;
  int? tp5so5;
  String? tp5so5url;
  int? tp5so6;
  String? tp5so6url;
  int? tp5so7;
  String? tp5so7url;

  int? status;

  DanhGiaSVModel({
    this.id,
    this.idSv,
    this.nguoiDung,
    this.diemThanhPhan1,
    this.diemThanhPhan2,
    this.diemThanhPhan3,
    this.diemThanhPhan4,
    this.diemThanhPhan5,
    this.tp1so1,
    this.tp1so1url,
    this.tp1so2,
    this.tp1so2url,
    this.tp1so3,
    this.tp1so3url,
    this.tp1so4,
    this.tp1so4url,
    this.tp1so5,
    this.tp1so5url,
    this.tp1kl,
    this.tp2so1,
    this.tp2so1url,
    this.tp2so2,
    this.tp2so2url,
    this.tp2so3,
    this.tp2so3url,
    this.tp2so4,
    this.tp2so4url,
    this.tp2so5,
    this.tp2so5url,
    this.tp2so6,
    this.tp2so6url,
    this.tp2kl,
    this.tp3so1,
    this.tp3so1url,
    this.tp3so2,
    this.tp3so2url,
    this.tp3so3,
    this.tp3so3url,
    this.tp4so1,
    this.tp4so1url,
    this.tp4so2,
    this.tp4so2url,
    this.tp5so1,
    this.tp5so1url,
    this.tp5so2,
    this.tp5so2url,
    this.tp5so3,
    this.tp5so3url,
    this.tp5so4,
    this.tp5so4url,
    this.tp5so5,
    this.tp5so5url,
    this.tp5so6,
    this.tp5so6url,
    this.tp5so7,
    this.tp5so7url,
    this.status,
  });

  factory DanhGiaSVModel.fromMap(Map<String, dynamic> json) => DanhGiaSVModel(
        id: json["id"],
        idSv: json["idSv"],
        nguoiDung: UserModel.fromMap(json['nguoiDung'] ?? {}),
        diemThanhPhan1: json['diemThanhPhan1'],
        diemThanhPhan2: json['diemThanhPhan2'],
        diemThanhPhan3: json['diemThanhPhan3'],
        diemThanhPhan4: json['diemThanhPhan4'],
        diemThanhPhan5: json['diemThanhPhan5'],
        tp1so1: json['tp1so1'],
        tp1so1url: json['tp1so1url'],
        tp1so2: json['tp1so2'],
        tp1so2url: json['tp1so2url'],
        tp1so3: json['tp1so3'],
        tp1so3url: json['tp1so3url'],
        tp1so4: json['tp1so4'],
        tp1so4url: json['tp1so4url'],
        tp1so5: json['tp1so5'],
        tp1so5url: json['tp1so5url'],
        tp1kl: json['tp1kl'],
        tp2so1: json['tp2so1'],
        tp2so1url: json['tp2so1url'],
        tp2so2: json['tp2so2'],
        tp2so2url: json['tp2so2url'],
        tp2so3: json['tp2so3'],
        tp2so3url: json['tp2so3url'],
        tp2so4: json['tp2so4'],
        tp2so4url: json['tp2so4url'],
        tp2so5: json['tp2so5'],
        tp2so5url: json['tp2so5url'],
        tp2so6: json['tp2so6'],
        tp2so6url: json['tp2so6url'],
        tp2kl: json['tp2kl'],
        tp3so1: json['tp3so1'],
        tp3so1url: json['tp3so1url'],
        tp3so2: json['tp3so2'],
        tp3so2url: json['tp3so2url'],
        tp3so3: json['tp3so3'],
        tp3so3url: json['tp3so3url'],
        tp4so1url: json['tp4so1url'],
        tp4so2: json['tp4so2'],
        tp4so2url: json['tp4so2url'],
        tp5so1: json['tp5so1'],
        tp5so1url: json['tp5so1url'],
        tp5so2: json['tp5so2'],
        tp5so2url: json['tp5so2url'],
        tp5so3: json['tp5so3'],
        tp5so3url: json['tp5so3url'],
        tp5so4: json['tp5so4'],
        tp5so4url: json['tp5so4url'],
        tp5so5: json['tp5so5'],
        tp5so5url: json['tp5so5url'],
        tp5so6: json['tp5so6'],
        tp5so6url: json['tp5so6url'],
        tp5so7: json['tp5so7'],
        tp5so7url: json['tp5so7url'],
        status: json['status'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'idSv': idSv,
        'diemThanhPhan1': diemThanhPhan1,
        'diemThanhPhan2': diemThanhPhan2,
        'diemThanhPhan3': diemThanhPhan3,
        'diemThanhPhan4': diemThanhPhan4,
        'diemThanhPhan5': diemThanhPhan5,
        'tp1so1': tp1so1,
        'tp1so1url': tp1so1url,
        'tp1so2': tp1so2,
        'tp1so2url': tp1so2url,
        'tp1so3': tp1so3,
        'tp1so3url': tp1so3url,
        'tp1so4': tp1so4,
        'tp1so4url': tp1so4url,
        'tp1so5': tp1so5,
        'tp1so5url': tp1so5url,
        'tp1kl': tp1kl,
        'tp2so1': tp2so1,
        'tp2so1url': tp2so1url,
        'tp2so2': tp2so2,
        'tp2so2url': tp2so2url,
        'tp2so3': tp2so3,
        'tp2so3url': tp2so3url,
        'tp2so4': tp2so4,
        'tp2so4url': tp2so4url,
        'tp2so5': tp2so5,
        'tp2so5url': tp2so5url,
        'tp2so6': tp2so6,
        'tp2so6url': tp2so6url,
        'tp2kl': tp2kl,
        'tp3so1': tp3so1,
        'tp3so1url': tp3so1url,
        'tp3so2': tp3so2,
        'tp3so2url': tp3so2url,
        'tp3so3': tp3so3,
        'tp3so3url': tp3so3url,
        'tp4so1url': tp4so1url,
        'tp4so2': tp4so2,
        'tp4so2url': tp4so2url,
        'tp5so1': tp5so1,
        'tp5so1url': tp5so1url,
        'tp5so2': tp5so2,
        'tp5so2url': tp5so2url,
        'tp5so3': tp5so3,
        'tp5so3url': tp5so3url,
        'tp5so4': tp5so4,
        'tp5so4url': tp5so4url,
        'tp5so5': tp5so5,
        'tp5so5url': tp5so5url,
        'tp5so6': tp5so6,
        'tp5so6url': tp5so6url,
        'tp5so7': tp5so7,
        'tp5so7url': tp5so7url,
        'status': status,
      };
}
