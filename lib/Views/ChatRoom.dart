// ignore_for_file: unused_import, prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_chat/Services/auth.dart';
import 'package:flutter_chat/Views/SearchScreen.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({Key? key}) : super(key: key);

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  AuthMethods authMethods = new AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                authMethods.signout();
              },
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.grey,
              ))
        ],
        centerTitle: true,
        backgroundColor: Colors.black87,
        // ignore: prefer_const_constructors
        title: Text(
          "Connect",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Container(color: Colors.white),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Search()),
          );
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.search),
      ),
    );
  }
}
