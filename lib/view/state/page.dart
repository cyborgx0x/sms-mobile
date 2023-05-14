import 'package:flutter/material.dart';

class PageState extends ChangeNotifier {

  var current = "home";

  void changePage(index) {
    current = index;
    notifyListeners();
  }
}