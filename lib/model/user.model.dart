import 'package:project_dart/model/lop.hoc.model.dart';

class UserModel {
  int? id;
  String? username;
  String? password;
  int? role;
  int? idLh;
  LopHocModel? lopHoc;
  String? fullName;
  String? ngaySinh;
  bool? gioiTinh;
  String? email;
  String? address;
  String? sdt;
  String? avatar;
  int? status;

  UserModel({
    this.id,
    this.username,
    this.password,
    this.role,
    this.idLh,
    this.lopHoc,
    this.fullName,
    this.ngaySinh,
    this.gioiTinh,
    this.email,
    this.address,
    this.sdt,
    this.avatar,
    this.status,
  });

  factory UserModel.fromMap(Map<String, dynamic> json) => UserModel(
        id: json["id"] ?? 0,
        username: json["username"] ?? "",
        password: json["password"] ?? "",
        role: json["role"] ?? 0,
        idLh: json["idLh"] ?? 0,
        lopHoc: LopHocModel.fromMap(json["lopHoc"]??{}),
        fullName: json["fullName"] ?? "",
        ngaySinh: json["ngaySinh"] ?? "",
        gioiTinh: json["gioiTinh"] ?? false,
        email: json["email"] ?? "",
        address: json["address"] ?? "",
        sdt: json["sdt"] ?? "",
        avatar: json["avatar"] ?? "",
        status: json["status"] ?? 1,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "username": username,
        "password": password,
        "role": role,
        "idLh": idLh,
        "fullName": fullName,
        "ngaySinh": ngaySinh,
        "gioiTinh": gioiTinh,
        "email": email,
        "address": address,
        "sdt": sdt,
        "avatar": avatar,
        "status": status,
      };
}
