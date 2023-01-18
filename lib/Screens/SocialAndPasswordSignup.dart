import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio360/Controllers/SignupController.dart';
import '../Styles/Colors.dart';
import '../Styles/Txtfields.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _KeyForm = GlobalKey<FormState>();
    final emailC = TextEditingController();
    final passC = TextEditingController();
    SignupController signupController = Get.find();
    RxString errorMessage = "".obs;
    return Scaffold(
      body: Obx(()=> Form(
        key: _KeyForm,
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomRight,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.onPrimary
                  ]
              )
          ),
          width: Get.width,
          padding: EdgeInsets.only(left: 10,right: 10,top: 30),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Create Account",style: GoogleFonts.lobster(
                      textStyle: TextStyle(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.onPrimary
                      )
                  ),),
                  TextButton(onPressed: (){
                    signupController.signUpAsGuest();
                  }, child: Text("Skip",style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimary
                      )
                  ),)),
                ],
              ),
              SizedBox(height: 30,),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueGrey,blurRadius: 2,
                              offset: Offset(1,1)
                          ),
                        ]
                    ),
                    // height: 1000,
                    child: Column(
                      children: [
                        Text("SignUp",style: GoogleFonts.lobster(
                          fontSize: 30,
                          color: Theme.of(context).colorScheme.secondary,
                        ),),
                        SizedBox(height: 20,),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailC,
                          validator: (v){
                            if(v!.isEmpty){
                              return "Enter Your Email";
                            }
                            if(!v.isEmail){
                              return "Please enter right Email";
                            }
                          },
                          decoration: txtfield1("Email", "Email",context),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondaryContainer
                          ),
                          cursorColor: Theme.of(context).colorScheme.secondary,
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: passC,
                          validator: (v){
                            if(v!.isEmpty){
                              return "Enter Password";
                            }
                            if(v.length <=5){
                              return "Password length must be 6";
                            }
                          },
                          decoration: txtfield1("Choose a Password", "Password",context),
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondaryContainer
                          ),
                          cursorColor: Theme.of(context).colorScheme.secondary,
                        ),
                        Text(errorMessage.value,
                          style: TextStyle(
                              color: Color.fromARGB(190, 194, 3, 3),
                              fontWeight: FontWeight.bold,
                              fontSize: 18
                          ),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("Already have account?",style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                            ),),
                            TextButton(onPressed: (){
                              Get.toNamed('/EmailLogin');
                            }, child: Text("Sign In",style: TextStyle(
                              color: Colors.lightBlue,
                            ),)),
                          ],
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.secondary,
                                padding: EdgeInsets.all(10),
                            ),
                            onPressed: ()async{
                              if(_KeyForm.currentState!.validate()){
                                errorMessage.value = (await signupController.signUpWithPassword(emailC.text, passC.text))!;
                              }
                            }, child: Text("Register",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primaryContainer
                        ),)),
                        SizedBox(height: 30,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                maximumSize: Size(300, 50),
                                backgroundColor: Colors.blueAccent,
                                padding: EdgeInsets.all(10)
                            ),
                            onPressed: ()async{
                              if(await signupController.signUpWithFacebook()){
                                Get.offAllNamed('/CreateProfile');
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.facebook,size: 30,),
                                SizedBox(width: 20,),
                                Text("Continue with Facebook",style: GoogleFonts.roboto(
                                    fontSize: 20
                                ),),
                              ],
                            )
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                maximumSize: Size(300, 50),
                                backgroundColor: Colors.redAccent,
                                padding: EdgeInsets.all(10)
                            ),
                            onPressed: ()async{
                              if(await signupController.signUpWithGoogle()){
                                Get.offAllNamed('/CreateProfile');
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Image.asset('images/google.png'),
                                SizedBox(width: 20,),
                                Text("Continue with Google",style: GoogleFonts.roboto(
                                    fontSize: 20
                                ),),
                              ],
                            )
                        ),
                        SizedBox(height: 30,),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
