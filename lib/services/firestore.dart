import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesample/models/user_details.dart';

class FirebaseFirestoreCloud {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future userDetails({required UserDetails user}) async {
    await firebaseFirestore
        .collection("users")
        .doc(
          firebaseAuth.currentUser!.uid,
        )
        .set(
          user.getJson(),
        );
  }
}
