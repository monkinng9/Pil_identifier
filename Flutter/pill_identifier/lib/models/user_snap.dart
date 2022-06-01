import 'package:cloud_firestore/cloud_firestore.dart';

class User_snap {
  final String? name;
  final String? birthday;
  final String? email;
  final String? gender;
  final String? uid;
  final bool? approved;

  User_snap(
      {required this.name,
      required this.birthday,
      required this.email,
      required this.gender,
      required this.uid,
      required this.approved});

  User_snap.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  )   : name = snapshot.data()?["Name"],
        email = snapshot.data()?["Email"],
        gender = snapshot.data()?["Gender"],
        approved = snapshot.data()?["Approved"],
        birthday = snapshot.data()?["Birthday"],
        uid = snapshot.data()?["uid"];

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "Name": name,
      if (email != null) "Email": email,
      if (gender != null) "Gender": gender,
      if (approved != null) "Approved": approved,
      if (birthday != null) "Birthday": birthday,
      if (uid != null) "uid": uid,
    };
  }
}
