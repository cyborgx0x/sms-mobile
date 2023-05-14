import 'package:flutter/widgets.dart';
import 'package:sms_spam_detection/model/sqlite.dart';

Future<SMSItem> getSMS1() async {
  var smsprovider = SMSProvider();
  WidgetsFlutterBinding.ensureInitialized();

  await smsprovider.open("D:/sms.db");
  // for (var sms in SMSSample) {
  //   var smsToInsert = SMSItem.fromMap(sms);
  //   smsprovider.insert(smsToInsert);
  // }
  var sampleSMS = smsprovider.getSMSItem(1);
  return sampleSMS;
}

Future<List<Map<String, Object?>>> controllerGetAll() async {
  var smsprovider = SMSProvider();
  WidgetsFlutterBinding.ensureInitialized();

  await smsprovider.open("D:/sms.db");
  var allSMS = smsprovider.getAll();
  return allSMS;
}

Future<Map> getConversationListDB() {
  var getAllSMS = controllerGetAll();
  var allSMS;
  allSMS =  getAllSMS.then((value) => getConversationListCore(value.iterator));
  return allSMS;
}

Map getConversationListCore(allSMS) {
  var conversationList = {};
  for (var sms in allSMS) {
    if (conversationList.containsKey(sms['address'])) {
      conversationList[sms['address']] = sms;
    } else {
      conversationList[sms['address']] = sms;
    }
  }
  return conversationList;
}
