import 'package:flutter/material.dart';


class ConversationTile extends StatelessWidget {
  final Map sms;
  const ConversationTile(this.sms, {super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListTile(
        leading: ExcludeSemantics(
          child: CircleAvatar(child: Icon(Icons.favorite)),
        ),
        title: Text(sms['sms']),
        subtitle: Text(sms['address']),
        onTap: handleTapping,
      ),
    );
  }

  void handleTapping() => print(sms);
}
