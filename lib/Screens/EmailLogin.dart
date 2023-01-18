import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio360/Controllers/LoginController.dart';
import 'package:portfolio360/Controllers/ThemeChangerController.dart';

import '../Styles/Colors.dart';
import '../Styles/Txtfields.dart';

class EmailLogin extends StatelessWidget {
  const EmailLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _KeyForm = GlobalKey<FormState>();
    final emailC = TextEditingController();
    final passC = TextEditingController();
    LoginController loginController = Get.find();
    RxString errorMessage = "".obs;
    ThemeChanger _themeChanger = Get.find();
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _KeyForm,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomRight,
                    colors: [Theme.of(context).colorScheme.primary, Colors.white])),
            height: Get.height,
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey,
                            blurRadius: 2,
                            offset: Offset(1, 1)),
                      ]),
                  child: Column(
                    children: [
                      Text(
                        "Sign In",
                        style: GoogleFonts.lobster(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: emailC,
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter Your Email";
                          }
                          if (!v.isEmail) {
                            return "Please enter right Email";
                          }
                        },
                        decoration: txtfield1("Email", "Email",context),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSecondaryContainer
                        ),
                        cursorColor: Theme.of(context).colorScheme.secondary,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: passC,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Enter Password";
                          }
                          if (v.length <= 5) {
                            return "Password length must be 6";
                          }
                        },
                        decoration: txtfield1("Choose a Password", "Password",context),
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondaryContainer
                        ),
                        cursorColor: Theme.of(context).colorScheme.secondary,
                      ),
                      Obx(() => Text(errorMessage.value,style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Don't have account?",style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondaryContainer,
                          ),),
                          TextButton(onPressed: () {
                            Get.toNamed('/SocialLogin');
                          }, child: Text("Sign Up",style: TextStyle(
                            color: Colors.lightBlue,
                          ),)),
                        ],
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.secondary,
                              padding: EdgeInsets.all(10),
                              ),
                          onPressed: () async {
                            if (_KeyForm.currentState!.validate()){
                              errorMessage.value = (await loginController.loginInWithPassword(emailC.text, passC.text))!;
                            }
                          },
                          child: Text("Sign In",style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.primaryContainer,
                              fontSize: 20, fontWeight: FontWeight.bold
                          ),)),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
