import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_spam_detection/view/state/page.dart';

class ConversationTile extends StatelessWidget {
  final MapEntry conversation;
  ConversationTile(this.conversation, {super.key});

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    return Center(
      child: ListTile(
        leading: ExcludeSemantics(
          child: CircleAvatar(child: Icon(Icons.person)),
        ),
        title: Text(conversation.key),
        subtitle: Text(conversation.value.sms),
        onTap: () {
          
          currentPageState.changePage("detail_sms");
          currentPageState.changeSMS(conversation.key);
        },
      ),
    );
  }

}
