import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:portfolio360/Controllers/SignupController.dart';


Widget exitScreen(){
  SignupController _signupController = Get.find();
  return Center(
    child: TextButton(
      onPressed: (){
        _signupController.SignOut();
        SystemNavigator.pop();
      },
      child: Text("Do you Want to Exit"),
    ),
  );
}
