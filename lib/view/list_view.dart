import 'package:flutter/material.dart';
import 'component/sms_card.dart';

class SMSListView extends StatelessWidget {
  const SMSListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < 10; i++) 
          CardExample(i)
      ],
    );
  }
}