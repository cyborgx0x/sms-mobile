import 'package:flutter/material.dart';
import 'component/sms.dart';
class AppBarExample extends StatelessWidget {
  const AppBarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(Icons.menu),
          onPressed: () {},
        ),
        title: Text(
          "SMS DEFENDER",
        ),
        actions: [
          IconButton(
            tooltip: "Favorite",
            icon: const Icon(
              Icons.favorite,
            ),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "Tìm kiếm",
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
          PopupMenuButton<Text>(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  child: Text(
                    "Đánh dấu spam",
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    "COPY",
                  ),
                ),
                PopupMenuItem(
                  child: Text(
                    "Không làm gì",
                  ),
                ),
              ];
            },
          )
        ],
      ),
      body: Scrollbar(
        child: Center(
          child: ListView(
            children: [
              for (var i = 0; i < 10; i++) 
                CardExample()
            ],
          ),
        ),
      ),
    );
  }
}
