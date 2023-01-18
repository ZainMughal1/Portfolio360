import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio360/Controllers/FirestoreController.dart';
import 'package:portfolio360/Controllers/ThemeChangerController.dart';

import '../Styles/Colors.dart';

class ShowRequest extends StatefulWidget {
  const ShowRequest({Key? key}) : super(key: key);
  @override
  State<ShowRequest> createState() => _ShowRequestState();
}

class _ShowRequestState extends State<ShowRequest> {
  RxList requestList = [].obs;
  final FirestoreController _firestoreController = Get.find();
  Future getData()async{
    requestList.value = await _firestoreController.getRequestList();
    // print("request List => $requestList");
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore _firestore = Get.find();
    return Scaffold(
      body: Obx((){
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10, top: 15, bottom: 5, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Profile view Requests",
                    style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.secondary)),
                  ),
                ],
              ),
            ),
            Expanded(child: requestList.value.isNotEmpty? StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Users')
                  .where('uid', whereIn: requestList.value)
                  .snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasError){
                  return Center(child: Text("Error Occured"),);
                }
                if(snapshot.connectionState == ConnectionState.none){
                  return Center(child: Text("No Data"),);
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: Text("Waiting."),);
                }
                return ListView(
                  children: snapshot.data!.docs.map((e) =>
                      Container(
                        padding: EdgeInsets.only(top: 6,left: 10,right: 10),
                        margin: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                        width: Get.width,
                        height: 70,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e['name'],style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer
                              ),
                            ),),
                            // SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(onPressed: ()async{
                                  await _firestoreController.CancelRequest(e['uid']);
                                  getData();
                                }, child: Text("Remove",style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    )
                                ),)),
                                TextButton(onPressed: ()async{
                                  await _firestoreController.AcceptRequest(e['uid']);
                                  getData();
                                }, child: Text("Accept",style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.secondary,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    )
                                ),)),
                              ],)
                          ],
                        ),
                      )
                  ).toList(),
                );
              },
            ): Center(child: Text("No Request"),)),
          ],
        );
      }),
    );

  }
}
