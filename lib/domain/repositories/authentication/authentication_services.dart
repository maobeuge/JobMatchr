import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobmatchr/constants/api.dart';

class AuthenticationServices {
  Future<ResponseModel> login(final String email, final String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final UserCredential userCredential =
          await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ResponseModel(
        statusCode: 400,
        sentence: "Logged in successfully",
        content: userCredential.user?.uid,
      );
    } catch (firebaseAuthException) {
      return ResponseModel(
        statusCode: 401,
        sentence: firebaseAuthException.toString(),
        content: null,
      );
    }
  }

  Future<ResponseModel> register(
      final String email, final String password) async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return ResponseModel(
        statusCode: 400,
        sentence: "Account created successfully",
        content: userCredential.user?.uid,
      );
    } catch (firebaseAuthException) {
      return ResponseModel(
        statusCode: 401,
        sentence: firebaseAuthException.toString(),
        content: null,
      );
    }
  }
}
