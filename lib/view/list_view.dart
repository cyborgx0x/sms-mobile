import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sms_spam_detection/model/sqlite.dart';
import 'component/sms_card.dart';
import 'package:provider/provider.dart';
import 'state/page.dart';
import 'sample.dart';
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
    data = controllergetSMSbyPhone(currentPageState.CurrentConversationID);
    return FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [for (SMSItem sms in snapshot.data) SMSCard(sms)],
            );
          } else {
            List<SMSItem> ConversationData = [
              SMSItem.fromMap({
                "id": 34,
                "address": "9960748637",
                "sms":
                    "Tin nh\u1eafn s\u1ed1 34: Ch\u00fac m\u1eebng sinh nh\u1eadt!",
                "spam": 1
              })
            ];
            
            return ListView(
              children: [for (var sms in ConversationData) SMSCard(sms)],
            );
          }
        });
  }
}

class ConversationListView extends StatelessWidget {
  const ConversationListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    Map<String, SMSItem> ConversationData = {
      "Sample": SMSItem.fromMap({
        "id": 34,
        "address": "9960748637",
        "sms": "Tin nh\u1eafn s\u1ed1 34: Ch\u00fac m\u1eebng sinh nh\u1eadt!",
        "spam": true
      })
    };
    Future data;
    switch (currentPageState.current) {
      case "no_spam_list":
        data = getFilterConversationListDB("nospam");
        break;
      case "all_spam_list":
        data = getFilterConversationListDB("spam");
        break;
      default:
        data = getConversationListDB();
    }
    return FutureBuilder(
        future: data,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                for (var conversation in snapshot.data.entries)
                  ConversationTile(conversation)
              ],
            );
          } else {
            Map<String, SMSItem> ConversationData = {
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
                for (var conversation in ConversationData.entries)
                  ConversationTile(conversation)
              ],
            );
          }
        });
  }
}
