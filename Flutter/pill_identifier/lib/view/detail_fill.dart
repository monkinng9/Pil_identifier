import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pill_identifier/common/widgets.dart';

// [#detail_screen] Detail Check
/// - Email TextField
/// - DisplayName TextField
/// - Gender
/// - Birthday
///   - Date Picker

enum GenderCharacter { men, women }

class ProfileFill extends StatefulWidget {
  ProfileFill({Key? key}) : super(key: key);
  final String? email = FirebaseAuth.instance.currentUser!.email;
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

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Welcome to Pill Identifier"),
          TextFormField(
            controller: _emailController,
            readOnly: true,
            decoration: const InputDecoration(
              icon: Icon(Icons.person),
              hintText: 'Email@gmail.com',
              labelText: 'Email *',
            ),
            validator: (String? value) {
              return (value != null && value.contains('@')) ? null : 'Required';
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
              onPressed: () {},
              child: const Text('Submit'),
            ),
          ),
        ],
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
