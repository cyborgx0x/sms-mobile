// Copyright 2019 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/page.dart';

class SMSAppBar extends StatelessWidget {
  const SMSAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    var show;
    if (currentPageState.current == "detail_sms") {
      show = Row(
        children: [
          BackButton(
            onPressed: () =>
                currentPageState.changePage(currentPageState.previousPage),
          ),
          showTitle(),
        ],
      );
      return AppBar(title: show);
    } else {
      show = showTitle();
      return AppBar(
        title: show,
        actions: [
          IconButton(
            tooltip: "Tìm kiếm",
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () {},
          ),
        ],
      );
    }
  }
}

class showTitle extends StatelessWidget {
  const showTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var currentPageState = context.watch<PageState>();
    if (currentPageState.current == "detail_sms") {
      return Text(
        currentPageState.CurrentConversationID,
      );
    } else if (currentPageState.current == "no_spam_list") {
      return Text(
        "Hội thoại",
      );
    } else if (currentPageState.current == "all_spam_list") {
      return Text(
        "Hộp thư rác",
      );
    } else {
      return Text(
        "Tất cả hội thoại",
      );
    }
  }
}
