import 'package:flutter/material.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: heading5.copyWith(color: Colors.white),
        ),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Theme Switch
          ListTile(
            leading: Icon(Icons.brightness_6, color: primaryColor),
            title: Text(
              'Light Theme',
              style: normalText.copyWith(color: black2),
            ),
            trailing: Switch(
              value: false, // Placeholder value
              onChanged: (value) {}, // Placeholder callback
            ),
          ),
          const Divider(),

          // Language Selection
          ListTile(
            leading: Icon(Icons.language, color: primaryColor),
            title: Text(
              'Language',
              style: normalText.copyWith(color: black2),
            ),
            trailing: Text(
              'English', // Placeholder value
              style: normalText.copyWith(color: black2.withOpacity(0.7)),
            ),
            onTap: () {
              // Placeholder callback
            },
          ),
          const Divider(),

          // Notifications
          ListTile(
            leading: Icon(Icons.notifications, color: primaryColor),
            title: Text(
              'Notifications',
              style: normalText.copyWith(color: black2),
            ),
            trailing: Switch(
              value: true, // Placeholder value
              onChanged: (value) {}, // Placeholder callback
            ),
          ),
          const Divider(),

          // Account Settings
          ListTile(
            leading: Icon(Icons.person, color: primaryColor),
            title: Text(
              'Account Settings',
              style: normalText.copyWith(color: black2),
            ),
            onTap: () {
              // Placeholder callback
            },
          ),
          const Divider(),

          // Privacy Policy
          ListTile(
            leading: Icon(Icons.privacy_tip, color: primaryColor),
            title: Text(
              'Privacy Policy',
              style: normalText.copyWith(color: black2),
            ),
            onTap: () {
              // Placeholder callback
            },
          ),
          const Divider(),

          // About
          ListTile(
            leading: Icon(Icons.info, color: primaryColor),
            title: Text(
              'About',
              style: normalText.copyWith(color: black2),
            ),
            onTap: () {
              // Placeholder callback
            },
          ),
          const Divider(),

          // Help & Support
          ListTile(
            leading: Icon(Icons.help, color: primaryColor),
            title: Text(
              'Help & Support',
              style: normalText.copyWith(color: black2),
            ),
            onTap: () {
              // Placeholder callback
            },
          ),
          const Divider(),

          // Terms & Conditions
          ListTile(
            leading: Icon(Icons.article, color: primaryColor),
            title: Text(
              'Terms & Conditions',
              style: normalText.copyWith(color: black2),
            ),
            onTap: () {
              // Placeholder callback
            },
          ),
          const Divider(),

          // Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text(
              'Logout',
              style: normalText.copyWith(color: Colors.red),
            ),
            onTap: () {
              // Placeholder callback
            },
          ),
        ],
      ),
    );
  }
}