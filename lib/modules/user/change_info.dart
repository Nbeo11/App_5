import 'package:project_dart/API/api.dart';
import 'package:project_dart/common/loading.dart';
import 'package:project_dart/common/toast.dart';
import 'package:project_dart/model/user.model.dart';

import 'package:flutter/material.dart';

class ProfileEditDialog extends StatefulWidget {
  final Function reloadPage; // Thêm callback reloadPage
  final UserModel userModel;
  ProfileEditDialog({required this.reloadPage, required this.userModel, Key? key}) : super(key: key);

  @override
  _ProfileEditDialogState createState() => _ProfileEditDialogState();
}

class _ProfileEditDialogState extends State<ProfileEditDialog> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController birthController = TextEditingController();
  final TextEditingController gTinhController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  UserModel userModel = UserModel();
  Map<String, dynamic> userData = {};
  String username1 = '';
  String password1 = '';
  int role1 = 1;
  String fullName = '';
  String ngaySinh1 = '';
  bool gioiTinh1 = true;
  String email1 = '';
  String address = '';
  String sdt1 = '';
  String avatar1 = '';
  int status1 = 0;

  @override
  void initState() {
    super.initState();
    userModel = widget.userModel;
    fullNameController.text = userModel.fullName ?? "";
    usernameController.text = userModel.username ?? "";
    birthController.text = userModel.ngaySinh ?? "";
    gTinhController.text = (userModel.gioiTinh == false) ? "Nam" : "Nữ";
    emailController.text = userModel.email ?? "";
    phoneController.text = userModel.sdt ?? "";
    addressController.text = userModel.address ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Chỉnh sửa thông tin cá nhân'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Tự động co lại khi bàn phím hiện lên
          children: <Widget>[
            TextFormField(
              controller: fullNameController,
              decoration: InputDecoration(labelText: 'Họ và tên'),
            ),
            TextFormField(
              enabled: false,
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            TextFormField(
              enabled: false,
              controller: birthController,
              decoration: InputDecoration(labelText: 'Ngày sinh'),
            ),
            TextFormField(
              enabled: false,
              controller: gTinhController,
              decoration: InputDecoration(labelText: 'Giới tính'),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Số điện thoại'),
            ),
            TextFormField(
              controller: addressController,
              decoration: InputDecoration(labelText: 'Địa chỉ'),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context); // Đóng dialog khi nhấn nút "Hủy"
            widget.reloadPage(widget.userModel);
          },
          child: Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: () async {
            onLoading(context);
            httpPut("/api/nguoi-dung/put/${userModel.id}", userModel.toMap());
            showToast(
              context: context,
              msg: "Cập nhật thành công",
              color: Color.fromARGB(255, 59, 255, 111),
              icon: const Icon(Icons.done),
            );
            widget.reloadPage(userModel);
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text('Lưu'),
        ),
      ],
    );
  }
}

// Hàm để hiển thị hộp thoại chỉnh sửa thông tin cá nhân
void showProfileEditDialog({required BuildContext context, required Function reloadPage, required UserModel userModel}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return ProfileEditDialog(reloadPage: reloadPage, userModel: userModel); // Truyền callback vào dialog
    },
  );
}
