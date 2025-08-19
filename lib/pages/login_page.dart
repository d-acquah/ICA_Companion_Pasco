import 'package:flutter/material.dart';
import 'package:ica_companion_pasco/pages/reset_password.dart';
import 'package:ica_companion_pasco/services/auth.dart';
import 'package:ica_companion_pasco/utils/constants.dart';
import 'package:ica_companion_pasco/utils/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  const SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
                "Sign In",
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
                      const SizedBox(height: 20),
                      const Icon(
                        Icons.lock,
                        size: 100,
                        color: Colors.blue,
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Sign in to Pay with Mobile Money',
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
                          decoration: textInputDecoration.copyWith(hintText: 'Email'),
                          cursorColor: const Color(0xff333333),
                          validator: (val) =>
                              val!.isEmpty ? 'Enter an email' : null,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: const [AutofillHints.email],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: 320,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: textInputDecoration.copyWith(hintText: 'Password'),
                          cursorColor: const Color(0xff333333),
                          validator: (val) => val!.length < 6
                              ? 'Enter a password that is 6+ characters long'
                              : null,
                          autofillHints: const [AutofillHints.password],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ResetPasswordPage(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Reset Password',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
                          'Sign In',
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
                                .signInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                error =
                                    'Could not sign in with those credentials';
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
                            'Not registered?',
                            style: TextStyle(color: Color(0xff333333)),
                          ),
                          const SizedBox(width: 4),
                          GestureDetector(
                            onTap: () => widget.toggleView(),
                            child: const Text(
                              'Register now',
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
