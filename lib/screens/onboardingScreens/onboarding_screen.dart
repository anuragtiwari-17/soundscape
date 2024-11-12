import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soundscape/app_constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:soundscape/screens/signupAndLogin/login_screen.dart';

import '../../utility/my_elevated_button.dart';
import '../signupAndLogin/signup_screen.dart';

class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(gradient: appGradient()),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Top section with SVG image and gradient background
              Expanded(
                flex: 4,
                child: SizedBox(
                  width: size.width,
                  child: SvgPicture.asset(
                    fit: BoxFit.cover,

                    'assets/images/World.svg',
                    height:
                        size.height * 0.3, // Adjust height based on screen size
                    allowDrawingOutsideViewBox: true,
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(size.height * 0.02),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.06,
                              vertical: size.height * 0.02),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // Title and description
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AutoSizeText(
                                    'Explore global map of wind, weather, and ocean conditions',
                                    style: AppTextStyle.largeBold
                                        .copyWith(color: Colors.black),
                                    maxLines: 2,
                                  ),
                                  SizedBox(height: size.height * 0.015),
                                  AutoSizeText(
                                    'Planning your trip becomes easier with the Ideate weather app. You can instantly see the whole world\'s weather within a few seconds.',
                                    style: AppTextStyle.smallRegular.copyWith(
                                        fontSize: size.width * 0.035,
                                        letterSpacing: 0.9),
                                    maxLines: 4,
                                  ),
                                ],
                              ),
                              // Bottom buttons
                              Column(
                                children: [
                                  MyElevatedButton(
                                    width: size.width,
                                    onPressed: () {
                                      Get.to(SignUpScreen());
                                    },
                                    borderRadius: BorderRadius.circular(15),
                                    child: Text(
                                      "Get Started",
                                      style: AppTextStyle.smallRegular.copyWith(
                                        color: Colors.white,
                                        fontSize: size.width * 0.035,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  TextButton(
                                    onPressed: () {
                                      Get.to(LoginScreen());
                                    },
                                    child: Text(
                                      'Already have an account? Log in',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: size.width * 0.035,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
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
