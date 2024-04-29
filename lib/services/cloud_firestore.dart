import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:user_chat_app/Constants/dart_const.dart';
import '../Models/UserInfo.dart' as Us;

class FirestoreCloud {
  FirebaseFirestore _cloudFireStore = FirebaseFirestore.instance;

  void logOutUser() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<bool> saveLoggedInorSignedInUser(Us.UserInfo user) async {
    bool isSuccess = false;
    await _cloudFireStore
        .collection(SIGNED_USERS)
        .doc(user.uniqueId)
        .set(user.toJson())
        .whenComplete(() => isSuccess = true)
        .onError((error, stackTrace) => isSuccess = false);

    return isSuccess;
  }

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

  Future<List<Us.UserInfo>> fetchAllFriends() async {
    bool isSuccess = false;
    List<Us.UserInfo> response = List.empty(growable: true);

    CollectionReference reference =
        _cloudFireStore.collection(SIGN_UP_USERS_DOCS);

    QuerySnapshot querySnapshot = await reference.get();

    querySnapshot.docs.forEach((item) {
      Map<String, dynamic>? mp = item.data() as Map<String, dynamic>?;

      if (mp != null) {
        debugPrint('${mp['Name']}');
        debugPrint(mp['Email']);
        debugPrint(mp['Uid']);
      }

      Us.UserInfo user = Us.UserInfo.fromJson(mp);
      response.add(user);
    });

    return response;
  }
}
