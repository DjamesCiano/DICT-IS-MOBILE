import 'package:flutter/material.dart';
import 'dart:async';
import 'package:inventory_system/main.dart';
import 'package:inventory_system/receiving_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 3 seconds
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ReceivingScreen(),
        ), // Replace with your main screen
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Watermark positioned in bottom-left, revealing only 1/4
          Positioned(
            left: -screenWidth * 0.20, // Move left to show only 1/4
            bottom: -screenHeight * 0.30, // Move down to show only 1/4
            child: Opacity(
              opacity: 0.1, // Adjust watermark opacity
              child: Image.asset(
                'assets/dict_logo.png',
                width: screenWidth * 1.2, // Cover 75% of width
              ),
            ),
          ),

          // Centered Column Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Logo Image
                Image.asset(
                  'assets/dict_logo.png',
                  width: 150, // Adjust size
                ),
                SizedBox(height: 20), // Space between images
                // Name Image
                Image.asset(
                  'assets/dict_name.png',
                  width: 200, // Adjust size
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
