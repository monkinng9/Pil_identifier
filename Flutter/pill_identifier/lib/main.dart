// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pill_identifier/service/auth/auth_service.dart';
import 'package:pill_identifier/temp/temp_screen.dart';
import 'package:pill_identifier/view/detail_fill.dart';
import 'package:pill_identifier/view/detect/detect_screen.dart';
import 'package:pill_identifier/view/navigation_screen.dart';
import 'package:pill_identifier/wrapper.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pill Identifier',
        theme: ThemeData(
          buttonTheme: Theme.of(context).buttonTheme.copyWith(
                highlightColor: Colors.deepPurple,
              ),
          primarySwatch: Colors.deepPurple,
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme,
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const Wrapper(),
          '/navigator': (context) => NavigationScreen(),
          '/profilefill': (context) => ProfileFill(),
          '/detect': (context) => const DetectScreen(),
          '/temp': (context) => const TempScreen(),
        },
      ),
    );
  }
}
