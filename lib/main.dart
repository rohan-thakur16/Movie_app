
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:movie_api/screens/home_screen.dart';



void main() {
  runApp( MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Assignment',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Assignment',
        home: AnimatedSplashScreen(
            duration: 2000,
            splash: 'assets/images/sm_icon.png',
            nextScreen: HomePage(),
            splashTransition: SplashTransition.rotationTransition,
            // pageTransitionType: PageTransitionType.scale,
            backgroundColor: Colors.blueGrey));
  }
}
