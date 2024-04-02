import 'package:flutter/material.dart';
import 'package:sms_spam_detection/model/sqlite.dart';
import 'component/sms_card.dart';
import 'package:provider/provider.dart';
import 'state/page.dart';
import 'component/conversation_tile.dart';
import '../controller/data.dart';

class SMSListView extends StatelessWidget {
  const SMSListView({super.key});

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    Future<List<SMSItem>> data = controllergetSMSbyPhone(currentPageState
        .currentConversationID); // Assuming this returns a Future<List<SMSItem>>

    return FutureBuilder<List<SMSItem>>(
      future: data,
      builder: (BuildContext context, AsyncSnapshot<List<SMSItem>> snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          // Display a loading indicator while the future is not yet resolved
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // If the future completed with an error, display an error message
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          // Once the data is available, display the list if it is not empty
          return ListView(
            children: snapshot.data!
                .map((sms) => SMSCard(sms, Icon(Icons.sms)))
                .toList(),
          );
        } else {
          // Handle both no data and empty list scenarios
          return Center(child: Text('No messages found.'));
        }
      },
    );
  }
}

class ConversationListView extends StatelessWidget {
  final Future<Map<String, SMSItem>> conversationList;

  const ConversationListView({super.key, required this.conversationList});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, SMSItem>>(
        future: conversationList,
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, SMSItem>> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            // Display a loading indicator while the future is not yet resolved
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // If the future completed with an error, display an error message
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Once the data is available, display the list
            return ListView(
              children: snapshot.data!.entries
                  .map((conversation) => ConversationTile(conversation))
                  .toList(),
            );
          } else {
            // This block covers the case where there is no error, the future is complete, but there is no data
            // For example, when the data is an empty list/map
            return Center(child: Text('No conversations found.'));
          }
        });
  }
}
