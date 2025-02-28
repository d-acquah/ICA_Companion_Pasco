import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:ica_companion_pasco/pages/login_or_register_page.dart";
import "package:ica_companion_pasco/paystack_home.dart";

class AuthPage extends StatelessWidget {
  const AuthPage({super.key, required Null Function() onTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot) {
          // user logged in
          if (snapshot.hasData) {
            return PayStackPage(title: '', amount: '', email: '', reference: '',);
          }
          // user is not logged in
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
