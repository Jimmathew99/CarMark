import 'package:carmark/view/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carmark/view/welcome_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,

    ]);
    super.initState();
    _navigateToNextScreen();
  }

  Future<void> _navigateToNextScreen() async {

    await Future.delayed(Duration(seconds: 7), () {
      logInCheck(context);
    },);
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => WelcomeScreen(),), (route) => false);

  }

  Future logInCheck(BuildContext context) async {
    if (user != null) {
      Get.offAll(() => const HomePage(), transition: Transition.cupertino);
    } else {
      Get.offAll(() => const WelcomeScreen(), transition: Transition.cupertino);
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.indigo, Colors.white]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Lottie.asset('animations/projectanim.json'),
              width: 500.w,
              height: 300.h,
            ),
          ],
        ),
      ),
    );
  }
}
