import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:new_to_do_app/view/home_screen/home_screen.dart';
import 'package:new_to_do_app/utils/animation_constants.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomeScreen(),)));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset(AnimationConstants.splash_logo) ,
      ),
      
    );
  }
}