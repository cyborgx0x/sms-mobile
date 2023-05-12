// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

class AppBarDemo extends StatelessWidget {
  const AppBarDemo({super.key});

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
          "SPAM SMS DEFENDER",
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
      body: Center(
        child: Text(
          "need localization",
        ),
      ),
    );
  }
}
