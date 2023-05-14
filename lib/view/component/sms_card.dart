import 'package:flutter/material.dart';
import 'package:sms_spam_detection/model/sqlite.dart';
class SMSCard extends StatelessWidget {
  final Map sms;
  const SMSCard(this.sms, {super.key});
  @override
  Widget build(BuildContext context) {
    var icon;
    if (sms['spam'] == false) {
      icon = Icons.sms;
    }
    else {
      icon = Icons.block;
    }
    return Center(
      child: SizedBox(
        
        width: 300,
        child: Card(
          
          child: ListTile(
            leading: ExcludeSemantics(
              child: CircleAvatar(child: Icon(icon)),
            ),
            title: Text(sms['sms']),
            subtitle: Text(sms['address']),
            onTap: handleTapping,
          ),
        ),
      ),
    );
  }

  void handleTapping() {
    // var sampleSMS = getSMS1();
    // sampleSMS.then((value) => print(value.toString()));
  }
}
