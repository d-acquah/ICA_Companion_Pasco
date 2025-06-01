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
          // if user is logged in, pass their email (if available) to PayStackPage.
          if (snapshot.hasData && snapshot.data != null) {
            final userEmail = snapshot.data!.email ?? '';
            return PayStackPage(
              title: 'Paystack Payment',
              amount: '10',              // Example hardcoded amount; change as needed.
              email: userEmail,
              reference: 'initialRef',   // Initial reference value; PayStackPage can generate a unique one.
            );
          } 
          // if user is not logged in, show LoginOrRegisterPage.
          else {
            return LoginOrRegisterPage();
          }
        },
      ),
    );
  }
}
