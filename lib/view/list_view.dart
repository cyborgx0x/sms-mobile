import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'component/sms_card.dart';
import 'package:provider/provider.dart';
import 'state/page.dart';
import 'sample.dart';
import 'component/conversation_tile.dart';

class SMSListView extends StatelessWidget {
  const SMSListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    var smsList = getSMSList(currentPageState.CurrentConversationID);
    return ListView(
      children: [for (var sms in smsList) SMSCard(sms)],
    );
  }
}

class SMSSpamListView extends StatelessWidget {
  const SMSSpamListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var smsList = getSpamSMSList();
    return ListView(
      children: [for (var sms in smsList) SMSCard(sms)],
    );
  }
}

class AllSMSList extends StatelessWidget {
  const AllSMSList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var smsList = SMSSample;
    return ListView(
      children: [for (var sms in smsList) SMSCard(sms)],
    );
  }
}

class ConversationListView extends StatelessWidget {
  const ConversationListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    Map getData = {};
    switch (currentPageState.current) {
      case "no_spam_list":
        getData = getConversationList();
        break;
      case "all_spam_list":
        getData = getConversationList();
        break;
      case "all_sms_list":
        getData = getConversationList();
        break;
      default:
        getData = getConversationList();
    }

    return ListView(
      children: [
        for (var conversation in getData.entries) ConversationTile(conversation)
      ],
    );
  }
}
