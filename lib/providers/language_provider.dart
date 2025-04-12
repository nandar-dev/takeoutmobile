import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier {
  int _selectedLanguageId = 1; 

  int get selectedLanguageId => _selectedLanguageId;

  void setLanguage(int id) {
    _selectedLanguageId = id;
    notifyListeners();
  }
}
