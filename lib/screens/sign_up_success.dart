import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:soundscape/screens/signupAndLogin/login_screen.dart';

class SignUpSuccess extends StatefulWidget {
  const SignUpSuccess({super.key});

  @override
  State<SignUpSuccess> createState() => _SignUpSuccessState();
}

class _SignUpSuccessState extends State<SignUpSuccess> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            SvgPicture.asset("assets/images/signupSucc.svg"),
            InkWell(
                child: Text("< Back to Login"),
                onTap: () {
                  Get.offAll(LoginScreen());
                })
          ],
        ),
      ),
    );
  }
}
