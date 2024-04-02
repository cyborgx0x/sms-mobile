import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sms_spam_detection/view/list_view.dart';
import 'view/main_layout.dart';
import 'view/state/page.dart';
import 'sms.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    topLevel();
    // checkSpamAllSMS();
    return ChangeNotifierProvider(
      create: (context) => PageState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: SMSHomePage(),
        routes: {
          "detail_sms": (context) => SMSHomePage(),
          "no_spam_list": (context) => MainSMSLayout(),
          "all_spam_list": (context) => SMSHomePage(),
        },
      ),
    );
  }
}

void main() async {
  runApp(const MyApp());
}
