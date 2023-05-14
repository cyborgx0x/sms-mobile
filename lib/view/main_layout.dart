import 'package:flutter/material.dart';
import 'component/app_drawer.dart';
import 'component/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sms_spam_detection/view/state/page.dart';
import 'list_view.dart';

class SMSHomePage extends StatelessWidget {
  const SMSHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();

    Widget page;
    switch (currentPageState.current) {
      case "detail_sms":
        page = SMSListView();
        break;
      default:
        page = ConversationListView();
    }
    var drawer;
    if (currentPageState.current == "detail_sms") {
      drawer = null;
    }
    else {
      drawer = SMSDrawer();
    }

    return Scaffold(
      
      drawer: drawer,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), //
        child: SMSAppBar(),
      ),
      body: Scrollbar(
        child: Center(
          child: page,
        ),
      ),
    );
  }
}


