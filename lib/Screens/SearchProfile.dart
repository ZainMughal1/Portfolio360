import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio360/Controllers/FirestoreController.dart';
import '../Controllers/ThemeChangerController.dart';
import '../Styles/CustomWidgets.dart';
import '../Styles/Txtfields.dart';

class SearchProfile extends StatelessWidget {
  const SearchProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = Get.find();
    FirestoreController _firestoreController = Get.find();
    FirebaseAuth _auth = Get.find();
    ThemeChanger _themeChanger = Get.find();
    final searchC = TextEditingController();
    RxString searchtxt = "".obs;
    return Scaffold(
      body: Obx(()=> Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 10, top: 15, bottom: 5, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discover",
                  style: GoogleFonts.oswald(
                      textStyle: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.secondary)),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            side: BorderSide.none),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Saved",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Theme.of(context).colorScheme.primaryContainer, fontWeight: FontWeight.bold)),
                    ))
              ],
            ),
          ),
          TextFormField(
            controller: searchC,
            onChanged: (v){
              searchtxt.value = v;
            },
            decoration: txtfield2("Search", "Search By Name",context),
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: searchtxt.value.isNotEmpty ?
              _firestore.collection('Users')
                  .where('uniqueId', isEqualTo: searchtxt.value)
                  .where('userType', isEqualTo: "L2")
                  .where('uid', isNotEqualTo: _auth.currentUser!.uid)
                  .snapshots()
                  :
              _firestore.collection('Users')
                .where('userType', isEqualTo: "L2")
                .where('uid', isNotEqualTo: _auth.currentUser!.uid)
                .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("LOADING"),
                  );
                }
                if (snapshot.connectionState == ConnectionState.none) {
                  return Center(
                    child: Text("NO DATA"),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                final _UserId = _auth.currentUser!.uid;
                return ListView(
                  children: snapshot.data!.docs
                      .map(
                        (e) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5,vertical: 2),
                          child: cont1(
                              context,
                              e['acceptList'],
                              e['uid'],
                          e['profileImage'], e['name'], e['uniqueId'],
                            () async{
                              await _firestoreController.sendRequest(e['uid']);
                            },
                            e['requestList'].contains(_UserId) ? "Sent": e['acceptList'].contains(_UserId)? "Connected": "Send Request"
                          ),
                        ),
                  )
                      .toList(),
                );
                // return Center(child: Text("Error"));
              },
            ),
          )
        ],
      )),
    );
  }
}
