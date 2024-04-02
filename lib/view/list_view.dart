import 'package:flutter/material.dart';
import 'package:sms_spam_detection/model/sqlite.dart';
import 'component/sms_card.dart';
import 'package:provider/provider.dart';
import 'state/page.dart';
import 'component/conversation_tile.dart';
import '../controller/data.dart';

class SMSListView extends StatelessWidget {
  const SMSListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    Future data;
    data = controllergetSMSbyPhone(currentPageState.currentConversationID);
    return FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (SMSItem sms in snapshot.data) SMSCard(sms, Icon(Icons.sms))
              ],
            );
          } else {
            List<SMSItem> conversationData = [
              SMSItem.fromMap({
                "id": 34,
                "address": "9960748637",
                "sms":
                    "Tin nh\u1eafn s\u1ed1 34: Ch\u00fac m\u1eebng sinh nh\u1eadt!",
                "spam": 1
              })
            ];

            return ListView(
              children: [
                for (var sms in conversationData) SMSCard(sms, Icon(Icons.sms))
              ],
            );
          }
        });
  }
}

class ConversationListView extends StatelessWidget {
  final Future<Map<String, SMSItem>> conversationList;
  const ConversationListView({super.key, required this.conversationList});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: conversationList,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (var conversation in snapshot.data.entries)
                  ConversationTile(conversation)
              ],
            );
          } else {
            Map<String, SMSItem> conversationData = {
              "Sample": SMSItem.fromMap({
                "id": 34,
                "address": "9960748637",
                "sms":
                    "Tin nh\u1eafn s\u1ed1 34: Ch\u00fac m\u1eebng sinh nh\u1eadt!",
                "spam": true
              })
            };
            return ListView(
              children: [
                for (var conversation in conversationData.entries)
                  ConversationTile(conversation)
              ],
            );
          }
        });
  }
}
