// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/page.dart';
import 'back_button.dart';
class SMSAppBar extends StatelessWidget {
  const SMSAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    if (currentPageState.current == "detail_sms") {
      
    }
    else {

    }
    return AppBar(
        title: navigatedStateButton(),
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
              ];
            },
          )
        ],
      );
  }
}

class navigatedStateButton extends StatelessWidget {
  const navigatedStateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "SMS DEFENDER",
    );
  }
}

