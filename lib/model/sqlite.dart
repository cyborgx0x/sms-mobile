import 'package:sqflite/sqflite.dart';


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
      columnSpam: true == spam? 1 : 0
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

  Future<List> getAll() async {
    var records = await db.query('smsitem');
    return records;
    
  }

  Future<List> getSMSbyPhone(phone) async {
    var records = await db.query(
      'smsitem',
      columns: [columnId, columnSMS, columnAddress, columnSpam],
      where: '$columnAddress = ?',
      whereArgs: [phone]);
    return records;
    
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

  Future<int> update(SMSItem sms) async {
    return await db.update(tableSMSItem, sms.toMap(),
        where: '$columnId = ?', whereArgs: [sms.id]);
  }

  Future close() async => db.close();
}

