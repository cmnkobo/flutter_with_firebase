// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vandad_course/utilities/show_error_dialog.dart';
import 'dart:developer' as devtools show log;

import 'package:vandad_course/views/constants/routes.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
          title: const Text('Login'),
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
              // Register

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

                    Future<void> signIn() async {
                      try {
                        final userCredential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        devtools.log(userCredential.toString());
                        final user = FirebaseAuth.instance.currentUser;

                        if (user?.emailVerified ?? false) {
                          //returning false shows email is verified, then go to loggined screen
                          Navigator.pushNamedAndRemoveUntil(
                            localContext,
                            loggedinhomeRoute,
                            (route) => false,
                          );
                        } else {
                          //returns the user to verifyemail screen
                          Navigator.pushNamedAndRemoveUntil(
                            localContext,
                            verifyEmailRoute,
                            (route) => false,
                          );
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          await showErrorDialog(localContext, 'User not found');
                        } else if (e.code == 'wrong-password') {
                          devtools.log('wrong password');
                        } else {
                          await showErrorDialog(context, 'Error: ${e.code}');
                        }
                      } catch (e) {
                        await showErrorDialog(context, e.toString());
                      }
                    }

                    signIn();
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      wordSpacing: 1.2,
                      fontWeight: FontWeight.w400,
                      height: 1.2,
                    ),
                  ),
                ),
              ),

              // Container(
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(7),
              //     color: Colors.blue,
              //   ),
              //   child: Builder(
              //     builder: (context) => TextButton(
              //       onPressed: () async {
              //         final email = _emailController.text;
              //         final password = _passwordController.text;

              //         try {
              //           final userCredential = await FirebaseAuth.instance
              //               .signInWithEmailAndPassword(
              //             email: email,
              //             password: password,
              //           );
              //           devtools.log(userCredential.toString());

              //           Navigator.pushNamedAndRemoveUntil(
              //               context, loggedinhomeRoute, (route) => false);
              //         } on FirebaseAuthException catch (e) {
              //           if (e.code == 'user-not-found') {
              //             await showErrorDialog(context, 'User not found');
              //             devtools.log('User not found');
              //           } else if (e.code == 'wrong-password') {
              //             await showErrorDialog(context, 'Wrong passord');
              //             devtools.log('wrong password');
              //           }
              //         }
              //       },
              //       child: const Text(
              //         'Login',
              //         style: TextStyle(
              //           fontSize: 20,
              //           wordSpacing: 1.2,
              //           fontWeight: FontWeight.w400,
              //           height: 1.2,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, registerRoute, (route) => false);
                  },
                  child: const Text(
                    'Not registered yet?? Register here!',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ))
            ],
          ),
        ));
  }
}
