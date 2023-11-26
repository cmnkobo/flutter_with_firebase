import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vandad_course/firebase_options.dart';
import 'package:vandad_course/views/constants/routes.dart';
import 'package:vandad_course/views/loggedinhome.dart';
import 'package:vandad_course/views/login_view.dart';
import 'package:vandad_course/views/register_view.dart';
import 'package:vandad_course/views/verifyemail_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Chrisvad());
}

class Chrisvad extends StatelessWidget {
  const Chrisvad({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chrisvandad App',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Colors.black,
          onPrimary: Colors.white,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Homepage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        loggedinhomeRoute: (context) => const LoggedInHome(),
      },
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const LoggedInHome();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }
            default:
              return const CircularProgressIndicator();
          }
        });
  }
}
