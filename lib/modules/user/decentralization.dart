import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../API/api_config.dart';

Future<void> login(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://192.168.0.5:8081/api/nguoi-dung/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    // Đăng nhập thành công, lưu token và xử lý phân quyền ở đây.
    final token = jsonDecode(response.body)['token'];
    // Lưu token vào cơ sở dữ liệu hoặc SharedPreferences.
  } else {
    // Xử lý lỗi đăng nhập ở đây.
    throw Exception('Failed to login');
  }
}
