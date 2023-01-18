import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Controllers/FirestoreController.dart';
import '../Styles/Colors.dart';

class ShowAccept extends StatefulWidget {
  const ShowAccept({Key? key}) : super(key: key);
  @override
  State<ShowAccept> createState() => _ShowAcceptState();
}

class _ShowAcceptState extends State<ShowAccept> {
  RxList acceptList = [].obs;
  final FirestoreController _firestoreController = Get.find();
  Future getData()async{
    acceptList.value = await _firestoreController.getAcceptList();
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
                    "Accept Request List",
                    style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.secondary
                        )),
                  ),
                ],
              ),
            ),
            Expanded(child: acceptList.value.isNotEmpty? StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('Users')
                  .where('uid', whereIn: acceptList.value)
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
                        child: ListTile(
                          title: Text(e['name'],style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).colorScheme.onSecondaryContainer
                            ),
                          ),),
                          trailing: TextButton(onPressed: ()async{
                            await _firestoreController.CancelAccept(e['uid']);
                            getData();
                          }, child: Text("Remove",style: GoogleFonts.roboto(
                              textStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              )
                          ),)),
                        )
                      )
                  ).toList(),
                );
              },
            ): Center(child: Text("No Accepted"),)),
          ],
        );
      }),
    );

  }
}

// SizedBox(height: 5,),
