import 'package:flutter/material.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signup/signup_bloc.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signup/signup_event.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signup/signup_state.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/login_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(listener: (context, state) {
      if(state is SignupLoading){
        showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: LoadingAnimationWidget.discreteCircle(
              color: successColor,
              secondRingColor: warningColor,
              thirdRingColor: errorColor,
              size: 50,
            ),
          );
        },
      );
      }
      else {
      Navigator.of(context, rootNavigator: true).pop();
    }
      if (state is SignupSucesss) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "You have successfully signed up",
          style: normalText.copyWith(color: successColor),
        )));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }
      if (state is SignupError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          state.error,
          style: normalText.copyWith(color: errorColor),
        )));
      }
    }, builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      AppLocalizations.of(context)!.start_unforgettable_trips,
                      style: heading5.copyWith(
                          fontWeight: FontWeight.bold, color: black2),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("assets/images/sheba.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                ),
                _textfield(AppLocalizations.of(context)!.username, Icons.person_2, usernameController,false),
                _textfield(AppLocalizations.of(context)!.email, Icons.email_outlined, emailController,false,),
                _textfield(AppLocalizations.of(context)!.password, Icons.lock, passwordController,true),
                _textfield(
                   AppLocalizations.of(context)!.confirm_password, Icons.lock, confirmPasswordController,true),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (usernameController.text.isEmpty ||
                        emailController.text.isEmpty ||
                        passwordController.text.isEmpty ||
                        confirmPasswordController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        AppLocalizations.of(context)!.pleaseFillAllFields,
                        style: normalText.copyWith(color: errorColor),
                      )));
                      return;
                    }
                    if (passwordController.text.trim() !=
                        confirmPasswordController.text.trim()) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                        AppLocalizations.of(context)!.password_does_not_match,
                        style: normalText.copyWith(color: errorColor),
                      )));
                      return;
                    }
                    context.read<SignupBloc>().add(SignupSubmit(
                        emailController.text.trim(),
                        passwordController.text.trim()));
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    height: 50,
                    child: Center(
                        child: Text(
                      AppLocalizations.of(context)!.sign_up,
                      style: mediumText.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    )),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.do_you_have_account,
                      style: normalText.copyWith(),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.sign_in_here,
                          style:
                              normalText.copyWith(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _textfield(
      String hintText, IconData icon, TextEditingController controller, bool ispassword) {
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
            prefixIcon: Icon(
              icon,
              color: Colors.grey,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
