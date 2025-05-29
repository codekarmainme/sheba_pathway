import 'package:flutter/material.dart';
import 'package:sheba_pathway/common/colors.dart';
import 'package:sheba_pathway/common/typography.dart';
import 'package:sheba_pathway/main.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLanguage = 'English';

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'am', 'name': 'አማርኛ'},
    {'code': 'es', 'name': 'Español'},
    {'code': 'ar', 'name': 'العربية'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButton<String>(
        value: _selectedLanguage,
        icon: Icon(Icons.language, color: black2),
        iconSize: 15,
        elevation: 16,
        style: normalText.copyWith(color: black2),
        borderRadius: BorderRadius.circular(10),
        underline: SizedBox(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedLanguage = newValue;
            });
            // Find the language code
            final selected =
                _languages.firstWhere((lang) => lang['name'] == newValue);
            // Change the app's locale
            Locale newLocale = Locale(selected['code']!);
            // This will rebuild the app with the new locale
            // (You must wrap your MaterialApp with a builder that listens to locale changes)
            // The following line works if you use a locale provider or similar approach:
            // context.findAncestorStateOfType<YourAppState>()?.setLocale(newLocale);
            // Or, if you use a callback:
            // widget.onLocaleChanged?.call(newLocale);

            // For demonstration, here's a common approach:
            MyApp.setLocale(context, newLocale);
          }
        },
        items: _languages.map<DropdownMenuItem<String>>((lang) {
          return DropdownMenuItem<String>(
            value: lang['name'],
            child:
                Text(lang['name']!, style: normalText.copyWith(color: black2)),
          );
        }).toList(),
      ),
    );
  }
}
