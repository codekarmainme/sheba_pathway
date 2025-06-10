import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class AuthRepository {
  Future<void> signup({String? email, String? password, String? username}) async {
    final auth = FirebaseAuth.instance;
    final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
    await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
   await _userCollection.doc(auth.currentUser!.uid).set({
    'email':email,
    'username':username,
    'createdAt': FieldValue.serverTimestamp(),
    'uid': auth.currentUser?.uid
   });
  }

  Future<void> signin({String? email, String? password}) async {
    final auth = FirebaseAuth.instance;

    await auth.signInWithEmailAndPassword(email: email!, password: password!);
  }

  Future<void> signOut() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();
  }

  Future<User?> getCurrentUser() async {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    return user;
  }
Future<UserCredential?> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  if (googleUser == null) return null; // user canceled

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Sign in to Firebase with the Google [UserCredential]
  final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

  // Save user info to Firestore if not already present
  final user = userCredential.user;
 if (user != null) {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');
  final doc = await _userCollection.doc(user.uid).get();
  if (!doc.exists) {
    await _userCollection.doc(user.uid).set({
      'email': user.email,
      'username': user.displayName ?? '',
      'createdAt': FieldValue.serverTimestamp(),
      'uid': user.uid,
    });
  }
}

  return userCredential;
}
}
