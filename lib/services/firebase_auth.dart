import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news/models/user_model.dart';

class AuthService with ChangeNotifier {
  /// [Firebase Auth Instance]
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// [Create Firebase User Object]
  UserInfoModel _userModel(User user) {
    return UserInfoModel(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      isVerified: user.emailVerified,
      phone: user.phoneNumber,
      userImg: user.photoURL,
    );
  }

  /// [User Auth Stream]
  Stream<User?>? get user => _firebaseAuth.authStateChanges();

  /// [Signin With Email And Password]
  Future signInWithEmailAndPass({required String email, required String password}) async {
    String res = "";

    try {
      UserCredential _credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User _user = _credential.user!;
      // await userUpdate(_user);
      return _userModel(_user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        res = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        res = 'Wrong password provided for that user.';
      }
    }

    return res;
  }

  /// [Google Sign in]
  Future signInWIthGoogle() async {
    try {
      final GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();

      final GoogleSignInAuthentication _googleSignInAuthentication = await _googleSignInAccount!.authentication;

      final AuthCredential _authCredential = GoogleAuthProvider.credential(
        accessToken: _googleSignInAuthentication.accessToken,
        idToken: _googleSignInAuthentication.idToken,
      );

      UserCredential _credential = await _firebaseAuth.signInWithCredential(_authCredential);

      User _user = _credential.user!;
      // create new user data on firestore
      // await userUpdate(_user);

      // return
      return _userModel(_user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else {
        print('try again later $e');
      }
    }
  }

  /// [register with email and password]
  Future registerWithEmailAndPass({required String name, required String email, required String password}) async {
    try {
      UserCredential _credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User _user = _credential.user!;

      if (!_user.emailVerified) {
        await _user.sendEmailVerification();
      }

      // create new user data on firestore
      // await userUpdate(_user);

      return _userModel(_user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password')
        print('The password provided is too weak.');
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      notifyListeners();
    } catch (e) {
      print(e.toString());
    }
  }

  /// [Update Email]
  Future updateEmail(email) async {
    try {
      await _firebaseAuth.currentUser!
          .updateEmail(email)
          .whenComplete(() => "Email update successfully")
          .onError((error, stackTrace) => error);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  /// [sign out]
  Future signOut() async {
    try {
      await _googleSignIn.signOut();
      await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  /// [Terminate Account]
  Future terminateAccount({uid}) async {
    try {
      await _firebaseAuth.currentUser!.delete();

      // delete user data on firestore
      // await FirestoreService(uid: uid).deleteUserData();
    } catch (e) {
      print(e.toString());
    }
  }

  /// [password reset]
  Future resetPassword(email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  /// [user update]
  // Future<dynamic> userUpdate(User _user) async {
  //   return await FirestoreService(uid: _user.uid).updateUserData(
  //     email: _user.email,
  //     name: _user.displayName,
  //     uid: _user.uid,
  //     emailVerified: _user.emailVerified,
  //     phoneNumber: _user.phoneNumber,
  //     photoURL: _user.photoURL,
  //     creationTime: _user.metadata.creationTime,
  //     lastSignInTime: _user.metadata.lastSignInTime,
  //     provider: _user.providerData[0].providerId,
  //     refreshToken: _user.refreshToken,
  //     tenantId: _user.tenantId,
  //   );
  // }

  notifyListeners();
}
