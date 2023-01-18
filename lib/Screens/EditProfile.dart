import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio360/Controllers/FirebaseStorageController.dart';
import 'package:portfolio360/Controllers/FirestoreController.dart';
import 'package:portfolio360/Styles/Colors.dart';
import '../Styles/Txtfields.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxString profileImageUrl = "".obs;
    final idC = TextEditingController();
    final nameC = TextEditingController();
    final aboutC = TextEditingController();
    RxString resumeUrl = "".obs;
    RxList workList = [].obs;
    RxList linksList = [].obs;
    RxList contactsList = [].obs;
    RxList skillsList = [].obs;
    RxString address = "Address not add".obs;

    final workExpC = TextEditingController();
    final linksC = TextEditingController();
    final contactC = TextEditingController();
    final skillC = TextEditingController();
    final addressC = TextEditingController();
    final _keyForm = GlobalKey<FormState>();
    FirebaseStorageController firebaseStorageController = Get.find();
    FirestoreController _firestoreController = Get.find();
    FirebaseFirestore _firestore = Get.find();
    FirebaseAuth _auth = Get.find();
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot>(
          future:
              _firestore.collection('Users').doc(_auth.currentUser!.uid).get(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              profileImageUrl.value = data['profileImage'];
              resumeUrl.value = data['resume'];
              workList.value = data['workExperience'];
              linksList.value = data['links'];
              contactsList.value = data['contacts'];
              skillsList.value = data['skills'];
              address.value = data['address'];
              idC.text = data['uniqueId'];
              nameC.text = data['name'];
              aboutC.text = data['aboutyou'];
              addressC.text = data['address'];
              return Obx(() => SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Edit Profile",
                                style: GoogleFonts.oswald(
                                    textStyle: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(context).colorScheme.secondary)),
                              ),
                              ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(Theme.of(context).colorScheme.secondary),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          side: BorderSide.none),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_keyForm.currentState!.validate()) {
                                      print(profileImageUrl.value);
                                      print(idC.text);
                                      print(aboutC.text);
                                      print(resumeUrl.value);
                                      print(workList.toString());
                                      print(linksList.toString());
                                      print(contactsList.toString());
                                      print(skillsList.toString());
                                      print(address);
                                      _firestoreController.editProfile(
                                          profileImageUrl.value,
                                          idC.text,
                                          nameC.text,
                                          aboutC.text,
                                          resumeUrl.value,
                                          workList,
                                          linksList,
                                          contactsList,
                                          skillsList,
                                          address.value);
                                    }
                                  },
                                  child: Text(
                                    "Save",
                                    style: GoogleFonts.roboto(
                                        textStyle: TextStyle(
                                            color: Theme.of(context).colorScheme.primaryContainer,
                                            fontWeight: FontWeight.bold)),
                                  ))
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Form(
                              key: _keyForm,
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap: () async {
                                        final resultUrl =
                                            await firebaseStorageController
                                                .uploadProfileImage();
                                        if(resultUrl != ""){
                                          profileImageUrl.value = resultUrl!;
                                        }
                                        print(
                                            "current image url -> $profileImageUrl}");
                                      },
                                      child: Container(
                                        width: Get.width,
                                        height: 200,
                                        decoration: BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(
                                            profileImageUrl.value,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: idC,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "Enter Unique Id";
                                        }
                                      },
                                      decoration:
                                          txtfield1("User Id", "User Id",context),
                                      style: TextStyle(
                                        color: Theme.of(context).colorScheme.onSecondaryContainer
                                      ),
                                      cursorColor: Theme.of(context).colorScheme.onSecondaryContainer,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: nameC,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "Enter Your name";
                                        }
                                        if (v.length < 3) {
                                          return "Atleast name length must 3 characters";
                                        }
                                      },
                                      decoration: txtfield1("Name", "Name",context),
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSecondaryContainer
                                      ),
                                      cursorColor: Theme.of(context).colorScheme.onSecondaryContainer,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: aboutC,
                                      minLines: 4,
                                      maxLines: 6,
                                      validator: (v) {
                                        if (v!.isEmpty) {
                                          return "Write Your Interest";
                                        }
                                        if (v.length < 10) {
                                          return "Length must be 10 character";
                                        }
                                      },
                                      decoration:
                                          txtfield1("About You", "About You",context),
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSecondaryContainer
                                      ),
                                      cursorColor: Theme.of(context).colorScheme.onSecondaryContainer,
                                    ),
                                    ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(Theme.of(context).colorScheme.secondary)),
                                        onPressed: () async {
                                          resumeUrl.value =
                                              await firebaseStorageController
                                                  .uploadResumeFile();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.change_circle,color: Theme.of(context).colorScheme.primaryContainer,),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text("Change Resume",
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.primaryContainer,
                                            ),),
                                          ],
                                        )),
                                    Text(
                                      "Work Experience",
                                      style: GoogleFonts.roboto(
                                          textStyle: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                                          )),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          width: Get.width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.secondaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: ListView.builder(
                                              itemCount: workList.length,
                                              itemBuilder: (context, i) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      workList[i],
                                                      style: GoogleFonts.roboto(
                                                          textStyle:
                                                              TextStyle(
                                                                color: Theme.of(context).colorScheme.onSecondaryContainer
                                                              )),
                                                    ),
                                                    Divider(),
                                                  ],
                                                );
                                              }),
                                        ),
                                        Positioned(
                                          right: -13,
                                          top: -13,
                                          child: IconButton(
                                            onPressed: () {
                                              if (workList.isNotEmpty) {
                                                workList.removeLast();
                                              }
                                            },
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              size: 25,
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: workExpC,
                                      decoration: txtfield4("Experience", "Work Experience",
                                              () {
                                            if (workExpC.text.isNotEmpty) {
                                              workList.add(workExpC.text);
                                              workExpC.clear();
                                            }
                                          },context),
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSecondaryContainer
                                      ),
                                      cursorColor: Theme.of(context).colorScheme.secondary,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Links",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                                        ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          width: Get.width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.secondaryContainer,

                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: ListView.builder(
                                              itemCount: linksList.length,
                                              itemBuilder: (context, i) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      linksList[i],
                                                      style: GoogleFonts.roboto(
                                                          textStyle:
                                                              TextStyle(
                                                                  color: Theme.of(context).colorScheme.onSecondaryContainer
                                                              )),
                                                    ),
                                                    Divider(),
                                                  ],
                                                );
                                              }),
                                        ),
                                        Positioned(
                                          right: -13,
                                          top: -13,
                                          child: IconButton(
                                            onPressed: () {
                                              if (linksList.isNotEmpty) {
                                                linksList.removeLast();
                                              }
                                            },
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              size: 25,
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: linksC,
                                      decoration: txtfield4("Links", "Links", () {
                                        if (linksC.text.isNotEmpty) {
                                          linksList.add(linksC.text);
                                          linksC.clear();
                                        }
                                      },context),
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSecondaryContainer
                                      ),
                                      cursorColor: Theme.of(context).colorScheme.secondary,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Contacts",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                                        ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          width: Get.width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.secondaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: ListView.builder(
                                              itemCount: contactsList.length,
                                              itemBuilder: (context, i) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      contactsList[i],
                                                      style: GoogleFonts.roboto(
                                                          textStyle:
                                                              TextStyle(
                                                                  color: Theme.of(context).colorScheme.onSecondaryContainer
                                                              )),
                                                    ),
                                                    Divider(),
                                                  ],
                                                );
                                              }),
                                        ),
                                        Positioned(
                                          right: -13,
                                          top: -13,
                                          child: IconButton(
                                            onPressed: () {
                                              if (contactsList.isNotEmpty) {
                                                contactsList.removeLast();
                                              }
                                            },
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              size: 25,
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: contactC,
                                      decoration: txtfield4("Contacts", "Contacts",
                                              () {
                                            if (contactC.text.isNotEmpty) {
                                              contactsList.add(contactC.text);
                                              contactC.clear();
                                            }
                                          },context),
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSecondaryContainer
                                      ),
                                      cursorColor: Theme.of(context).colorScheme.secondary,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Skills",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                                        )
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Stack(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(2),
                                          width: Get.width,
                                          height: 100,
                                          decoration: BoxDecoration(
                                              color: Theme.of(context).colorScheme.secondaryContainer,
                                              borderRadius:
                                                  BorderRadius.circular(5)),
                                          child: ListView.builder(
                                              itemCount: skillsList.length,
                                              itemBuilder: (context, i) {
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      skillsList[i],
                                                      style: GoogleFonts.roboto(
                                                          textStyle:
                                                              TextStyle(
                                                                  color: Theme.of(context).colorScheme.onSecondaryContainer
                                                              )),
                                                    ),
                                                    Divider(),
                                                  ],
                                                );
                                              }),
                                        ),
                                        Positioned(
                                          right: -13,
                                          top: -13,
                                          child: IconButton(
                                            onPressed: () {
                                              if (skillsList.isNotEmpty) {
                                                skillsList.removeLast();
                                              }
                                            },
                                            icon: Icon(
                                              Icons.cancel_outlined,
                                              size: 25,
                                              color: Theme.of(context).colorScheme.secondary,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: skillC,
                                      decoration: txtfield4("Enter Skills", "Skills",
                                              () {
                                            if (skillC.text.isNotEmpty) {
                                              skillsList.add(skillC.text);
                                              skillC.clear();
                                            }
                                          },context),
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSecondaryContainer
                                      ),
                                      cursorColor: Theme.of(context).colorScheme.secondary,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Address",
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Theme.of(context).colorScheme.onSecondaryContainer,
                                        )
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      address.value,
                                      style: GoogleFonts.roboto(
                                          textStyle:
                                              TextStyle(color:Theme.of(context).primaryTextTheme.bodyText1!.color)),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    TextFormField(
                                      controller: addressC,
                                      decoration: txtfield4("Enter new Address",
                                          "Enter Adress", () {
                                            if (addressC.text.isNotEmpty) {
                                              address.value = addressC.text;
                                              addressC.clear();
                                            }
                                          },context),
                                      style: TextStyle(
                                          color: Theme.of(context).colorScheme.onSecondaryContainer
                                      ),
                                      cursorColor: Theme.of(context).colorScheme.secondary,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ));
            }
            return Center(
              child: Text("Waiting"),
            );
          }),
    );
  }
}
