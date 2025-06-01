import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'payment_page.dart';

class PayStackPage extends StatefulWidget {
  final String title;
  final String amount;
  final String email;
  final String reference;

  const PayStackPage({
    Key? key,
    required this.title,
    required this.amount,
    required this.email,
    required this.reference,
  }) : super(key: key);

  @override
  State<PayStackPage> createState() => _PayStackPageState();
}

class _PayStackPageState extends State<PayStackPage> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  bool isEmailFocused = false;

  @override
  void initState() {
    super.initState();
    emailController.text = widget.email;
    emailFocusNode.addListener(() {
      setState(() {
        isEmailFocused = emailFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    emailFocusNode.dispose();
    super.dispose();
  }

  String generateReference() {
    return 'ref${DateTime.now().millisecondsSinceEpoch}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Money'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.amount,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'GHS',
                  labelStyle: const TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: emailController,
                focusNode: emailFocusNode,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: const TextStyle(color: Colors.blue),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                style: const TextStyle(fontSize: 16, color: Colors.black),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Email is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: SizedBox(
                  width: 265,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(100, 50),
                      textStyle: const TextStyle(fontSize: 14),
                    ),
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      final uniqueReference = generateReference();
                      final currentUser = FirebaseAuth.instance.currentUser;
                      final uid = currentUser?.uid ?? 'anonymous'; // ✅ UID

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            email: emailController.text.trim(),
                            reference: uniqueReference,
                            title: widget.title,
                            uid: uid, // ✅ passed here
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Proceed to Payment",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
