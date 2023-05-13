import 'package:flutter/material.dart';

class PageState extends ChangeNotifier {

  var current = 0;

  void changePage(index) {
    current = index;
    notifyListeners();
  }
}