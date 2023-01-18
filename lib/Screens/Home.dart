import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio360/Controllers/FirestoreController.dart';
import 'package:portfolio360/Controllers/SignupController.dart';
import 'package:portfolio360/Screens/EditProfile.dart';
import 'package:portfolio360/Screens/SettingScreen.dart';
import 'package:portfolio360/Screens/ShowAccepted.dart';
import 'package:portfolio360/Screens/ShowRequest.dart';
import 'package:portfolio360/Screens/exitApp.dart';
import 'package:portfolio360/Screens/SearchProfile.dart';
import 'package:portfolio360/Screens/SocialAndPasswordSignup.dart';
import '../Styles/Colors.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime BackPressTime = DateTime.now();
  int _selectedIndex = 1;
  FirebaseAuth _auth = Get.find();
  void changePage(n) {
    setState(() {
      if(n==0 && _auth.currentUser!.isAnonymous){
        Fluttertoast.showToast(msg: "No Guest Profile");
      }
      else if(n==2 && _auth.currentUser!.isAnonymous){
        Fluttertoast.showToast(msg: "No Guest Request");
      }
      else if(n==3 && _auth.currentUser!.isAnonymous){
        Fluttertoast.showToast(msg: "No Guest Accept");
      }
      else{
        _selectedIndex = n;
      }
    });
  }

  static List? _widgetOptions;

  printUserId() async {
    if (await _auth.currentUser != null) {
      print("UID => ${await _auth.currentUser!.uid}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    printUserId();
    _widgetOptions = [
      EditProfile(),
      SearchProfile(),
      ShowRequest(),
      ShowAccept(),
      SettingScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        child: SafeArea(
          child: _widgetOptions!.elementAt(_selectedIndex),
        ),
        onWillPop: exiteApp,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.red,
        // selectedFontSize: 14,
        // selectedItemColor: Theme.of(context).colorScheme.onSecondaryContainer,
        // unselectedItemColor: Theme.of(context).colorScheme.secondaryContainer,
        // selectedLabelStyle: GoogleFonts.roboto(),
        // unselectedFontSize: 13,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                size: 24,
              ),
              label: "Profile"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              size: 24,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.request_page), label: "Request"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.mobile_friendly,
              size: 24,
            ),
            label: "Accepted",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.settings,
              size: 24,
            ),
            label: "Setting",
          ),
        ],
        iconSize: 25,
        currentIndex: _selectedIndex,
        onTap: changePage,
      ),
    );
  }

  Future<bool> exiteApp() {
    print("exite app");
    DateTime now = DateTime.now();
    if(now.difference(BackPressTime)< Duration(seconds: 2)){
      return Future(() => true);
    }
    else{
      BackPressTime = DateTime.now();
      Fluttertoast.showToast(msg: "Press agin");
      return Future(()=> false);
    }
  }
}
