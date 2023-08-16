import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

//sort length
void showMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    backgroundColor: Colors.blue,
    textColor: Colors.white,
    fontSize: 16.0,
    timeInSecForIosWeb: 1,
    toastLength: Toast.LENGTH_LONG,
  );
}
