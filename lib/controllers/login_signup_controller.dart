import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:soundscape/model/user_model.dart';
import 'package:soundscape/utility/app_colors.dart';

class LoginSignupController extends GetxController {
  Future<bool> signupFunction(UserModel userData) async {
    try {
      UserCredential response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userData.email.trim(), password: userData.password);

      print('User created successfully: ${response.user!.uid}');
      Get.snackbar(
        'Signup Successfull',
        "Welcome new user",
        backgroundColor: AppColors.backgroundWhite,
        snackPosition: SnackPosition.TOP,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      switch (e.code) {
        case 'weak-password':
          errorMessage =
              'The password is too weak. Please choose a stronger password.';
          break;
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;

        default:
          errorMessage =
              'An unexpected error occurred. Please try again later.';
      }

      Get.snackbar(
        'Signup Error',
        errorMessage,
        backgroundColor: AppColors.backgroundRed,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (error) {
      print('An unexpected error occurred: $error');
      return false;
    }
  }

  // Login function
  Future<bool> loginFunction(UserModel userData) async {
    try {
      // Attempt user login with email and password
      UserCredential response =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: userData.email.trim(), // Ensure email is trimmed
              password: userData.password);

      // Handle successful login
      print('User logged in successfully: ${response.user!.uid}');
      Get.snackbar(
        'Login Successfull',
        "Welcome back, ${response.user!.email}",
        backgroundColor: AppColors.backgroundWhite,
        snackPosition: SnackPosition.TOP,
      );
      return true;
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for this email address.';
          break;
        case 'wrong-password':
          errorMessage = 'The password is incorrect.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;

        default:
          errorMessage =
              'An unexpected error occurred. Please try again later.';
      }

      Get.snackbar(
        'Login Error',
        errorMessage,
        backgroundColor: AppColors.backgroundRed,
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (error) {
      print('An unexpected error occurred: $error');
      return false;
    }
  }
}
