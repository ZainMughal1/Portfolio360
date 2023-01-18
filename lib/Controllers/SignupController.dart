import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class SignupController {
  FirebaseAuth _auth = Get.find();

  Future<bool> signUpWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(scopes: <String>["Email"]).signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      if (googleAuth == null) {
        return false;
      } else {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        print(await _auth.signInWithCredential(credential));
        return true;
      }
    } catch (e) {
      print("error => ${e.toString()}");
      return false;
    }
  }

  signUpWithFacebook() async {
    try {
      // Trigger the sign-in flow
      final LoginResult loginResult = await FacebookAuth.instance.login();
      if (loginResult == null) {
        return false;
      } else {
        // Create a credential from the access token
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(loginResult.accessToken!.token);

        // Once signed in, return the UserCredential
        print(await FirebaseAuth.instance
            .signInWithCredential(facebookAuthCredential)
            .toString());
        return true;
      }
    } catch (e) {
      print("error => ${e.toString()}");
      return false;
    }
  }

  Future<String?> signUpWithPassword(String email, String password) async {
    try {
      final credential = await _auth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Get.offAllNamed('/CreateProfile');
      });
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }

  Future signUpAsGuest() async {
    _auth.signInAnonymously().then((value) {
      print(_auth.currentUser!.uid);
      Get.offAllNamed('/CreateGuestProfile');
    }).catchError((e) {
      print("error => $e");
    });
  }

  SignOut() async{
    if (await _auth.currentUser != null) {
      await _auth.signOut();
      Get.toNamed('/EmailLogin');
      print("signout");
    }
  }
}
