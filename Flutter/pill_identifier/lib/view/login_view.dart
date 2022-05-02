import 'package:flutter/material.dart';
import 'package:pill_identifier/service/auth/authentication.dart';
import 'package:pill_identifier/service/auth/firebase_auth_provider.dart';
import 'package:pill_identifier/view/detail_fill.dart';
import 'package:provider/provider.dart';

class Login_view extends StatelessWidget {
  Login_view({Key? key}) : super(key: key);

  final Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: const Center(
                  child: Text(
                    'Pill Identifier',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pill Identifier',
      home: Scaffold(
        body: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Image(
                image: AssetImage('assets/codelab.png'),
              ),
            ),
            titleSection,
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
            Consumer<FirebaseAuthProvider>(
              builder: (context, appState, _) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (appState.loginState ==
                      ApplicationLoginState.loggedIn) ...[Profile_fill()],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
