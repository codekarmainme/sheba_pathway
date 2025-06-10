import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signout/signout_bloc.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signout/signout_event.dart';
import 'package:sheba_pathway/bloc/auth_bloc/signout/signout_state.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/screens/login_screen.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});
  void _signOut(BuildContext context) {
    context.read<SignOutBloc>().add(SignOutRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black2,
      appBar: AppBar(
        title: Text(
          'Settings',
          style: mediumText.copyWith(
              color: whiteColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: black2,
        centerTitle: true,
        iconTheme: IconThemeData(color: whiteColor),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          ListTile(
            leading: Icon(Icons.brightness_6, color: successColor),
            title: Text(
              'Light Theme',
              style: normalText.copyWith(color: whiteColor),
            ),
            trailing: Switch(
              activeColor: successColor,
              value: false,
              onChanged: (value) {},
            ),
          ),
          const Divider(),

          ListTile(
            leading: Icon(Icons.language, color: successColor),
            title: Text(
              'Language',
              style: normalText.copyWith(color: whiteColor),
            ),
            trailing: Text(
              'English',
              style: normalText.copyWith(color: whiteColor.withOpacity(0.7)),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.notifications, color: successColor),
            title: Text(
              'Notifications',
              style: normalText.copyWith(color: whiteColor),
            ),
            trailing: Switch(
              activeColor: successColor,
              value: true,
              onChanged: (value) {},
            ),
          ),
          const Divider(),

          ListTile(
            leading: Icon(Icons.person, color: successColor),
            title: Text(
              'Account Settings',
              style: normalText.copyWith(color: whiteColor),
            ),
            onTap: () {},
          ),
          const Divider(),

          ListTile(
            leading: Icon(Icons.privacy_tip, color: successColor),
            title: Text(
              'Privacy Policy',
              style: normalText.copyWith(color: whiteColor),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.info, color: successColor),
            title: Text(
              'About',
              style: normalText.copyWith(color: whiteColor),
            ),
            onTap: () {},
          ),
          const Divider(),
          ListTile(
            leading: Icon(Icons.help, color: successColor),
            title: Text(
              'Help & Support',
              style: normalText.copyWith(color: whiteColor),
            ),
            onTap: () {},
          ),
          const Divider(),

          ListTile(
            leading: Icon(Icons.article, color: successColor),
            title: Text(
              'Terms & Conditions',
              style: normalText.copyWith(color: whiteColor),
            ),
            onTap: () {
              // Placeholder callback
            },
          ),
          const Divider(),

          // Logout
          BlocConsumer<SignOutBloc, SignOutState>(listener: (context, state) {
            if (state is SignOutLoading) {
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
            if (state is SignOutSuccess) {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            }
          }, builder: (context, sate) {
            return ListTile(
              leading: Icon(Icons.logout, color: errorColor),
              title: Text(
                'Logout',
                style: normalText.copyWith(color: errorColor),
              ),
              onTap: () {
                _signOut(context);
              },
            );
          }),
        ],
      ),
    );
  }
}
