import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio360/Styles/Colors.dart';

Widget cont1(BuildContext context,List acceptList,String userId,String image,String name, String uniqueId,Function() request,String requestStatus){
  FirebaseAuth _auth = Get.find();
  return InkWell(
    onTap: (){
      if(acceptList.contains(_auth.currentUser!.uid)){
        Get.toNamed('/ViewProfile',arguments: userId);
      }
      else{
        Fluttertoast.showToast(msg: "Send Request for Profile view");
      }
    },
    child: Container(
      width: Get.width,
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          SizedBox(width: 5,),
          CircleAvatar(
            radius: 25,
            child: ClipOval(
              child: Image.network(image,fit: BoxFit.cover,width: 200,height: 200,),
            ),
          ),
          SizedBox(width: 15,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(name,style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSecondaryContainer
                ),
              ),),
              SizedBox(height: 6,),
              Text(uniqueId,style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey
                  )
              ),),
            ],
          )),
          TextButton(onPressed: request, child: Text(requestStatus,style: GoogleFonts.roboto(
            textStyle: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold,
            )
          ),))
        ],
      ),
    ),
  );
}