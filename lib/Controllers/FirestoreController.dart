import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:portfolio360/Models/CreateProfileModel.dart';
import 'package:portfolio360/Models/EditProfileModel.dart';

class FirestoreController {
  String? result;
  FirebaseAuth _auth = Get.find();
  FirebaseFirestore _firestore = Get.find();


  Future createGuestProfile(String name)async{
    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid).set({
      'name': name,
      'userType': "L1",
      'uid': _auth.currentUser!.uid,
    })
        .then((value) {
      Get.toNamed('/Home');
    }).catchError((e) {
      print("ERror $e");
    });
  }

  Future<String> createProfile(String profileImage,
      String uniqueId,
      String name,
      String aboutyou,
      String resume,
      List workExperience,
      List links,
      List contacts,
      List skills,
      String address) async {
    print("proceeding********");
    CreateProfileModel m = CreateProfileModel(
        profileImage,
        uniqueId,
        name,
        aboutyou,
        resume,
        workExperience,
        links,
        contacts,
        skills,
        address,
        _auth.currentUser!.uid,
        [],
        [],
        "L2");
    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid).set(m.toMap())
        .then((value) {
      print("successful");
      result = "successfull";
    }).catchError((e) {
      print("ERror $e");
      result = "failed";
    });

    print("Result => $result");
    Fluttertoast.showToast(msg: result.toString());
    return result!;
  }

  Future<String> editProfile(String profileImage,
      String uniqueId,
      String name,
      String aboutyou,
      String resume,
      List workExperience,
      List links,
      List contacts,
      List skills,
      String address) async {
    print("proceeding********");
    EditProfileModel m = EditProfileModel(
        profileImage,
        uniqueId,
        name,
        aboutyou,
        resume,
        workExperience,
        links,
        contacts,
        skills,
        address,
        _auth.currentUser!.uid);
    await _firestore
        .collection('Users')
        .doc(_auth.currentUser!.uid).update(m.toMap())
        .then((value) {
      print("successful");
      result = "successfull";
    }).catchError((e) {
      print("ERror $e");
      result = "failed";
    });

    print("Result => $result");
    Fluttertoast.showToast(msg: result.toString());
    return result!;
  }

  Future sendRequest(String profileUid) async {
    final newObjectList = [_auth.currentUser!.uid];
    await _firestore.collection('Users').doc(profileUid).update(
        {
          "requestList": FieldValue.arrayUnion(newObjectList)
        }
    ).catchError((e) {
      print("erroe => $e");
    });
  }

  Future<List> getRequestList()async{
    List requestList = [];
    await _firestore.collection('Users').doc(_auth.currentUser!.uid).get().then((value){
      Map<String,dynamic> map = value.data() as Map<String,dynamic>;
      requestList =  map['requestList'];
    }).catchError((e){
      print("errorr => $e");
    });
    print(requestList.toString());
    return requestList;
  }
  Future<List> getAcceptList()async{
    List acceptList = [];
    await _firestore.collection('Users').doc(_auth.currentUser!.uid).get().then((value){
      Map<String,dynamic> map = value.data() as Map<String,dynamic>;
      acceptList =  map['acceptList'];
    }).catchError((e){
      print("errorr => $e");
    });
    print(acceptList.toString());
    return acceptList;
  }

  Future AcceptRequest(String uid)async{
    final ObjectList = [uid];
    await _firestore.collection('Users').doc(_auth.currentUser!.uid)
        .update({
      'requestList': FieldValue.arrayRemove(ObjectList)
    }).then((value)async{
      await _firestore.collection('Users').doc(_auth.currentUser!.uid)
          .update({
        'acceptList': FieldValue.arrayUnion(ObjectList),
      })
          .catchError((e){
            print("eeorro => $e");
      });
    })
        .catchError((e){
      print("eeorrr => $e");
    });
  }

  Future CancelRequest(String uid)async{
    final ObjectList = [uid];
    await _firestore.collection('Users').doc(_auth.currentUser!.uid)
        .update({
      'requestList': FieldValue.arrayRemove(ObjectList)
    })
      .catchError((e){
      print("eeorrr => $e");
    });
  }

  Future CancelAccept(String uid)async{
    final ObjectList = [uid];
    await _firestore.collection('Users').doc(_auth.currentUser!.uid)
        .update({
      'acceptList': FieldValue.arrayRemove(ObjectList)
    })
        .catchError((e){
      print("eeorrr => $e");
    });
  }
}
