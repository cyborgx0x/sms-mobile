import 'package:flutter/material.dart';

class PageState extends ChangeNotifier {
  
  var current = "no_spam_list";
  var CurrentConversationID = '5555555555';
  var previousPage = "";

  void changeSMS(index) {
    CurrentConversationID = index;
    notifyListeners();
  }
  void changePage(index) {
    previousPage = current;
    current = index;
    notifyListeners();
  }
}