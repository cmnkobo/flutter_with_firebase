import 'package:flutter/material.dart';
import 'package:vandad_course/services/auth/auth_service.dart';
import 'package:vandad_course/views/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify email'),
        backgroundColor: Colors.blue,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: Colors.blue.withOpacity(.6),
              height: 5,
            )),
      ),
      body: Column(children: [
        const Text(
            'Email verification link sent, please check your registered email and verify'),
        const Text(
            'If you have not received a verification mail, click on the button below'),
        TextButton(
          onPressed: () async {
            await AuthService.firebase().sendEmailVerification();
          },
          child: const Text('Send email verification code'),
        ),
        TextButton(
          onPressed: () async {
            await AuthService.firebase().logOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil(registerRoute, (route) => false);
          },
          child: const Text('Restart'),
        ),
      ]),
    );
  }
}
