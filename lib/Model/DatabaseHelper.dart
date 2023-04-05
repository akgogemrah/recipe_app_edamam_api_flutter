import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';



import 'package:flutter/cupertino.dart';
import 'package:untitled9/Model/Receipt.dart';

class DatabaseHelper3 extends ChangeNotifier {
  DatabaseHelper3();
  DatabaseHelper3.privateConstructor();
  static final DatabaseHelper3 instance=DatabaseHelper3.privateConstructor();
  static Database? _Database;
  Future<Database> get database async=>_Database ??=await _initDatabase();
  Future<Database> _initDatabase()async{
    Directory documentsDirectory=await getApplicationDocumentsDirectory();
    String path=join(documentsDirectory.path,'receiptsFav1.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,

    );

  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE receiptsFav1 (
        id INTEGER PRIMARY KEY,
        Name TEXT,
        ingredients TEXT,
        urlImage TEXT
      )
      ''');
  }



Future<List<Receipt>>getReceipts()async{
Database db=await instance.database;
var receipts=await db.query('receiptsFav1',orderBy: 'Name');
List<Receipt> receipLlist=receipts.isNotEmpty

? receipts.map((e) => Receipt.fromMap(e)).toList() :  [];
return receipLlist;

}

Future<int> add(Receipt receipt)async{
Database db= await instance.database;
notifyListeners();
return await db.insert('receiptsFav1', receipt.toMap());
}

Future<int>remove(int id)async{

    Database db=await instance.database;
    notifyListeners();


    return await db.delete('receiptsFav1',where: 'id = ?',whereArgs: [id]);

}


}
