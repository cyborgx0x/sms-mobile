// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

// Press the Navigation Drawer button to the left of AppBar to show
// a simple Drawer with two items.
class SMSDrawer extends StatelessWidget {
  const SMSDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("Bonjour!!!"),
      accountEmail: Text(
        "abc@diopthe20.com",
      ),
      currentAccountPicture: const CircleAvatar(
        child: FlutterLogo(size: 42.0),
      ),
    );
    final drawerItems = ListView(
      children: [
        drawerHeader,
        ListTile(
          title: Text(
            "Hội thoại",
          ),
          leading: const Icon(Icons.favorite),
          onTap: () {
            Navigator.pushNamed(context, "/");
          },
        ),
        ListTile(
          title: Text(
            "Spam",
          ),
          leading: const Icon(Icons.block),
          onTap: () {
            Navigator.pushNamed(context, "all_spam_list");
          },
        ),
        ListTile(
          title: Text(
            "Tất cả hội thoại",
          ),
          leading: const Icon(Icons.miscellaneous_services),
          onTap: () {
            Navigator.pushNamed(context, "all_sms");
          },
        ),
        ListTile(
            title: Text("Test Sender Name"),
            leading: const Icon(Icons.comment),
            onTap: () {
              Navigator.pushNamed(context, "detail_sms",
                  arguments: "abc@diopthe20.com");
            })
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }
}
