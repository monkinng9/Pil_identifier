import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill_identifier/models/user_snap.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .withConverter(
          fromFirestore: User_snap.fromFirestore,
          toFirestore: (User_snap userDetail, _) => userDetail.toFirestore(),
        );
    // Navigator.pushNamed(context, '/second');
    print(ref);

    return MaterialApp();
  }
}
