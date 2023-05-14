import 'package:flutter/material.dart';

class PageState extends ChangeNotifier {

  var current = "no_spam_list";
  var CurrentConversationID = '5555555555';

  void changeSMS(index) {
    CurrentConversationID = index;
    notifyListeners();
  }
  void changePage(index) {
    current = index;
    notifyListeners();
  }
}