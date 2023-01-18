import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyController extends GetxController{
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  FirebaseAuth get getFirebaseAuth  => this._auth;
  FirebaseFirestore get getFirestore => this._firestore;
}