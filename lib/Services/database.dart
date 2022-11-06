// ignore_for_file: avoid_print

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
}
