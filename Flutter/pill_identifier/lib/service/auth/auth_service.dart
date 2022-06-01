import "package:firebase_auth/firebase_auth.dart" as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pill_identifier/models/user_model.dart';

class AuthService {
  final auth.FirebaseAuth _firebaseAuth = auth.FirebaseAuth.instance;

  UserLogin? _userFormFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return UserLogin(user.uid, user.email);
  }

  Stream<UserLogin?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFormFirebase);
  }

  Future<UserLogin?> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return _userFormFirebase(credential.user);
  }

  Future<UserLogin?> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return _userFormFirebase(credential.user);
  }

  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
