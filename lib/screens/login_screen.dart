import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'home_screen.dart';
import '../models/user_model.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      providers: [
        EmailAuthProvider(),
        GoogleProvider(
            clientId:
                "578848477881-m9q4qt079qqanhlvickas9skgvmiqnnr.apps.googleusercontent.com"), // Remplacez par votre client ID
      ],
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          final firebaseUser = firebase_auth.FirebaseAuth.instance.currentUser;
          if (firebaseUser != null) {
            final user = User.fromFirebaseUser(firebaseUser);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
            );
          }
        }),
      ],
    );
  }
}
