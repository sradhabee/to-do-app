import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_to_do_app/utils/app_sessions.dart';


import 'package:new_to_do_app/view/splash_screen/splash_screen.dart';


Future <void> main()async{
await Hive.initFlutter();
var box = await Hive.openBox(AppSessions.TASKBOX);
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:SplashScreen(),

    );
  }
}
