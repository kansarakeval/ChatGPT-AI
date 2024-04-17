import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import '../screen/history/model/history_model.dart';

class DbHelper {
  static DbHelper helper = DbHelper._();

  DbHelper._();

  Database? database;
  final String DB_NAME = "data.db";

  Future<Database> checkDB() async {
    if (database != null) {
      return database!;
    } else {
      return await initDB();
    }
  }

  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = join(dir.path, DB_NAME);
    return openDatabase(
      path,
      version: 2,
      onCreate: (db, version) {
        String queryAiTable =
            "CREATE TABLE ai(id INTEGER PRIMARY KEY AUTOINCREMENT,answer TEXT)";
        db.execute(queryAiTable);
      },
    );
  }

  Future<void> insertAiData(HistoryModel historyModel) async {
    database = await checkDB();
    database!.insert("ai", {
      "answer":historyModel.answer,
    });
  }

  Future<List<HistoryModel>> readAiData() async {
    database = await checkDB();
    String query = "SELECT * FROM ai";
    List<Map> data = await database!.rawQuery(query, null);
    List<HistoryModel> modelList =
    data.map((e) => HistoryModel.mapToModel(e)).toList();
    return modelList;
  }

  Future<void> deleteAiData({required String id}) async {
    database = await checkDB();
    database!.delete("ai", where: "id=?", whereArgs: [id]);
  }
}