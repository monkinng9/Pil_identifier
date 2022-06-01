import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:pill_identifier/models/user_snap.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({Key? key}) : super(key: key);

  User user = FirebaseAuth.instance.currentUser!;

  Future<bool?> _showWarning(BuildContext context, String title) async =>
      showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Do you want to $title?'),
          actions: [
            ElevatedButton(
              child: const Text('No'),
              onPressed: () => Navigator.pop(context, false),
            ),
            ElevatedButton(
              child: const Text('Yes'),
              onPressed: () {
                if (title == "exit") {
                  // pop 2 ครั้งติด
                  SystemNavigator.pop();
                } else {
                  FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/');
                }
              },
            ),
          ],
        ),
      );

  Future<Object> getData() async {
    // final user = user;
    final ref = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .withConverter(
          fromFirestore: User_snap.fromFirestore,
          toFirestore: (User_snap userDetail, _) => userDetail.toFirestore(),
        );
    final docSnap = await ref.get();
    final userDetail = docSnap.data();
    return userDetail!;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showWarning(context, "exit");
        return shouldPop ?? false;
      },
      child: Scaffold(
        backgroundColor:HexColor("#FBFBFB"),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () async {
                _showWarning(context, "logout");
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Card(
                color: HexColor("#FFDED8"),
                elevation:5,
                margin: const EdgeInsets.only(
                    top: 24.0, left: 24, right: 24, bottom: 36),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: FutureBuilder(
                    future: getData(),
                    builder: (BuildContext context,
                        AsyncSnapshot<dynamic> snapshot) {
                      List<Widget> children;
                      if (snapshot.data != null) {
                        final userName = snapshot.data.name.toUpperCase();
                        children = profileCard(userName);
                      } else {
                        return const Text('Elevated Card');
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
              Container(
                margin: const EdgeInsets.only(left: 24),
                width: double.infinity,
                child: const Text(
                  "เลือกบริการ",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: SizedBox(
                  width: 270,
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    children: [
                      gridItem(context, "ระบุเม็ดยาด้วยการ\nกรอกข้อมูลจำเพาะ", "/detect", GridItemIcon.firstItem),
                      gridItem(context, "ระบุเม็ดยาด้วยรูปภาพ", "/detect", GridItemIcon.secondItem),
                      gridItem(context, "คลังเม็ดยา", "/detect", GridItemIcon.thirdItem),
                      gridItem(context, "เม็ดยาที่ทำการบันทึก", "/detect", GridItemIcon.fouthItem),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card gridItem(BuildContext context, String title, String route, String icon) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/detect');
        },
        child: Ink(
          decoration: BoxDecoration(
            // ignore: use_full_hex_values_for_flutter_colors
            color: HexColor("#FFFFFF"),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(icon),
              Text(title, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> profileCard(userName) {
    return <Widget>[
      Padding(
        padding:
            const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 24, right: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                bottom: 8.0,
                // left: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Text('สวัสดี😉',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                  Text("$userName"),
                ],
              ),
            ),
            const CircleAvatar(
              radius: 30,
            )
          ],
        ),
      ),
    ];
  }
}

class GridItemIcon {
  static const firstItem = "assets/grid_item_icons/library_books.svg";
  static const secondItem = "assets/grid_item_icons/pills_2.svg";
  static const thirdItem = "assets/grid_item_icons/all_inbox.svg";
  static const fouthItem = "assets/grid_item_icons/book.svg";
}
