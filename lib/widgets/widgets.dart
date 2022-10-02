// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget appbarmain(BuildContext context) {
  return AppBar(
    centerTitle: true,
    backgroundColor: Colors.black87,
    title: Text(
      "Connect",
      style: TextStyle(color: Colors.grey),
    ),
  );
}

InputDecoration inputtextfield(String hinttext) {
  return InputDecoration(
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
    hintText: hinttext,
    hintStyle: TextStyle(),
  );
}
