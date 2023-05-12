import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sms_spam_detection/sms.dart';

void main() async {
 // Avoid errors caused by flutter upgrade.
// Importing 'package:flutter/widgets.dart' is required.
  WidgetsFlutterBinding.ensureInitialized();
  // Open the database and store the reference.
  // databaseFactory = databaseFactoryFfi;
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'SMS.db'),
    onCreate: (db, version) {
      // Run the CREATE TABLE statement on the database.
      return db.execute(
        'CREATE TABLE smsitems(id INTEGER PRIMARY KEY, address TEXT, body TEXT, spam BIT)',
      );
    },
    version: 1,
  );
  
Future<void> insertSMS(SMSItem smsitem) async {
  // Get a reference to the database.
  final db = await database;

  // `conflictAlgorithm` to use in case the same dog is inserted twice.
  //
  // In this case, replace any previous data.
  await db.insert(
    'smsitems',
    smsitem.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<SMSItem>> getSMSItem() async {
  // Get a reference to the database.
  final db = await database;

  // Query the table for all The Dogs.
  final List<Map<String, dynamic>> maps = await db.query('smsitems');

  // Convert the List<Map<String, dynamic> into a List<Dog>.
  return List.generate(maps.length, (i) {
    return SMSItem(
      id: maps[i]['id'],
      address: maps[i]['address'],
      body: maps[i]['body'],
      spam: maps[i]['spam'],
    );
  });
}
var fido = const SMSItem(
  id: 1,
  address: 'Fido',
  body: "hello",
  spam: "false",
);

await insertSMS(fido);
print(await getSMSItem());
}