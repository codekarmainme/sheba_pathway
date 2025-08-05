import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sheba_pathway/bloc/auth_bloc/login/login_bloc.dart';
import 'package:sheba_pathway/bloc/auth_bloc/login/login_event.dart';
import 'package:sheba_pathway/bloc/auth_bloc/login/login_state.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/signup_screen.dart';
import 'package:sheba_pathway/screens/welcome_screen.dart';
import 'package:sheba_pathway/widgets/language_selector.dart';
import 'package:sheba_pathway/l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sheba_pathway/widgets/loading_progress.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
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
          child:
              BlocConsumer<LoginBloc, LoginState>(listener: (context, state) {
            if (state is LoginloadingState) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return loadingProgress(context);
                },
              );
            } else {
              Navigator.of(context, rootNavigator: true).pop();
            }
            if (state is LoginSucessState) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => WelcomeScreen()));
            }
            if (state is LoginErrorState) {
              print(state.error);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  state.error,
                  style: normalText.copyWith(color: errorColor),
                ),
              ));
            }
          }, builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width*0.6,
                        child: Text(
                          AppLocalizations.of(context)!.welcomeBack,
                          style: heading5.copyWith(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                    LanguageSelector(),
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
                        _textfield(AppLocalizations.of(context)!.email, Icons.email_outlined,
                            emailController, false),
                        _textfield( AppLocalizations.of(context)!.password, Icons.lock_outline,
                            passwordController, true),
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
                                  Text(AppLocalizations.of(context)!.rememberMe,
                                      style: normalText.copyWith(
                                          color: Colors.black, fontSize: 12))
                                ],
                              ),
                              Text(
                                AppLocalizations.of(context)!.forgotPassword,
                                style: normalText.copyWith(
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (emailController.text.isEmpty ||
                                passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!.pleaseFillAllFields,
                                  style: normalText.copyWith(color: errorColor),
                                ),
                              ));
                              return;
                            }
                            context.read<LoginBloc>().add(LoginSubmitEvent(
                                emailController.text, passwordController.text));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.7,
                            height: 50,
                            child: Center(
                                child: Text(
                               AppLocalizations.of(context)!.signIn,
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
                        onPressed: () {
                          context.read<LoginBloc>().add(SigninWithGoogle());
                        },
                        icon:
                            Icon(FontAwesomeIcons.google, color: Colors.black),
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
                      AppLocalizations.of(context)!.dontHaveAccount,
                      style:
                          GoogleFonts.sora(color: Colors.white, fontSize: 12),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupScreen()));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.signUpHere,
                          style: GoogleFonts.sora(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _textfield(String hintText, IconData icon,
      TextEditingController controller, bool ispassword) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 40,
        child: TextField(
          style: normalText.copyWith(color: Colors.black),
          controller: controller,
          obscureText: ispassword,
          decoration: InputDecoration(
              hintText: hintText,
              hintStyle: normalText.copyWith(color: Colors.grey),
              prefixIcon: Icon(icon, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor, width: 1)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor, width: 1)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: primaryColor, width: 1))),
        ),
      ),
    );
  }
}
