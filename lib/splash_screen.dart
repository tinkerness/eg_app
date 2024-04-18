import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

// SplashScreen Class
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// _SplashScreenState Class:
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      // Replace the next line with your desired screen navigation
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Login()),
      );
    });
  }

// build Method:
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/breathe.jpg"),
            fit: BoxFit.cover,
          ),
          // color:Color.fromRGBO(1, 1, 102, 0.979)
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                top: 290.0, // Adjust the top position as needed
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("images/logo.png"),
                      width: 200.0, // Adjust the width as needed
                      height: 200.0, // Adjust the height as needed
                    ),
                    SizedBox(
                        height:
                            10.0), // Adjust the spacing between image and text
                    // Text(
                    //   "Breathe Better \nLive Healthier \nMonitor Smarter",
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 18.0,
                    //   ),
                    // ),
                    Text(
                      "Breathe Better, \nLive Healthier, \nMonitor Smarter.",
                      style: GoogleFonts.pacifico(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
