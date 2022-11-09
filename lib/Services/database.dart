// ignore_for_file: avoid_print

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future<Map<String, dynamic>> searchByName(String searchField) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("User")
        .where('Name', isEqualTo: searchField)
        .get();
    return Future.value(snapshot.docs.first.data());
  }

  Future<Map<String, dynamic>> searchByEmail(String userEmail) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("User")
        .where('Email', isEqualTo: userEmail)
        .get();
    return Future.value(snapshot.docs.first.data());
  }

  // getUserByUserEmail(String userEmail) async {
  //   return await FirebaseFirestore.instance
  //       .collection("users")
  //       .where("email", isEqualTo: userEmail)
  //       .get();
  // }

  uploadUserInfo(usermap) {
    FirebaseFirestore.instance.collection("User").add(usermap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    FirebaseFirestore.instance
        .collection("ConvScreen")
        .doc(chatRoomId)
        .set(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    FirebaseFirestore.instance
        .collection("ConvScreen")
        .doc(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }
    getConversationMessages(String chatRoomId) async{
    return await FirebaseFirestore.instance
        .collection("ConvScreen")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }
 getChatRooms(String userName) async{
    return await FirebaseFirestore.instance
        .collection("ConvScreen").where("users", arrayContains: userName).snapshots();
        
  }
  // getConversationMessages(String chatRoomId) {
  //   FirebaseFirestore.instance
  //       .collection("ConvScreen")
  //       .doc(chatRoomId)
  //       .collection("chats")
  //       .snapshots();
  // }
  //  Future<Map<String, dynamic>> getConversationMessages(String chatRoomId) async {
  //   QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
  //       .instance
  //       .collection("ConvScreen")
  //       .doc(chatRoomId)
  //       .collection("chats")
  //       .get();
  //   return Future.value(snapshot.docs.first.data());
  // }
}
