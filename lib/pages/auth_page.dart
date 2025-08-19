import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/pages/login_or_register_page.dart';
import 'package:ica_companion_pasco/paystack_home.dart';
import 'package:ica_companion_pasco/paystack_home_locked.dart';
import 'package:onepref/onepref.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required Null Function() onTap});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  void initState() {
    super.initState();
    validatePremiumFromDatabase();
  }

  Future<void> validatePremiumFromDatabase() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final DatabaseReference ref =
            FirebaseDatabase.instance.ref().child('users/${user.uid}');
        final DataSnapshot snapshot = await ref.get();

        if (snapshot.exists) {
          final data = Map<String, dynamic>.from(snapshot.value as Map);
          final isPremium = data['isPremium'] == true;
          final subscriptionEnd = data['subscriptionEnd'] ?? 0;
          final now = DateTime.now().millisecondsSinceEpoch;

          if (isPremium && now < subscriptionEnd) {
            await OnePref.setPremium(true);
            print("✅ Premium user with valid subscription");
          } else {
            await OnePref.setPremium(false);
            print("⚠️ Subscription expired or user is not premium");
          }
        }
      }
    } catch (e) {
      print('Error checking premium status from database: $e');
      OnePref.setPremium(false);
    }
    setState(() {}); // Rebuild UI
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // if user is logged in, pass their email (if available) to PayStackPage.
          if (snapshot.hasData &&
              snapshot.data != null &&
              OnePref.getPremium() == false) {
            final userEmail = snapshot.data!.email ?? '';
            return PayStackPage(
              title: 'Paystack Payment',
              amount: '10', // Example hardcoded amount; change as needed.
              email: userEmail,
              reference:
                  'initialRef', // Initial reference value; PayStackPage can generate a unique one.
            );
          } else if (snapshot.hasData &&
              snapshot.data != null &&
              OnePref.getPremium() == true) {
            final userEmail = snapshot.data!.email ?? '';    
            return PayStackPageLocked (
              title: 'Paystack Payment',
              amount: '10', // Example hardcoded amount; change as needed.
              email: userEmail,
              reference:
                  'initialRef', // Initial reference value; PayStackPage can generate a unique one.
            );
          }

          // if user is not logged in, show LoginOrRegisterPage.
          else {
            return Authenticate();
          }
        },
      ),
    );
  }
}
