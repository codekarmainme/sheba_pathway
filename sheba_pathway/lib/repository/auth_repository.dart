import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<void> signup({String? email, String? password}) async {
    final auth = FirebaseAuth.instance;
    await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }

  Future<void> signin({String? email, String? password}) async {
    final auth = FirebaseAuth.instance;

    await auth.signInWithEmailAndPassword(email: email!, password: password!);
  }
}
