import 'package:flutter/material.dart';

class SMSCard extends StatelessWidget {
  final Map sms;
  const SMSCard(this.sms, {super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        
        width: 300,
        child: Card(
          
          child: ListTile(
            leading: ExcludeSemantics(
              child: CircleAvatar(child: Icon(Icons.block)),
            ),
            title: Text(sms['sms']),
            subtitle: Text(sms['address']),
            onTap: handleTapping,
          ),
        ),
      ),
    );
  }

  void handleTapping() => print(sms);
}
