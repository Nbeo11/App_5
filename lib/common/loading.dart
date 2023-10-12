import 'package:flutter/material.dart';

void onLoading(context) {
  showDialog(
    barrierColor: const Color.fromARGB(34, 158, 158, 158),
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Center(
          child: CircularProgressIndicator(
      ));
    },
  );
}
