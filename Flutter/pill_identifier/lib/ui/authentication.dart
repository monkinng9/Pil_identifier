import 'package:flutter/material.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(color: Colors.blueAccent),
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                  controller: _emailField,
                  decoration: const InputDecoration(
                    hintText: "something@email.com",
                    hintStyle: TextStyle(color: Colors.white),
                    labelText: "Email",
                    labelStyle: TextStyle(color: Colors.white),
                  )),
              TextFormField(
                  controller: _passwordField,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "password",
                    hintStyle: TextStyle(color: Colors.white),
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
                  onPressed: () {},
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
                  onPressed: () {},
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
