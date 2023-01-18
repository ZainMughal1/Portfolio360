import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
class FirebaseStorageController{

  ImagePicker _imagePicker = Get.find();
  FilePicker _filePicker = Get.find();
  FirebaseStorage firebaseStorage = Get.find();
  Future<String?> uploadProfileImage()async{
    XFile? pickFile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickFile == null)  return "";
    File file =   File(pickFile.path);
    String filename = basename(file.path);
    final ref  = firebaseStorage.ref().child('ProfileImages/$filename');
    await ref.putFile(file);
    String url = await ref.getDownloadURL();
    print("Url => $url");
    return url;
  }

  Future<String> uploadResumeFile()async{
    final r =await _filePicker.pickFiles();
    File file = File(r!.paths.single!);
    String filename = basename(file.path);
    final ref = firebaseStorage.ref().child('ResumeFiles/$filename');
    await ref.putFile(file);
    String url = await ref.getDownloadURL();
    print("Url => $url");
    return url;
  }

  Future downloadResume(String url) async {
    final result = await launchUrl(Uri.parse(url),mode: LaunchMode.externalApplication);
    print("result => $result");
  }


}