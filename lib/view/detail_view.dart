import 'package:flutter/material.dart';
import 'package:sms_spam_detection/view/main_layout.dart';
import 'package:sms_spam_detection/view/component/sms_card.dart';

class SMSDetailView extends StatelessWidget {

  const SMSDetailView(
    
    {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    
    return ListView(
      children: [
        for (var i = 0; i < 10; i++) 
          CardExample()
      ],
    );
  }
}