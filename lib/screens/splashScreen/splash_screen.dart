import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:soundscape/screens/onboardingScreens/onboarding_screen.dart';

import '../../app_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Get.offAll(OnboardingScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      body: Center(
        child: ShaderMask(
          shaderCallback: (bounds) => appGradient().createShader(bounds),
          child: Text(
            'Forecasting',
            style: TextStyle(
              fontSize: screenWidth * 0.10, // Responsive font size
              fontWeight: FontWeight.bold,
              color: Colors.white, // Set color to white for the gradient effect
            ),
          ),
        ),
      ),
    );
  }
}
