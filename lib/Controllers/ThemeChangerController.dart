import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio360/Styles/Colors.dart';
import 'package:get_storage/get_storage.dart';
class ThemeChanger extends GetxController{
  GetStorage _storage = Get.find();
  bool _flag = true;
  iniTheme()async{
    if(await _storage.read('darkMode') != null){
      _flag =await _storage.read('darkMode');
    }
    else{
      await _storage.write('darkMode', _flag);
    }
    Get.changeTheme(getThemeData);
  }
  changeTheme()async{
    _flag = !_flag;
    await _storage.write('darkMode',_flag);
  }
  bool get getstatus => _flag;
  ThemeData get getThemeData => _flag? _ligntTheme: _darkTheme;
  ThemeData get getlightTheme => _ligntTheme;
  ThemeData get getdarkTheme => _darkTheme;

  final ThemeData _ligntTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryTextTheme: const TextTheme(
      bodyText1: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      labelMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    ),
    listTileTheme: ListTileThemeData(
      textColor: c1,
      iconColor: c1,
    ),
    switchTheme: SwitchThemeData(
      thumbColor:  MaterialStateProperty.all<Color>(c1),
      trackColor:  MaterialStateProperty.all<Color>(c2),
    ),
    colorScheme:ColorScheme(
      brightness: Brightness.light,
      primary: c1,
      onPrimary: Colors.white,
      secondary: c1,
      onSecondary: Colors.red,
      error: Colors.red,
      onError: Colors.red,
      surface: w1,
      onSurface: Colors.red,
      background: Colors.red,
      onBackground: Colors.red,
      primaryContainer: Colors.white,
      onPrimaryContainer: c1,
      secondaryContainer: Color.fromARGB(100, 210, 213, 213),
      onSecondaryContainer: Colors.black54,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: w1,
      selectedIconTheme: IconThemeData(
        color: c1,
      ),
      selectedItemColor: c1,
      unselectedIconTheme: IconThemeData(
        color: Colors.black45,
      ),
      unselectedItemColor: Colors.black45,
    )
  );



  final ThemeData _darkTheme = ThemeData(

    scaffoldBackgroundColor: c2,
    primaryTextTheme: const TextTheme(
      bodyText1: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
      labelMedium: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: Colors.black54,
      ),
    ),
    listTileTheme: ListTileThemeData(
      textColor: w1,
      iconColor: w1,
    ),
    switchTheme: SwitchThemeData(
      thumbColor:  MaterialStateProperty.all<Color>(w1),
      trackColor:  MaterialStateProperty.all<Color>(c3),
    ),
    colorScheme:ColorScheme(
      brightness: Brightness.light,
      primary: c2,
      onPrimary: w1,
      secondary: w1,
      onSecondary: Colors.red,
      error: Colors.red,
      onError: Colors.red,
      surface: c3,
      onSurface: Colors.red,
      background: Colors.red,
      onBackground: Colors.red,
      primaryContainer: c2,
      onPrimaryContainer: c3,
      secondaryContainer: c3,
      onSecondaryContainer: w1
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: c2,
        selectedIconTheme: IconThemeData(
          color: c3,
        ),
        selectedItemColor: c3,
        unselectedIconTheme: IconThemeData(
          color: w1,
        ),
        unselectedItemColor: w1,
      )
  );
}