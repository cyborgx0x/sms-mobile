import 'package:flutter/material.dart';
import 'component/sms.dart';
import 'component/appDrawer.dart';
import 'component/appBar.dart';
import 'package:provider/provider.dart';
import 'package:sms_spam_detection/view/state/page.dart';


class SMSHomePage extends StatelessWidget {
  const SMSHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();

    Widget page;
    switch (currentPageState.current) {
      case 0:
        page = SMSListView();
        break;
      case 1:
        page = PageView();
        break;
      case 2:
        page = PageView();
        break;
      default:
        throw UnimplementedError('no widget');
    }
    return Scaffold(
      drawer: SMSDrawer(),
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

class SMSListView extends StatelessWidget {
  const SMSListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        for (var i = 0; i < 10; i++) 
          CardExample(i)
      ],
    );
  }
}

