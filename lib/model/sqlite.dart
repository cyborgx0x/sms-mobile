import 'package:sqflite/sqflite.dart';
import 'package:sms_spam_detection/view/sample.dart';
import 'package:flutter/widgets.dart';

const String tableSMSItem = 'smsitem';
const String columnId = 'id';
const String columnSMS = 'sms';
const String columnAddress = 'address';
const String columnSpam = 'spam';

class SMSItem {
  late int id;
  late String address;
  late bool spam;
  late String sms;

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      columnSMS: sms,
      columnAddress: address,
      columnSpam: spam == true ? 1 : 0
    };

    map[columnId] = id;
    return map;
  }

  SMSItem(this.id, this.address, this.sms, this.spam);

  SMSItem.fromMap(Map map) {
    id = map[columnId];
    sms = map[columnSMS];
    address = map[columnAddress];
    spam = map[columnSpam] == 1;
  }
  @override
  String toString() {
    // TODO: implement toString
    return "id: %id, sms: $sms, address: $address, spam: $spam";
  }
}

class SMSProvider {
  var db;

  Future open(String path) async {
    print(path);
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
create table smsitem ( 
  id integer primary key, 
  sms text not null,
  address text not null,
  spam integer not null)
''');
    });
  }

  Future<SMSItem> insert(SMSItem sms) async {
    sms.id = await db.insert(tableSMSItem, sms.toMap());
    return sms;
  }
  Future<List<SMSItem>> getAll() async {
    
    return [];
  }
  Future<SMSItem> getSMSItem(int id) async {
    List<Map> maps = await db.query(tableSMSItem,
        columns: [columnId, columnSMS, columnAddress, columnSpam],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return SMSItem.fromMap(maps.first);
    }
    return SMSItem(1, "Failed", "Failed", true);
  }

  Future<int> delete(int id) async {
    return await db
        .delete(tableSMSItem, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(SMSItem todo) async {
    return await db.update(tableSMSItem, todo.toMap(),
        where: '$columnId = ?', whereArgs: [todo.id]);
  }

  Future close() async => db.close();
}


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