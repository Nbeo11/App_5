import 'user.model.dart';

class DanhGiaCBLModel {
  int? id;
  int? idSv;
  UserModel? nguoiDung;
  //phan1
  int? diemThanhPhan1;
  int? tp1so1;
  int? tp1so2;
  int? tp1so3;
  int? tp1so4;

  int? tp1so5;

  //0:la ko ky luat    1: dinh chi       2: canh cao        3: Khien trach
  int? tp1kl;

  //phan2
  int? diemThanhPhan2;
  int? tp2so1;

  int? tp2so2;

  int? tp2so3;

  int? tp2so4;

  int? tp2so5;

  int? tp2so6;

  //0:la ko ky luat    1: canh cao        2: Khien trach        3: Phe binh
  int? tp2kl;

  //pahn3
  int? diemThanhPhan3;
  int? tp3so1;

  int? tp3so2;

  int? tp3so3;

  //pahn4
  int? diemThanhPhan4;
  int? tp4so1;

  int? tp4so2;

  //pahn5
  int? diemThanhPhan5;
  int? tp5so1;

  int? tp5so2;

  int? tp5so3;

  int? tp5so4;

  int? tp5so5;

  int? tp5so6;

  int? tp5so7;

  int? status;

  DanhGiaCBLModel({
    this.id,
    this.idSv,
    this.nguoiDung,
    this.diemThanhPhan1,
    this.diemThanhPhan2,
    this.diemThanhPhan3,
    this.diemThanhPhan4,
    this.diemThanhPhan5,
    this.tp1so1,
    this.tp1so2,
    this.tp1so3,
    this.tp1so4,
    this.tp1so5,
    this.tp1kl,
    this.tp2so1,
    this.tp2so2,
    this.tp2so3,
    this.tp2so4,
    this.tp2so5,
    this.tp2so6,
    this.tp2kl,
    this.tp3so1,
    this.tp3so2,
    this.tp3so3,
    this.tp4so1,
    this.tp4so2,
    this.tp5so1,
    this.tp5so2,
    this.tp5so3,
    this.tp5so4,
    this.tp5so5,
    this.tp5so6,
    this.tp5so7,
    this.status,
  });

  factory DanhGiaCBLModel.fromMap(Map<String, dynamic> json) => DanhGiaCBLModel(
        id: json["id"],
        idSv: json["idSv"],
        nguoiDung: UserModel.fromMap(json['nguoiDung']),
        diemThanhPhan1: json['diemThanhPhan1'],
        diemThanhPhan2: json['diemThanhPhan2'],
        diemThanhPhan3: json['diemThanhPhan3'],
        diemThanhPhan4: json['diemThanhPhan4'],
        diemThanhPhan5: json['diemThanhPhan5'],
        tp1so1: json['tp1so1'],
        tp1so2: json['tp1so2'],
        tp1so3: json['tp1so3'],
        tp1so4: json['tp1so4'],
        tp1so5: json['tp1so5'],
        tp1kl: json['tp1kl'],
        tp2so1: json['tp2so1'],
        tp2so2: json['tp2so2'],
        tp2so3: json['tp2so3'],
        tp2so4: json['tp2so4'],
        tp2so5: json['tp2so5'],
        tp2so6: json['tp2so6'],
        tp2kl: json['tp2kl'],
        tp3so1: json['tp3so1'],
        tp3so2: json['tp3so2'],
        tp3so3: json['tp3so3'],
        tp4so2: json['tp4so2'],
        tp5so1: json['tp5so1'],
        tp5so2: json['tp5so2'],
        tp5so3: json['tp5so3'],
        tp5so4: json['tp5so4'],
        tp5so5: json['tp5so5'],
        tp5so6: json['tp5so6'],
        tp5so7: json['tp5so7'],
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
        'tp1so2': tp1so2,
        'tp1so3': tp1so3,
        'tp1so4': tp1so4,
        'tp1so5': tp1so5,
        'tp1kl': tp1kl,
        'tp2so1': tp2so1,
        'tp2so2': tp2so2,
        'tp2so3': tp2so3,
        'tp2so4': tp2so4,
        'tp2so5': tp2so5,
        'tp2so6': tp2so6,
        'tp2kl': tp2kl,
        'tp3so1': tp3so1,
        'tp3so2': tp3so2,
        'tp3so3': tp3so3,
        'tp4so2': tp4so2,
        'tp5so1': tp5so1,
        'tp5so2': tp5so2,
        'tp5so3': tp5so3,
        'tp5so4': tp5so4,
        'tp5so5': tp5so5,
        'tp5so6': tp5so6,
        'tp5so7': tp5so7,
        'status': status,
      };
}
