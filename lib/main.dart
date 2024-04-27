import 'package:carmark/view/home_page.dart';
import 'package:carmark/view/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
main(){
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,

  ]);
  runApp( MyApp());
}
class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  ScreenUtilInit(
      splitScreenMode: true,
      minTextAdapt: true,
      designSize: Size(360, 960),
      builder: (context, child) {
        return MaterialApp(

            home: SplashScreen()
        );
      },
    );
  }
}
