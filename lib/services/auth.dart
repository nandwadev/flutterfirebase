import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasesample/models/user_details.dart';
import 'package:firebasesample/services/firestore.dart';

class AuthenticationService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestoreCloud firebaseFirestoreCloud = FirebaseFirestoreCloud();
  Future<String> registerAccount({
    required String firstName,
    required String lastName,
    required String phone,
    required String email,
    required String password,
  }) async {
    firstName.trim();
    lastName.trim();
    phone.trim();
    email.trim();
    password.trim();
    String output = "something went wrong";
    if (firstName != "" &&
        lastName != "" &&
        phone != "" &&
        email != "" &&
        password != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        UserDetails user = UserDetails(
          firstName: firstName,
          lastName: lastName,
          phone: phone,
          email: email,
        );
        await firebaseFirestoreCloud.userDetails(
          user: user
        );
        output = "success";
      } on FirebaseException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "please check your details and try again";
    }
    return output;
  }

  Future<String> logonAccount({
    required String email,
    required String password,
  }) async {
    email.trim();
    password.trim();
    String output = "something went wrong";
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        output = "success";
      } on FirebaseException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "please check your details and try again";
    }
    return output;
  }
}
