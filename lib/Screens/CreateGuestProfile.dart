import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Controllers/FirestoreController.dart';
import '../Styles/Colors.dart';
import '../Styles/Txtfields.dart';


class CreateGuestProfile extends StatelessWidget {
  const CreateGuestProfile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final nameC = TextEditingController();
    final _keyForm = GlobalKey<FormState>();
    FirestoreController _firestoreController = Get.find();
    return Scaffold(
      body:  SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Create Profile",
                    style: GoogleFonts.oswald(
                        textStyle: TextStyle(
                            fontSize: 27,
                            fontWeight: FontWeight.w600,
                            color: c1)),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(c1),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide.none),
                        ),
                      ),
                      onPressed: () async {
                        if (_keyForm.currentState!.validate()) {
                          await _firestoreController.createGuestProfile(nameC.text);
                        }
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.roboto(
                            textStyle: TextStyle(
                                color: w1,
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
                    padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}