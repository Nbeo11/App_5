import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class View_by_Semester extends StatefulWidget {
@override
_View_by_SemesterState createState() => _View_by_SemesterState();
}

class _View_by_SemesterState extends State<View_by_Semester> {
  List<dynamic> jsonData = [];

  @override
  void initState() {
    super.initState();
    fetchDataFromApi();
  }

  Future<void> fetchDataFromApi() async {
    try {
      final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos')); // Thay URL API của bạn vào đây

      if (response.statusCode == 200) {
        setState(() {
          jsonData = json.decode(response.body);
        });
      } else {
        throw Exception('Failed to load data from API');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: jsonData.isEmpty
          ? Center(child: CircularProgressIndicator()) // Hiển thị tiêu đề khi đang tải dữ liệu
          : SingleChildScrollView(
        scrollDirection: Axis.horizontal, // Cho phép cuộn ngang nếu cần
        child: DataTable(
          columnSpacing: 5.0,
          columns: [
            DataColumn(label: Text('ID')),
            DataColumn(label: Text('Tên')),
            DataColumn(label: Text('Hoàn thành')),
          ],
          rows: jsonData.map((item) {
            return DataRow(
              cells: [
                DataCell(Text(item['id'].toString())),
                DataCell(Text(item['title'])),
                DataCell(Text(item['completed'].toString())),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
