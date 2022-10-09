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

  uploadUserInfo(usermap) {
    FirebaseFirestore.instance.collection("User").add(usermap);
  }
}
