import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
 Future<QuerySnapshot<Object?>> getUserbyUsername(String username) async{
   return await FirebaseFirestore.instance
        .collection("User")
        .where("name", isEqualTo: username)
        .get();
  }

  uploadUserInfo(usermap) {
    FirebaseFirestore.instance.collection("User").add(usermap);
  }
}
