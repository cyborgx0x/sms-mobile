import 'package:flutter/material.dart';
import 'component/sms.dart';
import 'component/appDrawer.dart';
import 'component/appBar.dart';
class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SMSDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), //
        child: SMSAppBar(),
      ),
      body: Scrollbar(
        child: Center(
          child: ListView(
            children: [
              for (var i = 0; i < 10; i++) 
                CardExample(i)
            ],
          ),
        ),
      ),
    );
  }
}
