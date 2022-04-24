// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDZQd06Pg8kSSS2awKLebzla15M1nEy3nU',
    appId: '1:55893101104:web:2951b16314ca6dd2b8bbf5',
    messagingSenderId: '55893101104',
    projectId: 'pill-identifier-57849',
    authDomain: 'pill-identifier-57849.firebaseapp.com',
    storageBucket: 'pill-identifier-57849.appspot.com',
    measurementId: 'G-MQ8T3GPHNT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCYNxVxnJUBJvZ6NohRfrltXfNnkZS_NqM',
    appId: '1:55893101104:android:64596830abd233d8b8bbf5',
    messagingSenderId: '55893101104',
    projectId: 'pill-identifier-57849',
    storageBucket: 'pill-identifier-57849.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3fJl7j3srTTzvG7f_VZopJlOyF5lzKHk',
    appId: '1:55893101104:ios:8778b23e5c1c9a67b8bbf5',
    messagingSenderId: '55893101104',
    projectId: 'pill-identifier-57849',
    storageBucket: 'pill-identifier-57849.appspot.com',
    androidClientId: '55893101104-l2s2ckivs9vkad216itvqvths500jsos.apps.googleusercontent.com',
    iosClientId: '55893101104-a5s8o29b4spfa4g6o8pnd83on28li8ck.apps.googleusercontent.com',
    iosBundleId: 'com.example.pillIdentifier',
  );
}
