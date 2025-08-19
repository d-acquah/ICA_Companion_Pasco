import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  final String uid;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.reference();

  DatabaseService({required this.uid});

  Future<void> createUserRecord(String email) async {
    final userRef = _dbRef.child('users').child(uid);

    await userRef.set({
      'email': email,
      'createdAt': ServerValue.timestamp,
      'subscriptionStart': null,
      'subscriptionEnd': null,
      'isPremium': false,
    });
  }

  Future<void> upgradeToPremium() async {
    final userRef = _dbRef.child('users').child(uid);

    final now = DateTime.now();
    final end = now.add(Duration(minutes: 5));

    await userRef.update({
      'subscriptionStart': now.millisecondsSinceEpoch,
      'subscriptionEnd': end.millisecondsSinceEpoch,
      'isPremium': true,
    });
  }
}
