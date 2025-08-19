import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            '''

Your privacy is important to us. We developed ICA Companion: Pasco app as a free app. We do not collect any type of personal information from this application. This application only provides information to its user and do not collect any information from them.

However, If you contact us directly, we may receive information about you such as your name, email address, phone number, the contents of the message and/or attachments you may send us, and any other information you may choose to provide.

This application displays relevant adverts to it user through Admob. Note that we have no access to or control over any information that may be collected thereof.

By using our app, you consent to our privacy policy.
            ''',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
