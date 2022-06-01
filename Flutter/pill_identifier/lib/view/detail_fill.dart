import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill_identifier/models/user_snap.dart';
import 'package:pill_identifier/service/auth/auth_service.dart';
import 'package:pill_identifier/widgets/widgets.dart';
import 'package:provider/provider.dart';

// [#detail_screen] Detail Check
/// - Email TextField
/// - DisplayName TextField
/// - Gender
/// - Birthday
///   - Date Picker

enum GenderCharacter { men, women }

class ProfileFill extends StatefulWidget {
  ProfileFill({
    Key? key,
  }) : super(key: key);
  final String? email = FirebaseAuth.instance.currentUser!.email;
  User user = FirebaseAuth.instance.currentUser!;
  @override
  State<ProfileFill> createState() => _ProfileFillState();
}

class _ProfileFillState extends State<ProfileFill> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _displayNameController = TextEditingController();

  GenderCharacter? _genderCharacter = GenderCharacter.men;

  DateTime selectedDate = DateTime.now();
  final firstDate = DateTime(1900, 1);
  final lastDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.email!;
  }

  Future<bool> getData() async {
    final user = widget.user;
    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .withConverter(
          fromFirestore: User_snap.fromFirestore,
          toFirestore: (User_snap userDetail, _) => userDetail.toFirestore(),
        );
    final docSnap = await ref.get();
    final userDetail = docSnap.data();
    if (userDetail != null) {
      final userApporved = userDetail.approved;
      return userApporved!;
    } else {
      const userApporved = false;
      return userApporved;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    Future<bool?> _showWarning(BuildContext context) async => showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Do you want to avoid filling in the blanks? '),
            actions: [
              ElevatedButton(
                child: const Text('No'),
                onPressed: () => Navigator.pop(context, false),
              ),
              ElevatedButton(
                child: const Text('Yes'),
                onPressed: () {
                  // ใช้ true จะทำให้ออกจากหน้านั้นด้วย
                  Navigator.pop(context, false);
                  authService.signOut();
                },
              ),
            ],
          ),
        );

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showWarning(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        body: Center(
          child: FutureBuilder(
            future: getData(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              List<Widget> children;
              final isApproved = snapshot.data;
              if (snapshot.data == true) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushNamed(context, '/navigator'); // Your Code Here
                });
                children = <Widget>[
                  const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Result: ${isApproved}'),
                  )
                ];
              } else {
                children = <Widget>[
                  ElevatedButton(
                    onPressed: () {
                      authService.signOut();
                    },
                    child: const Text('Go back'),
                  ),
                  const Text("Welcome to Pill Identifier"),
                  TextFormField(
                    controller: _emailController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Email@gmail.com',
                      labelText: 'Email *',
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? null
                          : 'Required';
                    },
                  ),
                  TextFormField(
                    controller: _displayNameController,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'FirstName LastName',
                      labelText: 'Name *',
                    ),
                    validator: (String? value) {
                      return (value != null && value.contains('@'))
                          ? 'Do not use the @ char.'
                          : 'Required';
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Header("Gender"),
                  ),
                  ListTile(
                    title: const Text('Men'),
                    leading: Radio<GenderCharacter>(
                      value: GenderCharacter.men,
                      groupValue: _genderCharacter,
                      onChanged: (GenderCharacter? value) {
                        setState(() {
                          _genderCharacter = value;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Women'),
                    leading: Radio<GenderCharacter>(
                      value: GenderCharacter.women,
                      groupValue: _genderCharacter,
                      onChanged: (GenderCharacter? value) {
                        setState(() {
                          _genderCharacter = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Header("Birthday"),
                  Text(
                    '$selectedDate'.split(' ')[0],
                    style: const TextStyle(fontSize: 18),
                  ),
                  ElevatedButton(
                    onPressed: () => _openDatePicker(context),
                    child: const Text('Select Birthday'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24, bottom: 8),
                    child: StyledButton(
                      onPressed: () {
                        addDetailUserProfile(
                            widget.user,
                            _emailController.text,
                            _displayNameController.text,
                            _genderCharacter.toString().split('.')[1],
                            '$selectedDate'.split(' ')[0]);
                        Navigator.pushNamed(context, '/navigator');
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  _openDatePicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }
}

Future<void> addDetailUserProfile(
    user, String? email, String? name, String? gender, String? birthday) {
  final userDetail = <String, dynamic>{
    "Email": email,
    "Name": name,
    "Gender": gender,
    "Birthday": birthday,
    "uid": user.uid,
    "Approved": true,
  };
  return FirebaseFirestore.instance
      .collection("users")
      .doc(user.uid)
      .set(userDetail);
}
