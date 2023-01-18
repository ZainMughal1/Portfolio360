import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio360/Controllers/SignupController.dart';
import 'package:portfolio360/Controllers/ThemeChangerController.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  ThemeChanger _themeChanger = Get.find();
  SignupController _signupController = Get.find();
  GetStorage _storage = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10, top: 15, bottom: 5, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Setting",
                      style: GoogleFonts.oswald(
                          textStyle: TextStyle(
                              fontSize: 27,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.secondary)),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text("Switch Theme"),
                trailing: Switch(
                    // value: _themeChanger.getstatus,
                  value: _storage.read('darkMode'),
                    onChanged: (v){
                      switch_Theme();
                    }
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  _signupController.SignOut();
                },
                title: Text("Logout"),
                trailing: Icon(Icons.logout),
              ),
            ],
          ),
        ),
      ),
    );
  }

  switch_Theme(){
    _themeChanger.changeTheme();
    Get.changeTheme(_themeChanger.getThemeData);
    print(_themeChanger.getstatus);
    setState(() {

    });
  }
}
