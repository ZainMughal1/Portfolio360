import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginController {
  FirebaseAuth _auth = Get.find();

  Future<String?> loginInWithPassword(String email, String password) async {
    try {
      final credential = await _auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        Get.offAllNamed('/Home');
      });
    } on FirebaseAuthException catch (e) {
      return e.code;
    } catch (e) {
      print(e);
      return e.toString();
    }
  }
}
