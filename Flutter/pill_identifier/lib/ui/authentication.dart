/// 1. การทำงานของการ Register Button
/// - ทำการเรียกค่าจาก TextEditingController ทั้ง email และ password
/// - ทำการ import flutterfire.dart
///   - เก็บ register function
/// - เมื่อกดปุ่ม register ใน onpressed จะทำการเรียก register function
///     และนำข้อมูล email และ password ไปประมวลผล และ Navigate ไปยังหน้าต่อไป
///     ด้วยค่า shouldNavigate ที่เป็น True

/// 2. การทำงานของ SignIn Button
/// - เป็นในลักษณะเดียวกันกับ Register Button

import 'package:flutter/material.dart';
import 'package:pill_identifier/net/flutterfire.dart';

import 'home_view.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final TextEditingController _emailField = TextEditingController();
  final TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                  controller: _emailField,
                  decoration: const InputDecoration(
                    hintText: "something@email.com",
                    hintStyle: TextStyle(color: Colors.grey),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                  )),
              TextFormField(
                  controller: _passwordField,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(color: Colors.grey),
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.white),
                  )),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await register(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const HomeView(),
                        ),
                      );
                    }
                  },
                  child: const Text("Register"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                ),
                child: MaterialButton(
                  onPressed: () async {
                    bool shouldNavigate =
                        await signIn(_emailField.text, _passwordField.text);
                    if (shouldNavigate) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const HomeView(),
                        ),
                      );
                    }
                  },
                  child: const Text("Log in"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
