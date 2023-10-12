// ignore_for_file: camel_case_types

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../API/api_config.dart';

Future<int?> getUserId() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('user_id');
}

class Check_RatingState {
  List<Map<String, dynamic>> rates = [];
  int check = 3;
  int id_put = 1;

  Future<void> loadRates() async {
    // Corrected method name
    int? userID = await getUserId();
    final response = await http.get(
      Uri.parse('${ApiConfig.ipAddress}/api/danh-gia/get/page?filter=idSv:${userID ?? 0}'),
    );
    if (response.statusCode == 200) {

      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> rateList = data['result']['content'];
      (rateList.isNotEmpty)? check = 1 : check = 0;
    
    } else {
      throw Exception('Failed to load rates');
    }
  }

  int get getIdPut => id_put;
}
