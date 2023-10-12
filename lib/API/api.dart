// ignore_for_file: avoid_web_libraries_in_flutter, avoid_print, empty_catches, unused_catch_clause, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

String baseUrl = "http://192.168.0.4:8081";
//lấy về bản ghi
httpGet(url) async {
  Map<String, String> headers = {'content-type': 'application/json'};
  var response = await http.get(Uri.parse('$baseUrl$url'), headers: headers);
  if (response.statusCode == 200 && response.headers["content-type"] == 'application/json') {
    try {
      return {"headers": response.headers, "body": json.decode(utf8.decode(response.bodyBytes))};
    } on FormatException catch (e) {
      print(e);
    }
  } else if (response.statusCode == 403) {
    return false;
  } else {
    return {"headers": response.headers, "body": utf8.decode(response.bodyBytes)};
  }
}

httpPost(url, requestBody) async {
  Map<String, String> headers = {'content-type': 'application/json'};
  var finalRequestBody = json.encode(requestBody);
  var response = await http.post(Uri.parse("$baseUrl$url".toString()), headers: headers, body: finalRequestBody);
  if (response.statusCode == 200 && response.headers["content-type"] == 'application/json') {
    try {
      return {"headers": response.headers, "body": json.decode(utf8.decode(response.bodyBytes))};
    } on FormatException catch (e) {}
  } else if (response.statusCode == 403) {
    return false;
  } else {
    return {"headers": response.headers, "body": utf8.decode(response.bodyBytes)};
  }
}

//xóa bản ghi
httpDelete(url) async {
  Map<String, String> headers = {'content-type': 'application/json'};
  var response = await http.delete(Uri.parse('$baseUrl$url'), headers: headers);
  if (response.statusCode == 200 && response.headers["content-type"] == 'application/json') {
    try {
      return {"headers": response.headers, "body": json.decode(utf8.decode(response.bodyBytes))};
    } on FormatException catch (e) {}
  } else if (response.statusCode == 403) {
    return false;
  } else {
    return {"headers": response.headers, "body": utf8.decode(response.bodyBytes)};
  }
}

//update bản ghi
httpPut(url, requestBody) async {
  Map<String, String> headers = {'content-type': 'application/json'};
  var finalRequestBody = json.encode(requestBody);
  var response = await http.put(Uri.parse('$baseUrl$url'), headers: headers, body: finalRequestBody);
  if (response.statusCode == 200 && response.headers["content-type"] == 'application/json') {
    try {
      return {"headers": response.headers, "body": json.decode(utf8.decode(response.bodyBytes))};
    } on FormatException catch (e) {
      print(e);
      //bypass
    }
  } else if (response.statusCode == 403) {
    return false;
  } else {
    return {"headers": response.headers, "body": utf8.decode(response.bodyBytes)};
  }
}

Future<String?> uploadFile(File file) async {
  try {
    Map<String, String> headers = {'content-type': 'application/json'};
    final request = http.MultipartRequest(
      "POST",
      Uri.parse("$baseUrl/api/upload"),
    );
    request.headers.addAll(headers);
    request.files.add(
      http.MultipartFile(
        'file', // Field name in the form-data
        http.ByteStream(file.openRead()),
        await file.length(),
        filename: 'file.jpg',
      ),
    );
    var response = await request.send();
    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      var body = json.decode(responseBody);
      return body["1"];
    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<void> downloadFile(BuildContext context, String fileName) async {
  try {
    final response = await http.get(Uri.parse("$baseUrl/api/files/$fileName"));

    if (response.statusCode == 200) {
      final documentsDirectory = await getExternalStorageDirectory();
      final filePath = '${documentsDirectory?.path}/$fileName'; // Thay thế 'my_file.pdf' bằng tên tệp mong muốn
      print("filePath: $filePath");
      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã tải file về: $filePath'),
          duration: const Duration(seconds: 3), // Adjust the duration as needed
        ),
      );
    }
  } catch (e) {
    print("error: $e");
  }
}

Future<String?> handleUploadFile() async {
  String? fileName;
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if (result != null) {
    try {
      String path = result.files.first.path ?? "";
      fileName = await uploadFile(File(path));
    } catch (e) {}
  } else {}

  return fileName;
}
