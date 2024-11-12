import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soundscape/app_constants.dart';
import 'package:soundscape/controllers/login_signup_controller.dart';
import 'package:soundscape/model/user_model.dart';
import 'package:soundscape/screens/sign_up_success.dart';
import 'package:soundscape/screens/signupAndLogin/login_screen.dart';
import 'package:soundscape/utility/app_colors.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginSignupController controller = LoginSignupController();
  bool _isPasswordVisible = false;
  String _selectedCountry = 'India';
  String _countryCode = '+91'; // Default country code for United States

  // Country codes mapping
  final Map<String, String> countryCodes = {
    'India': '+91',
    'United States': '+1',
    'Canada': '+1',
    
  };

  @override
  void initState() {
    super.initState();
    // Initialize the phone number field without any default country code
    _phoneNumberController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: SizedBox(
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AutoSizeText(
                    maxLines: 2,
                    "Enter your email address and password",
                    style: AppTextStyle.largeBold.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 16,
                    )),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: size.height * 0.04),

                      // Full Name Field
                      TextFormField(
                        controller: _fullNameController,
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Full name is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Phone Number Field
                      TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          prefixText: _countryCode, // Display the country code
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone number is required';
                          } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                            return 'Enter a valid phone number';
                          } else if (value.length != 10) {
                            return 'Enter 10 digits';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Country Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedCountry,
                        decoration: InputDecoration(
                          labelText: "Country",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        items: countryCodes.keys
                            .map((country) => DropdownMenuItem(
                                  child: Text(country),
                                  value: country,
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCountry = value!;
                            _countryCode = countryCodes[value]!;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Country is required';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                              .hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Password is required';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters long';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: size.height * 0.04),

                      // Signup Button
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            UserModel userData = UserModel(
                                fullname: _fullNameController.value.text,
                                phone: _phoneNumberController.value.text,
                                country: _selectedCountry,
                                email: _emailController.value.text,
                                password: _passwordController.value.text);
                            bool isSignedIn =
                                await controller.signupFunction(userData);
                            if (isSignedIn == true) {
                              Get.to(SignUpSuccess());
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          // primary: Colors.grey,
                        ),
                        child: Center(
                          child: AutoSizeText(
                            'Signup',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: size.height * 0.02),

                      // Login Redirect
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AutoSizeText("Already have an Account? "),
                    GestureDetector(
                      onTap: () {
                        Get.to(LoginScreen());
                      },
                      child: AutoSizeText(
                        "Login",
                        style: TextStyle(
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.bold,
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
    );
  }
}
