// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, non_constant_identifier_names, avoid_unnecessary_containers, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/Services/constants.dart';
import 'package:flutter_chat/Services/database.dart';
import 'package:flutter_chat/widgets/widgets.dart';

class ConversationScreen extends StatefulWidget {
  ConversationScreen(this.chatRoomId);
  String chatRoomId;

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController message = new TextEditingController();
  late Stream<QuerySnapshot> chatMessagesStream;
  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: chatMessagesStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                controller: ScrollController(),
                scrollDirection: Axis.vertical,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  return MessageTile(
                      message: ds["message"],
                      // sendBy: Constants.myName = ds["sendBy"],
                      sendByMe: Constants.myName == ds["sendBy"]);
                })
            : Container(
                color: Colors.white,
              );
      },
    );
  }

  sendMessage() {
    if (message.text.isNotEmpty) {
      Map<String, dynamic> messageMap = {
        "message": message.text,
        "sendBy": Constants.myName,
        'time': DateTime.now().millisecondsSinceEpoch,
      };
      databaseMethods.addConversationMessages(widget.chatRoomId, messageMap);
      message.text = "";
    }
  }

  getStream() async {
    await databaseMethods
        .getConversationMessages(widget.chatRoomId.toString())
        .then((value) {
      setState(() {
        chatMessagesStream = value;
      });
    });
  }

  @override
  void initState() {
    getStream();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(
          "Connect",
          style: TextStyle(color: Colors.grey),
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              child: chatMessages(),
              margin: EdgeInsets.only(bottom: 80),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                color: Color(0x54FFFFFF),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: message,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            hintText: "Message ...",
                            hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          sendMessage();
                        },
                        icon: Icon(Icons.message))
                    // GestureDetector(
                    //   onTap: () {
                    //     sendMessage();
                    //     //  initiateSearch();
                    //   },
                    //   child: Container(
                    //       height: 40,
                    //       width: 40,
                    //       decoration: BoxDecoration(
                    //           gradient: LinearGradient(
                    //               // ignore: prefer_const_literals_to_create_immutables
                    //               colors: [
                    //                 const Color(0x36FFFFFF),
                    //                 const Color(0x0FFFFFFF)
                    //               ],
                    //               begin: FractionalOffset.topLeft,
                    //               end: FractionalOffset.bottomRight),
                    //           borderRadius: BorderRadius.circular(40)),
                    //       padding: EdgeInsets.all(12),
                    //       child: Icon(
                    //         Icons.message,
                    //         color: Colors.black,
                    //       )),
                    // )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;
  // final String sendBy;

  MessageTile({required this.message, required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe
                  ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                  : [const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
            )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}
