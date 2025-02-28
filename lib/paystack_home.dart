import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/payment_page.dart';

class PayStackPage extends StatefulWidget {
  const PayStackPage({super.key, required String title, required String amount, required String email, required String reference});

  @override
  State<PayStackPage> createState() => _PayStackPageState();
}

class _PayStackPageState extends State<PayStackPage> {
  final _formKey = GlobalKey<FormState>();
  final referenceController = TextEditingController();
  final emailController = TextEditingController();

  // Fixed amount: GHS 10
  final String fixedAmount = '10';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mobile Money Payment'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Fixed amount display styled like a TextField
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Amount',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'GHS $fixedAmount',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: referenceController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Required field missing';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Reference',
                  hintText: 'Enter the reference',
                  border: OutlineInputBorder(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: TextFormField(
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Required field missing';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    hintText: 'A receipt will be sent to this email',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PaymentPage(
                            amount: fixedAmount,
                            email: emailController.text,
                            reference: referenceController.text,
                            title: '', // Title passed, even though not used.
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      'Proceed to make payment',
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
