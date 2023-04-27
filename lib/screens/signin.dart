import 'package:firebasesample/screens/signup.dart';
import 'package:firebasesample/utils/utilities.dart';
import 'package:flutter/material.dart';

import '../services/auth.dart';
import '../utils/color_themes.dart';
import '../utils/constants.dart';
import '../widgets/custom_login_buton.dart';
import '../widgets/textfield.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthenticationService authenticationService = AuthenticationService();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
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
                  Container(
                    height: screenSize.height / 3,
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
                          "Sign-In",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 33),
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
                             /* Future.delayed(
                                const Duration(
                                  seconds: 5,
                                ),
                              );*/
                              String output =
                                  await authenticationService.logonAccount(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              setState(() {
                                isLoading = false;
                              });
                              if (output == "success") {
                              } else {
                                Utilities().showSnackBar(
                                  context: context,
                                  content: output,
                                );
                              }
                            },
                            child: const Text(
                              "Sign In",
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
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "New to Amazon",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 1,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  CustomLoginButton(
                    child: const Text(
                      "Create an  Account",
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
                            return const SignUpScreen();
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
