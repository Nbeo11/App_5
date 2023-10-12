import 'package:flutter/foundation.dart';

class UserData extends ChangeNotifier {
  int? userId; // Sử dụng kiểu int cho userId

  void setUserId(int id) { // Sửa kiểu tham số thành int
    userId = id;
    notifyListeners();
  }
}
