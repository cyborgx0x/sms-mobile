import 'package:flutter/widgets.dart';
import 'package:sms_spam_detection/model/sqlite.dart';
import 'package:sms_spam_detection/view/sample.dart';

importSample() async {
  var smsprovider = SMSProvider();
  WidgetsFlutterBinding.ensureInitialized();
  await smsprovider.open("D:/sms.db");
  SMSSample.forEach((element) {
    smsprovider.insert(SMSItem.fromMap(element));
  });
  var data = smsprovider.getAll();
  data.then((value) => value.forEach((element) {
        smsprovider.delete(element["id"]);
      }));
}

Future<List> controllerGetAll() async {
  var smsprovider = SMSProvider();
  WidgetsFlutterBinding.ensureInitialized();

  await smsprovider.open("D:/sms.db");
  return smsprovider.getAll();
}

Future<Map<String, SMSItem>> getConversationListDB() {
  Future<Map<String, SMSItem>> allSMS;
  allSMS = controllerGetAll().then((value) => processConversationList(value));
  return allSMS;
}

Map<String, SMSItem> processConversationList(value) {
  List sms = [];
  for (var item in value) {
    sms.add(SMSItem.fromMap(item));
  }
  return getConversationListCore(sms);
}

Map<String, SMSItem> getConversationListCore(allSMS) {
  Map<String, SMSItem> conversationList = {};
  for (SMSItem sms in allSMS) {
    if (conversationList.containsKey(sms.address)) {
      conversationList[sms.address] = sms;
    } else {
      conversationList[sms.address] = sms;
    }
  }
  return conversationList;
}

Future<Map<String, SMSItem>> getFilterConversationListDB(filter) {
  Future<Map<String, SMSItem>> allSMS;
  allSMS =
      controllerGetAll().then((value) => filterConversation(filter, value));
  return allSMS;
}

// Future<List> getSMSListDB(phone) {

// }

Map<String, SMSItem> filterConversation(filter, value) {
  Set phoneNumber = {};
  for (var item in value) {
    phoneNumber.add(item["address"]);
  }
  List allSMS = [];
  for (var item in value) {
    allSMS.add(SMSItem.fromMap(item));
  }
  Map<String, SMSItem> conversationList = getConversationListCore(allSMS);

  Set queue = {};

  for (var phone in phoneNumber) {
    var spam = false;
    for (var sms in value) {
      if (sms['spam'] == 1 && phone == sms['address']) {
        spam = true;
      }
    }
    if (spam) {
      queue.add(phone);
    }
  }

  if (filter == "nospam") {
    for (String item in queue) {
      conversationList.remove(item);
    }
    return conversationList;
  } else {
    Set spamList = phoneNumber.difference(queue);

    for (String item in spamList) {
      conversationList.remove(item);
    }
  }

  return conversationList;
}

Future<List> getSMSbyPhone(phoneNumber) async {
  var smsprovider = SMSProvider();
  WidgetsFlutterBinding.ensureInitialized();

  await smsprovider.open("D:/sms.db");
  return smsprovider.getSMSbyPhone(phoneNumber);
}

Future<List<SMSItem>> controllergetSMSbyPhone(phoneNumber) {
  Future<List<SMSItem>> allSMS;
  allSMS = getSMSbyPhone(phoneNumber).then((value) => processSMSList(value));
  return allSMS;
}

List<SMSItem> processSMSList(listSMS) {
  List<SMSItem> listSMSbyPhone = [];
  listSMS.forEach((element) {
    listSMSbyPhone.add(SMSItem.fromMap(element));
  });
  return listSMSbyPhone;
}

insertNewSMS(SMSItem sms) async {
  var smsprovider = SMSProvider();
  WidgetsFlutterBinding.ensureInitialized();
  await smsprovider.open("D:/sms.db");
  smsprovider.insert(sms);
  smsprovider.close();
}
