// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        // ignore: prefer_const_constructors
        title: Text(
          "Connect",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                Expanded(
                    child: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Enter the username..",
                      hintStyle: TextStyle(color: Colors.white)),
                )),
                Icon(
                  Icons.search,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
