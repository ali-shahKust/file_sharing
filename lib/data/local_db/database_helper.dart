import 'package:quick_backup/data/models/queue_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseHelper {
  static final _dbName = 'EasyBackUp.db';
  static final _filesTable = 'filesTable';
  static final columnFileId = 'fileId';
  static final columnFileName = 'fileName';
  static final columnFilePath = 'filePath';
  static final columnFileKey = 'fileKey';
  static final columnFileSize = 'fileSize';
  static final columnFileSelected = 'fileSelected';
  static final columnFileDate = 'fileDate';
  DatabaseHelper(){
    initDatabase();
  }
  static Database? _db;
  Future<Database?> get db async {
    if (_db != null) {
      print('Databae Exists $_dbName so i am ignoring rest of create functions');
      return _db;
    }
    print('I am creating Database $_dbName Now ');
    _db = await initDatabase();
    print('db value is $_db');
    return _db;
  }
  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = p.join(databasesPath, _dbName);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $_filesTable($columnFileId INTEGER PRIMARY KEY AUTOINCREMENT,$columnFileName TEXT,$columnFilePath TEXT,$columnFileSize TEXT,$columnFileDate TEXT,$columnFileKey TEXT,$columnFileSelected TEXT)');

      print("Table $_filesTable  Created!!");
  }
  //PDF SIGNATURE RELEATED FUNTIONS
  Future<int> insertFileToDb(QueueModel queueModel) async {
    var dbClient = await db;

    return await dbClient!.insert(_filesTable, queueModel.toMap()) ;
  }
  Future<List<QueueModel>> getAllBackupFilesFromDb() async {
    var dbClient = await db;
    List<Map> maps = await dbClient!.rawQuery('SELECT * FROM $_filesTable');
    List<QueueModel> queueList = [];
    for (int i = 0; i < maps.length; i++) {
      print("My result is :${maps[i]}");
      queueList.add(QueueModel.fromMap(maps[i]));
    }
    return queueList;
  }



  Future<int?> checkValue(path) async {
    var dbClient = await db;

   List? queryResult = await dbClient!.rawQuery('SELECT * FROM $_filesTable WHERE $columnFilePath="$path"');
      return queryResult.length;

}}
