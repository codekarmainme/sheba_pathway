import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/signup_screen.dart';
import 'package:sheba_pathway/screens/welcome_screen.dart';
import 'package:sheba_pathway/widgets/language_selector.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: primaryColor, // Change this to your desired color
        statusBarIconBrightness: Brightness.light, // or Brightness.dark
      ),
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: primaryColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Welcome back!",
                      style: heading5.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                  LanguageSelector().languageWidget(),
                ],
              ),
              
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.8,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(children: [
                      Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/images/sheba.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      _textfield("email", Icons.email_outlined),
                      _textfield("password", Icons.lock_outline),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox.adaptive(
                                  value: false,
                                  onChanged: (value) => {},
                                  side: BorderSide(
                                    color: primaryColor,
                                    width: 1,
                                  ),
                                  activeColor: primaryColor,
                                ),
                                Text("Remember me",
                                    style: normalText.copyWith(
                                        color: Colors.black, fontSize: 12))
                              ],
                            ),
                            Text(
                              "Forgot password?",
                              style: normalText.copyWith(
                                  color: Colors.black, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => WelcomeScreen()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          height: 50,
                          child: Center(
                              child: Text(
                            "Sign in",
                            style: mediumText.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          )),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      )
                    ])),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.facebook_outlined, color: Colors.black),
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.apple_outlined, color: Colors.black),
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.white),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.facebook, color: Colors.black),
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.white),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.sora(color: Colors.white, fontSize: 12),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignupScreen()));
                      },
                      child: Text(
                        "Sign up here",
                        style: GoogleFonts.sora(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _textfield(String hintText, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        child: TextField(
          style: normalText.copyWith(color: Colors.black),
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: normalText.copyWith(color: Colors.grey),
              prefixIcon: Icon(icon, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: primaryColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: primaryColor, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(color: primaryColor, width: 1))),
        ),
      ),
    );
  }
}
