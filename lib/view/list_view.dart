import 'package:flutter/material.dart';
import 'component/sms_card.dart';
import 'package:provider/provider.dart';
import 'state/page.dart';
import 'sample.dart';
class SMSListView extends StatelessWidget {
  const SMSListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    var smsList = getSMSList(currentPageState.CurrentConversationID);
    return ListView(
      children: [
        for (var sms in smsList) 
          SMSCard(sms)
      ],
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
      children: [
        for (var sms in smsList) 
          SMSCard(sms)
      ],
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
      children: [
        for (var sms in smsList) 
          SMSCard(sms)
      ],
    );
  }
}
