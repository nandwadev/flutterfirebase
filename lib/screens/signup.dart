import 'dart:developer';

import 'package:firebasesample/screens/signin.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../utils/utilities.dart';
import '../widgets/custom_login_buton.dart';
import '../widgets/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  AuthenticationService authenticationService = AuthenticationService();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utilities().screenSize();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 43),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    amazonLogo,
                    //height: screenSize.height * 0.10,
                    height: screenSize.height / 10,
                  ),
                  SizedBox(
                    height: screenSize.height * 0.7,
                    child: FittedBox(
                      child: Container(
                        height: screenSize.height * .85,
                        width: screenSize.width * 0.8,
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                          bottom: 3,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 33),
                            ),
                            TextEditingWidget(
                              title: "First Name",
                              controller: firstNameController,
                              obscureText: false,
                              hintText: "Enter your first name",
                            ),
                            TextEditingWidget(
                              title: "Last Name",
                              controller: lastNameController,
                              obscureText: false,
                              hintText: "Enter your last name",
                            ),
                            TextEditingWidget(
                              title: "Phone",
                              controller: phoneController,
                              obscureText: false,
                              hintText: "Enter your phone number",
                            ),
                            TextEditingWidget(
                              title: "Email",
                              controller: emailController,
                              obscureText: false,
                              hintText: "Enter your email",
                            ),
                            TextEditingWidget(
                              title: "Password",
                              controller: passwordController,
                              obscureText: true,
                              hintText: "Enter your password",
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: CustomLoginButton(
                                color: yellowColor,
                                isLoading: isLoading,
                                onPressed: () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  String output = await authenticationService
                                      .registerAccount(
                                    firstName: firstNameController.text,
                                    lastName: lastNameController.text,
                                    phone: phoneController.text,
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                  setState(() {
                                    isLoading = false;
                                  });
                                  if (output == "success") {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => const SignInScreen(),
                                      ),
                                    );
                                    /*log(
                                      "next please",
                                    );*/
                                  } else {
                                    Utilities().showSnackBar(
                                      context: context,
                                      content: output,
                                    );
                                    /*log(
                                      output,
                                    );*/
                                  }

                                  /* setState(() {
                                      isLoading = false;
                                    });
                                    if (output == "success") {
                                    } else {
                                      Utils().showSnackBar(
                                          context: context, content: output);
                                    }*/
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(
                                    letterSpacing: 0.6,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  CustomLoginButton(
                    child: const Text(
                      "Login to your  Account",
                      style: TextStyle(
                        letterSpacing: 0.6,
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.grey[400]!,
                    isLoading: false,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SignInScreen();
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
