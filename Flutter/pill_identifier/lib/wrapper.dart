import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill_identifier/models/user_model.dart';
import 'package:pill_identifier/models/user_snap.dart';
import 'package:pill_identifier/service/auth/auth_service.dart';
import 'package:pill_identifier/view/detail_fill.dart';
import 'package:pill_identifier/view/login_screen.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<UserLogin?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<UserLogin?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final Widget screen;
          final UserLogin? userLogin = snapshot.data;
          if (userLogin == null) {
            screen = const LoginScreen();
          } else {
            screen = ProfileFill();
          }
          return screen;
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
