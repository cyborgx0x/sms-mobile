
import 'package:flutter/material.dart';

class PageState extends ChangeNotifier {

  var currentConversationID = '5555555555';
  var previousPage = "";

  void changeSMS(index) {
    currentConversationID = index;
    notifyListeners();
  }


}