import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection("users")
        .where('userName', isEqualTo: searchField)
        .get();
  }

  uploadUserInfo(usermap) {
    FirebaseFirestore.instance.collection("User").add(usermap);
  }
}
