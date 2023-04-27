import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebasesample/screens/signin.dart';
import 'package:firebasesample/utils/color_themes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBZnOHDTaIHIHkpsgKA5G4lp_CNWo6x79Q",
        authDomain: "fir-sample-872f6.firebaseapp.com",
        projectId: "fir-sample-872f6",
        storageBucket: "fir-sample-872f6.appspot.com",
        messagingSenderId: "815638803631",
        appId: "1:815638803631:web:790a83c10e41e8a465d05a",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const FirebaseSample());
}

class FirebaseSample extends StatelessWidget {
  const FirebaseSample({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData.light().copyWith(scaffoldBackgroundColor: backgroundColor),
      //persistent login
      //streambuilder- widget that constantly listens to data and rebuilds
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> user){
          if(user.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.brown,
              ),
            );
          }else if(user.hasData){
            //FirebaseAuth.instance.signOut();
            return ElevatedButton(onPressed: (){
              FirebaseAuth.instance.signOut();
            }, child: Text("sign out"));
          }else{
            return const SignInScreen();
          }
        },
      ),
    );
  }
}
