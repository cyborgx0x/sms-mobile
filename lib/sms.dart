import 'package:telephony/telephony.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

backgroundMessageHandler(SmsMessage message) async {
  spamDetect("Test");
}

final Telephony telephony = Telephony.instance;

void topLevel() {
  telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        spamDetect(message.body);
      },
      onBackgroundMessage: backgroundMessageHandler);
}

Future<Result> spamDetect(String? sms) async {
  final response = await http.post(
    Uri.parse('https://sms.diopthe20.com/spam_detection/'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String?>{
      'content': sms,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    final result = Result.fromJson(jsonDecode(response.body));
    final String spam;
    if (result.score > 0.6) {
      spam = "true";
    } else {
      spam = "false";
    }
    const id = 1;
    const address = "089892827";
    const body =
        "Khu chung cu cao cap VinHome dang mo ban voi gia re nhat thi truong. Nhanh tay so huu can ho voi lai suat vay 0% trong 30 thang dau tien. Hotline 0888888888";
    final smsToBeSaved =
        SMSItem(id: id, address: address, body: body, spam: spam);
    return Result.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class SMSItem {
  final int id;
  final String address;
  final String body;
  final String spam;
  // final int date;
  // final int dateSent;
  // final bool read;
  // final bool seen;
  // final String subject;
  // final int subscriptionId;
  // final int threadId;
  // final SmsType type;
  // final SmsStatus status;
  // final String serviceCenterAddress;

  const SMSItem({
    required this.id,
    required this.address,
    required this.body,
    required this.spam,
    // required this.date,
    // required this.dateSent,
    // required this.read,
    // required this.seen,
    // required this.subject,
    // required this.subscriptionId,
    // required this.threadId,
    // required this.type,
    // required this.status,
    // required this.serviceCenterAddress,
  });
  void show() {
    print('ID is $id');
    print('adress is $address');
    print('body is $body');
    print('is this spam: $spam');
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'address': address,
      'body': body,
      'spam': spam,
    };
  }

  @override
  String toString() {
    return 'SMSItem{id: $id, address: $address, body: $body, spam: $spam}';
  }
}

class Result {
  final String label;
  final double score;

  const Result({required this.label, required this.score});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      label: json['label'],
      score: json['score'],
    );
  }
}
