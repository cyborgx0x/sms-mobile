// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/page.dart';
// Press the Navigation Drawer button to the left of AppBar to show
// a simple Drawer with two items.
class SMSDrawer extends StatelessWidget {
  const SMSDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    final drawerHeader = UserAccountsDrawerHeader(
      accountName: Text("Xin chào Thuan Nguyen"),
      accountEmail: Text(
        "leeboykt@gmail.com",
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
            currentPageState.changePage(0);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "Spam",
          ),
          leading: const Icon(Icons.comment),
          onTap: () {
            currentPageState.changePage(1);
            Navigator.pop(context);
          },
        ),
        ListTile(
          title: Text(
            "Tất cả hội thoại",
          ),
          leading: const Icon(Icons.comment),
          onTap: () {
            currentPageState.changePage(2);
            Navigator.pop(context);
          },
        ),
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }
}
