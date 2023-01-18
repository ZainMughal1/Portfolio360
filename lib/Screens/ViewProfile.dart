import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio360/Controllers/FirebaseStorageController.dart';
import 'package:portfolio360/Styles/Colors.dart';

class ViewProfile extends StatelessWidget {
  const ViewProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List skillsList = [];
    List workList = [];
    List linksList = [];
    List contactsList = [];
    FirebaseFirestore _firestore = Get.find();
    String UserId = Get.arguments;
    FirebaseStorageController firebaseStorageController = Get.find();
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<DocumentSnapshot>(
          future: _firestore.collection('Users').doc(UserId).get(),
          builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: Text("LOADING"),);
            }
            if(snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            if(snapshot.connectionState == ConnectionState.done){
              Map<String,dynamic> data = snapshot.data!.data() as Map<String,dynamic>;
              print(data['name']);
              workList = data['workExperience'];
              skillsList = data['skills'];
              linksList = data['links'];
              contactsList = data['contacts'];
              return Container(
                height: Get.height,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 200,),
                            Text("About",style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                )
                            ),),
                            SizedBox(height: 5,),
                            Text(data['aboutyou'],
                              textAlign: TextAlign.justify
                              ,style: GoogleFonts.roboto(
                                  textStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                                      fontWeight: FontWeight.w400
                                  )
                              ),),
                            SizedBox(height: 10,),
                            Text("Work Experience",style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                )
                            ),),
                            SizedBox(height: 5,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(workList.length, (index){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(workList[index],style: GoogleFonts.roboto(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                                      ),),
                                      Divider(),
                                    ],);
                                }),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Skills",style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                )
                            ),),
                            SizedBox(height: 5,),
                            Container(
                              width: Get.width,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              child: GridView.count(
                                  crossAxisCount: 4,
                                  // childAspectRatio: 2,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                  padding: EdgeInsets.all(5),
                                  children: List.generate(skillsList.length, (index){
                                    return Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.primary,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: Center(
                                        child: Text(skillsList[index],style: GoogleFonts.roboto(
                                            textStyle: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Theme.of(context).colorScheme.onPrimary
                                            )
                                        ),),
                                      ),
                                    );
                                  })

                              ),
                            ),
                            SizedBox(height: 10,),
                            Text("Links",style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                )
                            ),),
                            SizedBox(height: 5,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(linksList.length, (index){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(linksList[index],style: GoogleFonts.roboto(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                                      ),),
                                      Divider(),
                                    ],);
                                }),
                              ),
                            ),

                            SizedBox(height: 10,),
                            Text("Contacts",style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                )
                            ),),
                            SizedBox(height: 5,),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                              width: Get.width,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.secondaryContainer,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(contactsList.length, (index){
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(contactsList[index],style: GoogleFonts.roboto(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer,
                                      ),),
                                      Divider(),
                                    ],);
                                }),
                              ),
                            ),

                            SizedBox(height: 10,),
                            Text("Address",style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                )
                            ),),
                            SizedBox(height: 5,),
                            Text(data['address'],style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                                )
                            ),),
                            SizedBox(height: 20,),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                              ),
                                onPressed: (){
                                  // firebaseStorageController.downloadFile(data['resume']);
                                  firebaseStorageController.downloadResume(data['resume']);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Download Resume",style: GoogleFonts.roboto(
                                      textStyle: TextStyle(
                                        fontSize: 18,
                                        color: Theme.of(context).colorScheme.primaryContainer
                                      )
                                    ),)
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 25),
                      width: Get.width,
                      height: 150,
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30))
                      ),
                      child: Text(data['name'],textAlign: TextAlign.center,style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onPrimary,
                          )
                      ),),
                    ),
                    Positioned(
                      left: Get.width/2.8,
                      top: 90,
                      child: CircleAvatar(
                        radius: 53,
                        backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                        child: CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: Image.network(data['profileImage'],fit: BoxFit.cover,width: 200,height: 200,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text("Waiting"),
            );

          },
        ),
      ),
    );
  }
}


// Container(
// padding: EdgeInsets.all(2),
// decoration: BoxDecoration(
// color: c1,
// borderRadius: BorderRadius.circular(10)
// ),
// child: Center(
// child: Text("Java",style: GoogleFonts.roboto(
// textStyle: TextStyle(
// fontWeight: FontWeight.bold,
// color: w1
// )
// ),),
// ),
// ),