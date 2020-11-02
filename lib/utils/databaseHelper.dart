import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:weatherApp/models/table_img.dart';

class DataBaseHelper {
  static DataBaseHelper _dataBaseHelper;
  static Database _dataBase;

  //Definindo colunas e noma da tabela
  String imgTable = "imgTable";
  String colId = "id";
  String colImgPath = "imgPath";
  String colCityId = "cityId";

  DataBaseHelper._createInstance();

  factory DataBaseHelper() {
    if (_dataBaseHelper == null) {
      _dataBaseHelper = DataBaseHelper._createInstance();
    }
    return _dataBaseHelper;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $imgTable($colId integer primary key autoincrement, $colImgPath text, $colCityId text)');
  }

  Future<Database> initDataBase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'imgCity.db';

    var imgCityDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return imgCityDb;
  }

  Future<Database> get database async {
    if (_dataBase == null) {
      _dataBase = await initDataBase();
    }
    return _dataBase;
  }

  //Incluir um objeto
  Future<int> insertContato(ImgModel imgModel) async {
    Database db = await this.database;
    var resultado = db.insert(imgTable, imgModel.toMap());
  }
}
