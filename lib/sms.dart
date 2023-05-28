import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'controller/data.dart';
import 'model/sqlite.dart';

backgroundMessageHandler(SmsMessage message) async {
  spamDetect(message.body);
}

final Telephony telephony = Telephony.instance;

void topLevel() {
  telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        print(message.body);
        spamDetect(message.body);
      },
      onBackgroundMessage: backgroundMessageHandler);
}

Future<void> spamDetect(String? sms) async {
  final response = await http.post(
    Uri.parse('https://sms.diopthe20.com/spam_detection/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String?>{
      'content': sms,
    }),
  );
  // SMSItem smsToInsert = SMSItem(id, address, sms, spam)
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed to connect with server');
  }
}

Future<void> checkSpamAllSMS() async {
  List<SmsConversation> conversations = await telephony.getConversations();
  for (SmsConversation sms in conversations) {
    List<SmsMessage> messages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.THREAD_ID],
        filter: SmsFilter.where(SmsColumn.THREAD_ID)
            .equals(sms.threadId.toString()));
    for (SmsMessage s in messages) {
      spamDetect(s.body);
    }
  }
}
