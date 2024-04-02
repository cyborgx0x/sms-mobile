import 'package:flutter/material.dart';
import 'package:sms_spam_detection/controller/data.dart';
import 'component/app_drawer.dart';
import 'list_view.dart';

class SMSHomePage extends StatelessWidget {
  const SMSHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = getFilterConversationListDB("nospam");

    return Scaffold(
      drawer: SMSDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), //
        child: AppBar(
          title: Text("Tin nhắn"),
          actions: [
            IconButton(
              tooltip: "Tìm kiếm",
              icon: const Icon(
                Icons.search,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Scrollbar(
        child: Center(
          child: ConversationListView(conversationList: data),
        ),
      ),
    );
  }
}

class AllSMSPage extends StatelessWidget {
  const AllSMSPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = getConversationListDB();
    return Scaffold(
      appBar: AppBar(
        title: Text("Hội thoại"),
      ),
      body: Scrollbar(
          child: Center(
        child: ConversationListView(conversationList: data),
      )),
    );
  }
}

class SpamSMSListPage extends StatelessWidget {
  const SpamSMSListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = getFilterConversationListDB("spam");

    return Scaffold(
        appBar: AppBar(
          title: Text("Spam"),
        ),
        body: Scrollbar(
            child: Center(
          child: ConversationListView(conversationList: data),
        ))
        // Your widget's body goes here.
        );
  }
}

class SMSDetailPage extends StatelessWidget {
  // Add a final String field to hold the sender's name.
  final String senderName;

  // Update the constructor to require this parameter.
  const SMSDetailPage({super.key, required this.senderName});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // Use the senderName to dynamically set the title.
        title: Text(senderName),
      ),
      body: SMSListView(),
      // Your widget's body goes here.
    );
  }
}
