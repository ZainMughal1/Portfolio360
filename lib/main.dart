import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:portfolio360/Bindings/InitBindings.dart';
import 'package:portfolio360/Controllers/ThemeChangerController.dart';
import 'package:portfolio360/Screens/CreateGuestProfile.dart';
import 'package:portfolio360/Screens/CreateProfile.dart';
import 'package:portfolio360/Screens/EditProfile.dart';
import 'package:portfolio360/Screens/EmailLogin.dart';
import 'package:portfolio360/Screens/Home.dart';
import 'package:portfolio360/Screens/SocialAndPasswordSignup.dart';
import 'package:portfolio360/Screens/ViewProfile.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Get.lazyPut(() => GetStorage());
  Get.put(ThemeChanger());
  Get.put(FirebaseAuth.instance);
  ThemeChanger().iniTheme();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeChanger _themeChanger = Get.find();
    // ThemeChanger().iniTheme();
    FirebaseAuth _auth = Get.find();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeChanger.getlightTheme,
      darkTheme: _themeChanger.getdarkTheme,
      themeMode: ThemeMode.light,
      title: 'Portfolio 360',
      initialBinding: InitBindings(),
      initialRoute: _auth.currentUser == null? '/EmailLogin':'/Home',
      routes: {
        '/SocialLogin': (context) => SocialLogin(),
        '/Home': (context) => Home(),
        '/ViewProfile': (context) => ViewProfile(),
        '/EmailLogin': (context) => EmailLogin(),
        '/CreateProfile': (context) => CreateProfile(),
        '/CreateGuestProfile': (context) => CreateGuestProfile(),
        '/EditProfile': (context) => EditProfile(),
      },
    );
  }
}