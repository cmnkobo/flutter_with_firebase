import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vandad_course/utilities/show_error_dialog.dart';
import 'dart:developer' as devtools show log;
import 'package:vandad_course/views/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _emailController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          backgroundColor: Colors.blue,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              color: Colors.grey.withOpacity(.4),
              height: 2.0,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              //Username Textfeild
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Enter your email',
                  hintText: 'Your email',
                  prefixIcon: const Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(1),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              //Password Textfield
              TextField(
                controller: _passwordController,
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  labelText: 'Enter your Password',
                  hintText: 'Your password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(7),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black.withOpacity(1),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              // Register Button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.blue,
                ),
                child: TextButton(
                  onPressed: () {
                    final email = _emailController.text;
                    final password = _passwordController.text;
                    var localContext = context;
                    Future<void> register() async {
                      try {
                        final userCredentail = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        final user = FirebaseAuth.instance.currentUser;
                        await user?.sendEmailVerification();

                        Navigator.pushNamed(context, verifyEmailRoute);

                        devtools.log('$userCredentail');
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'Weak-password') {
                          await showErrorDialog(localContext, 'Weak Password');
                          devtools.log("Weak password");
                        } else if (e.code == 'email-already-in-use') {
                          devtools.log('Email already in use ');
                        } else if (e.code == "invalid-email") {
                          devtools.log('Invalid email');
                        } else {
                          devtools.log(e.toString());
                        }
                      }
                    }

                    register();
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 1.2,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, loginRoute, (route) => false);
                  },
                  child: const Text(
                    'Already registered?? Login here!',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ))
            ],
          ),
        ));
  }
}
