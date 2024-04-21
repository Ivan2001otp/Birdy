import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_chat_app/Constants/dart_const.dart';

class FirestoreCloud {
  FirebaseFirestore _cloudFireStore = FirebaseFirestore.instance;

  Future<bool> saveSignedUpUser(
      String name, String email, String password, String uid) async {
    bool isError = false;

    await _cloudFireStore
        .collection(SIGN_UP_USERS_DOCS)
        .doc(uid)
        .set({
          "Uid": uid,
          "Name": name,
          "Email": email,
          "Password": password,
        })
        .whenComplete(() => isError = true)
        .onError((error, stackTrace) {
          print("log-saved while signing In error->$error");
          print("log-saved while signing In stackTrace->$stackTrace");
        });

    return isError;
  }
}
