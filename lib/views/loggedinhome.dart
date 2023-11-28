import 'package:flutter/material.dart';
import 'package:vandad_course/enums/menu_action.dart';
import 'package:vandad_course/services/auth/auth_service.dart';
import 'dart:developer' as devtools show log;

import 'package:vandad_course/views/constants/routes.dart';

class LoggedInHome extends StatefulWidget {
  const LoggedInHome({super.key});

  @override
  State<LoggedInHome> createState() => _LoggedInHomeState();
}

class _LoggedInHomeState extends State<LoggedInHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //places a pop up on the appbar of the logged in screen for user to logout
      appBar: AppBar(
        title: const Text('Main UI'),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLoggedOutDialog(context);
                  devtools.log(shouldLogout.toString());
                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamedAndRemoveUntil(
                        context, loginRoute, (route) => false);
                  }
              }
            },
            color: Colors.blue[100],
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log out'),
                )
              ];
            },
          )
        ],
      ),
      body: Column(
        children: [
          const Text('This is where the app UI will be coded'),
          TextButton(
              onPressed: () async {
                await AuthService.firebase().logOut();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text('Signout'))
        ],
      ),
    );
  }
}

//Display dialog box to the user to logout
Future<bool> showLoggedOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text("Log out"),
            )
          ],
        );
      }).then((value) => value ?? false);
}
