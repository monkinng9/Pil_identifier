import 'package:flutter/material.dart';
import 'package:pill_identifier/service/auth/authentication.dart';
import 'package:pill_identifier/service/auth/firebase_auth_provider.dart';
import 'package:pill_identifier/view/detail_fill.dart';
import 'package:provider/provider.dart';

class Login_view extends StatelessWidget {
  Login_view({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pill Identifier',
      home: Scaffold(
        body: ListView(
          children: <Widget>[
            Consumer<FirebaseAuthProvider>(
              builder: (context, appState, _) => Authentication(
                email: appState.email,
                loginState: appState.loginState,
                startLoginFlow: appState.startLoginFlow,
                verifyEmail: appState.verifyEmail,
                signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
                cancelRegistration: appState.cancelRegistration,
                registerAccount: appState.registerAccount,
                signOut: appState.signOut,
                googleSignInflow: appState.signInWithGoogle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
