import 'package:flutter/material.dart';
import 'component/app_drawer.dart';
import 'component/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:sms_spam_detection/view/state/page.dart';
import 'list_view.dart';
import 'detail_view.dart';

class SMSHomePage extends StatelessWidget {
  const SMSHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();

    Widget page;
    switch (currentPageState.current) {
      case "no_spam_list":
        page = SMSListView();
        break;
      case "all_spam_list":
        page = PageView();
        break;
      case "all_sms_list":
        page = PageView();
        break;
      case "detail_sms":
        page = SMSDetailView();
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


