// ignore_for_file: unused_import, prefer_const_constructors, duplicate_ignore, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/Services/auth.dart';
import 'package:flutter_chat/Services/authenticator.dart';
import 'package:flutter_chat/Services/constants.dart';
import 'package:flutter_chat/Services/database.dart';
import 'package:flutter_chat/Services/helperfunctions.dart';
import 'package:flutter_chat/Views/ConversationScreen.dart';
import 'package:flutter_chat/Views/SearchScreen.dart';

class Chatroom extends StatefulWidget {
  const Chatroom({Key? key}) : super(key: key);

  @override
  State<Chatroom> createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  late Stream<QuerySnapshot> chatRoomStream;
  Widget chatRooms() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatRoomStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return ChatRoomTile(
                      ds["chatroomId"]
                          .toString()
                          .replaceAll("_", "")
                          .replaceAll(Constants.myName, ""),
                      ds["chatroomId"]);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.black26,
                  );
                },
              )
            : Container(
                color: Colors.white,
              );
      },
    );
  }

  @override
  void initState() {
    getUserInfo();
    // getChatRooms();
    // TODO: implement initState
    super.initState();
  }

  getChatRooms() async {
    await databaseMethods.getChatRooms(Constants.myName).then((val) {
      setState(() {
        chatRoomStream = val;
      });
    });
  }

  getUserInfo() async {
    Constants.myName = (await HelperFunctions.getUserNameSharedPreference())!;
    await databaseMethods.getChatRooms(Constants.myName).then((val) {
      setState(() {
        chatRoomStream = val;
      });
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                AuthMethods().signout();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Authenticate()));
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
      body: chatRooms(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Search()),
          );
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.search),
      ),
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoom;
  ChatRoomTile(this.userName, this.chatRoom);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConversationScreen(chatRoom)));
      },
      child: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(40)),
              child: Text(
                "${userName.substring(0, 1).toUpperCase()}",
                style: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              userName,
              style: TextStyle(fontSize: 17),
            )
          ],
        ),
      ),
    );
  }
}
