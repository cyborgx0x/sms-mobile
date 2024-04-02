import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
          "detail_sms": (context) => SMSDetailPage(
                senderName:
                    ModalRoute.of(context)?.settings.arguments as String,
              ),
          "all_sms": (context) => AllSMSPage(),
          "all_spam_list": (context) => SpamSMSListPage(),
        },
      ),
    );
  }
}

void main() async {
  runApp(const MyApp());
}
