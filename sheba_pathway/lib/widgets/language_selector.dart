import 'package:flutter/material.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';

class LanguageSelector {
  String _selectedLanguage = 'English'; // Default language

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'am', 'name': 'አማርኛ'},
    {'code': 'fr', 'name': 'Français'},
    {'code': 'es', 'name': 'Español'},
    {'code': 'zh', 'name': '中文'},
    {'code': 'ar', 'name': 'العربية'},
  ];

  Widget languageWidget() {
    return Container(
       padding: const EdgeInsets.symmetric(horizontal: 8.0),
       height: 30,
    decoration: BoxDecoration(
      color: Colors.white, // Background color for the button
      borderRadius: BorderRadius.circular(8), // Rounded corners
    ),
      child: DropdownButton<String>(
        value: _selectedLanguage,
        icon:  Icon(
          Icons.language,
          color: black2,
        ),
        iconSize: 15,
        elevation: 16,
        style: normalText.copyWith(
          color: black2,
        ),
       borderRadius:BorderRadius.circular(10) ,
        onChanged: (String? newValue) {},
        items:
            _languages.map<DropdownMenuItem<String>>((Map<String, String> lang) {
          return DropdownMenuItem<String>(
            value: lang['name'],
            child: Text(
              lang['name']!,
              style: normalText.copyWith(color: black2),
            ),
          );
        }).toList(),
      ),
    );
  }
}
