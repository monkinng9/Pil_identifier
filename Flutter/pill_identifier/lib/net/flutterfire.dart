import 'package:firebase_auth/firebase_auth.dart';

/// signIn function
/// - นำข้อมูล email และ password มาทำการผ่าน
///     signInWithEmailAndPassword ของ Fire_auth เพื่อเข้าสู่ระบบ
///   - return true
/// - หากไม่บัญชี หรือ Password ไม่ตรง return false

Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    print(e);
    return false;
  }
}

/// register Function
/// 1. รับค่า email และ password
/// 2. ทำการตรวจสอบ weak-password และ email-already-in-use
///     - return false
///     - print คำเตือน
/// 3. หากผ่านเงื่อนไขจึงสร้าง Email และ Password ไว้ใน Fire_auth

Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password proveide is too weak.');
    } else if (e.code == 'email-already-in-use') {}
    print('The account already exists for the email');
    return false;
  } catch (e) {
    print(e.toString());
    return false;
  }
}
