import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:portfolio360/Bindings/MyController.dart';
import 'package:portfolio360/Controllers/FirebaseStorageController.dart';
import 'package:portfolio360/Controllers/FirestoreController.dart';
import 'package:portfolio360/Controllers/LoginController.dart';
import 'package:portfolio360/Controllers/SignupController.dart';
import 'package:portfolio360/Controllers/ThemeChangerController.dart';
import 'package:portfolio360/Models/EditProfileModel.dart';

class InitBindings extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => MyController());
    Get.lazyPut(() => FirebaseFirestore.instance);
    Get.lazyPut(() => FirebaseAuth.instance);
    Get.lazyPut(() => SignupController());
    Get.lazyPut(() => ImagePicker());
    Get.lazyPut(() => FirebaseStorageController());
    Get.lazyPut(() => FirebaseStorage.instance);
    Get.lazyPut(() => FilePicker.platform);
    Get.lazyPut(() => FirestoreController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => Fluttertoast());
    Get.lazyPut(() => ThemeChanger());
    Get.lazyPut(() => GetStorage());
  }
}