import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill_identifier/common/widgets.dart';

// [#detail_screen] this class be alike HomePage
/// that import Notifier class from outside (that class be alike ApplicationState)


class Profile_fill extends StatefulWidget {
  var email = FirebaseAuth.instance.currentUser!.email;

  @override
  State<Profile_fill> createState() => _Profile_fillState();
}

class _Profile_fillState extends State<Profile_fill> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Header('Sign in with ${widget.email}'),
      ],
    );
  }
}
