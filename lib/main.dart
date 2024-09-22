import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nextyenna/screens/home.dart';
import 'package:splashify/splashify.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Makes the status bar transparent
      statusBarIconBrightness: Brightness.dark, // Sets icon color for status bar
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NextYenna',
      home: Splashify(
        imagePath: "lib/assets/images/list.png",
        child: Home(), 
        title: "NextYenna",
        titleFadeIn: true,
        backgroundColor: Color(0xFFffe5ec),
        colorizeTitleAnimation: true,
        navigateDuration: 2,),
    );
  }
}