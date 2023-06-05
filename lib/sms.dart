import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'controller/data.dart';
import 'package:sms_spam_detection/model/sqlite.dart';

backgroundMessageHandler(SmsMessage message) async {
  spamDetect(message);
}

final Telephony telephony = Telephony.instance;

void topLevel() {
  telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        Future result = spamDetect(message);
        bool spam = false;
        result.then(
          (value) {
            print(value["label"]);
            print(value["score"]);
            if (value["label"] == "spam" && value["score"] > 0.8) {
              spam = true;
            }
            gettheSMS(message).then((value) => insertNewSMS(SMSItem(
                value.id?.toInt() ?? 0,
                value.address?.toString() ?? "no adress",
                value.body?.toString() ?? "no content",
                spam)));
          },
        );
      },
      onBackgroundMessage: backgroundMessageHandler);
}

Future<void> spamDetect(SmsMessage sms) async {
  final response = await http.post(
    Uri.parse('https://sv.diopthe20.com/spam_detection/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'content': sms.body.toString(),
    }),
  );
  // SMSItem smsToInsert = SMSItem(id, address, sms, spam)
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to connect with server');
  }
}

Future<SmsMessage> gettheSMS(message) async {
  print(message.date.toString());
  // await Future.delayed(Duration(seconds: 5));
  List<SmsMessage> messages = await telephony.getInboxSms(
      columns: [
        SmsColumn.ADDRESS,
        SmsColumn.BODY,
        SmsColumn.THREAD_ID,
        SmsColumn.ID,
        SmsColumn.DATE,
        SmsColumn.DATE_SENT,
      ],
      filter: SmsFilter.where(SmsColumn.DATE_SENT)
          .equals(message.date.toString())
          .and(SmsColumn.ADDRESS)
          .equals(message.address.toString()));

  return messages.first;
}

Future<void> checkSpamAllSMS() async {
  List<SmsConversation> conversations = await telephony.getConversations();
  for (SmsConversation sms in conversations) {
    List<SmsMessage> messages = await telephony.getInboxSms(
        columns: [
          SmsColumn.ADDRESS,
          SmsColumn.BODY,
          SmsColumn.THREAD_ID,
          SmsColumn.ID,
          SmsColumn.DATE,
          SmsColumn.DATE_SENT,
        ],
        filter: SmsFilter.where(SmsColumn.THREAD_ID)
            .equals(sms.threadId.toString()));
    for (SmsMessage s in messages) {
      spamDetect(s);
    }
  }
}
