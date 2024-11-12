// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:soundscape/firebase_options.dart';
// import 'package:soundscape/screens/HomeScreen.dart';
// import 'package:soundscape/screens/splashScreen/splash_screen.dart';

// void main()  async {

//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform
//   );
 
//   runApp(GetMaterialApp(
//     theme: ThemeData(
//       primaryColor: Colors.black,
//       brightness: Brightness.dark,
//       textTheme: GoogleFonts.wixMadeforTextTextTheme(),
//     ),
//     // home: OnboardingCommonScreen(),
//     home: SplashScreen(),
//   ));
// }


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soundscape/firebase_options.dart';
import 'package:soundscape/screens/homeScreens/HomeScreen.dart';
import 'package:soundscape/screens/sign_up_success.dart';
import 'package:soundscape/screens/splashScreen/splash_screen.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(Brightness.light),
      // home: SplashScreen(),
      home: SplashScreen(),
    );
  }
}

ThemeData _buildTheme(Brightness brightness) {
  var baseTheme = ThemeData(
    brightness: brightness,
    primaryColor: Colors.black,
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
  );
}
