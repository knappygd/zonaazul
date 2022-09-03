import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Auth {
  final String? uid = FirebaseAuth.instance.currentUser?.uid;
  FirebaseAuth auth = FirebaseAuth.instance;
  Auth(this.auth);
  Stream<User?> get authStateChanges => auth.idTokenChanges();

  Future<String> login(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "User successfully logged in.";
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> signUp(String email, String password, String name,
      String plate, String card) async {
    try {
      await auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User? user = FirebaseAuth.instance.currentUser;

        await FirebaseFirestore.instance
            .collection("users")
            .doc(user?.uid)
            .set({
          'uid': user?.uid,
          'name': name,
          'email': email,
          'plate': plate,
          'card': "None",
          'cardamt': 0,
          'hasNotificationsEnabled': true,
          'uses24HourFormat': true,
          'hasHistoryEnabled': true,
        });
      });
      return "Signed Up";
    } catch (e) {
      return e.toString();
    }
  }

  Future getCurrentUser() async {
    return auth.currentUser;
  }

  Future getCurrentUserData() async {
    DocumentSnapshot ds =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();
    String name = ds.get('name');
    String plate = ds.get('plate');
    return [name, plate];
  }
}
