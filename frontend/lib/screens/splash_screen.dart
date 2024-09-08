import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beauty_salon/screens/home_screen.dart';
import 'package:beauty_salon/main.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2500), () {
      //exit full-screen
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.transparent,
          statusBarColor: Colors.white));

        //navigate to homescreen
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => HomeScreen()));

    });
  }

  @override
  Widget build(BuildContext context) {
    //initializing media query (for getting device screen size)
    mq = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Stack(
        children: [
          // App logo
          Positioned(
            top: mq.height * .20, // Adjust the top position if needed
            width: mq.width * .6, // Increased the width
            left: mq.width * .2, // Adjust the left position accordingly
            height: mq.width * .6, // Increased the height
            child: Image.asset('assets/images/logo-1.png'),
          ),
        ],
      ),
    );

  }
}