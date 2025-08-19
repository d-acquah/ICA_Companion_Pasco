import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/services/auth.dart';
import 'package:ica_companion_pasco/utils/constants.dart';
import 'package:ica_companion_pasco/utils/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String error = '';
  bool loading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.blue,
              centerTitle: true,
              automaticallyImplyLeading: false,
              elevation: 0.0,
              title: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 40.0, horizontal: 10.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      const Icon(
                        Icons.lock,
                        size: 100,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Create an Account and Pay with Mobile Money',
                        style: TextStyle(
                          color: Color(0xff333333),
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      SizedBox(
                        width: 320,
                        child: TextFormField(
                          controller: emailController,
                          decoration:
                              textInputDecoration.copyWith(hintText: 'Email'),
                          cursorColor: const Color(0xff333333),
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: 320,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(
                              hintText: 'Password'),
                          cursorColor: const Color(0xff333333),
                          autofillHints: const [AutofillHints.newPassword],
                          validator: (val) => val!.length < 6
                              ? 'Enter a password that is 6+ characters long'
                              : null,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(40, 40),
                          textStyle: const TextStyle(fontSize: 14),
                        ),
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() => loading = true);
                            final email = emailController.text.trim();
                            final password = passwordController.text;
                            dynamic result = await _auth
                                .registerWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error = 'Please supply a valid email';
                              });
                            }
                          }
                        },
                      ),
                      const SizedBox(height: 12.0),
                      Text(
                        error,
                        style:
                            const TextStyle(color: Colors.red, fontSize: 14.0),
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Already have an account?',
                            style: TextStyle(color: Color(0xff333333)),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => widget.toggleView(),
                            child: const Text(
                              'Login now',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
