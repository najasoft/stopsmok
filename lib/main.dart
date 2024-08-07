import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stopsmok/screens/home_screen.dart';
import 'package:stopsmok/screens/login_screen.dart';
import 'package:stopsmok/services/user_service.dart';
import 'package:stopsmok/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stop Smoke',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserService _userService = UserService();
  final firebase_auth.FirebaseAuth _auth = firebase_auth.FirebaseAuth.instance;

  Future<void> _login() async {
    try {
      // Logique d'authentification Firebase
      firebase_auth.UserCredential userCredential =
          await _auth.signInAnonymously();
      firebase_auth.User? firebaseUser = userCredential.user;

      if (firebaseUser != null) {
        // Créer un objet User à partir de firebaseUser
        User user = User(
          id: firebaseUser.uid,
          email: firebaseUser.email ?? '',
          displayName: firebaseUser.displayName ?? 'Anonymous',
        );

        // Enregistrer l'utilisateur dans Firestore
        await _userService.createUser(user);

        // Naviguer vers l'écran d'accueil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
        );
      }
    } catch (e) {
      print('Erreur de connexion : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _login,
          child: Text('Login with Firebase'),
        ),
      ),
    );
  }
}
