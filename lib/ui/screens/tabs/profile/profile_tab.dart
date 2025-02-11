import 'package:evently_c13/providers/AuthProvider.dart';
import 'package:evently_c13/ui/screens/HomeScreen.dart';
import 'package:evently_c13/ui/screens/setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../providers/language_provider.dart';
import '../../../../providers/theme_provider.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {  String selectedLanguage = 'Arabic';
  String selectedTheme = 'Light';
  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context); 
       ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    LanguageProvider languageProvider = Provider.of<LanguageProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20,),
              Text(
                'Language',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: languageProvider.currentLocale,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      languageProvider.changeLocale(newValue);
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: "ar",
                      child: Text("Arabic"),
                    ),
                    DropdownMenuItem(
                      value: "en",
                      child: Text("English"),
                    ),
                  ],
                ),
              
            ),),),
              SizedBox(height: 20),
              Text(
                'Theme',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                child: DropdownButton<ThemeMode>(
                  value: themeProvider.currentTheme,
                  icon: Icon(Icons.arrow_drop_down, color: Colors.blue),
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                  onChanged: (ThemeMode? newValue) {
                    if (newValue != null) {
                      themeProvider.changeTheme(newValue);
                    }
                  },
                  items: [
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Text("Light"),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Text("Dark"),
                    ),
                  ],
                ),
              ),
           
              ),
              Spacer(),
           ElevatedButton(
              onPressed: () {
                authProvider.logout();
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  SetupScreen.routeName,
                  (route) => true,
                );
              },
              child: Text("logout")) ],
          
      ),
    );
  }
}
