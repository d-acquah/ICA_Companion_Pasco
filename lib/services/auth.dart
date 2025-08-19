import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ica_companion_pasco/models/user.dart';
import 'package:ica_companion_pasco/services/database.dart';

class AuthService {
  final fb_auth.FirebaseAuth _auth = fb_auth.FirebaseAuth.instance;

  // Convert Firebase User to AppUser
  AppUser? _userFromFirebaseUser(fb_auth.User? user) {
    return user != null ? AppUser(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign in with email and password
  Future<AppUser?> signInWithEmailAndPassword(String email, String password) async {
    try {
      fb_auth.UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      fb_auth.User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch (error) {
      print("SignIn error: ${error.toString()}");
      return null;
    }
  }

  // Register with email and password
  Future<AppUser?> registerWithEmailAndPassword(String email, String password) async {
    try {
      fb_auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      fb_auth.User user = result.user!;

      // Save user data in Realtime Database
      await DatabaseService(uid: user.uid).createUserRecord(email);

      return _userFromFirebaseUser(user);
    } catch (error) {
      print("Register error: ${error.toString()}");
      return null;
    }
  }
  Future<fb_auth.UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      
      return null; // or handle as necessary
    } 
  }
}
