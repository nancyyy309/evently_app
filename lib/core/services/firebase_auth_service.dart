import 'package:evently/core/services/snack_bar_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_sign_in/google_sign_in.dart';
abstract class FirebaseAuthService {

  static Future<bool> createAccount({
    required String emailAddress,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      final userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      SnackBarService.showSuccessMessage("Account created successfully");

      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        SnackBarService.showErrorMessage(
            e.message ?? 'The password provided is too weak.');

        print('The password provided is too weak.');
        return Future.value(false);
      } else if (e.code == 'email-already-in-use') {
        SnackBarService.showErrorMessage(
            e.message ?? 'The account already exists for that email.');
        print('The account already exists for that email.');
        return Future.value(false);
      }
      return Future.value(false);
    } catch (e) {
      return Future.value(false);
    }
  }

  static Future<bool> login({
    required String emailAddress,
    required String password,
  }) async {
    EasyLoading.show();
    try {
      final userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );



      print(userCredential.credential?.accessToken);
      print(userCredential.user?.uid);

      SnackBarService.showSuccessMessage("Logged In successfully");

      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      print(e.code);
      if (e.code == 'user-not-found') {
        SnackBarService.showErrorMessage(
            e.message ?? 'No user found for that email.');
        return Future.value(false);
      } else if (e.code == 'invalid-credential') {
        SnackBarService.showErrorMessage(
            e.message ?? 'Wrong password provided for that user.');
        return Future.value(false);
      }
      return Future.value(false);
    } catch (e) {
      return Future.value(false);
    }

  }
  static Future<bool> signInWithGoogle() async {
    EasyLoading.show();
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {

        EasyLoading.dismiss();
        return Future.value(false);
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      print("Google Login Success: ${userCredential.user?.email}");
      SnackBarService.showSuccessMessage("Logged in with Google successfully");

      EasyLoading.dismiss();
      return Future.value(true);
    } catch (e) {
      print("Google Sign-In Error: $e");
      SnackBarService.showErrorMessage("Google Sign-In failed");
      EasyLoading.dismiss();
      return Future.value(false);
    }
  }
}