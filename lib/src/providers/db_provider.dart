

import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:qr_reader/src/models/scan_model.dart';
export 'package:qr_reader/src/models/scan_model.dart';

class DBProvider{
  
  // Metodo estatico
  static Database _database;

  // Creando la instancia
  static final DBProvider db = DBProvider._();

  //Constructor privado
  DBProvider._();

  // Accediendo a la propiedad del '_database'
  // Sera un método async ya que la base de datos y la lectura no es sincrona
  Future<Database> get database async{
    

    if(_database != null) return _database; // Si ya fue instaciado se regredara la misma BD.
    
    _database = await initDB();
    
    return _database;
  }

  Future<Database> initDB()async{
    // Path de donde se almacenara la Base de datos
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // El join nos servira para unir pedazos del path
    // El primero es el path, el segundo el el nombre de la BD con su extencio (para este caso SQLite)
    final path = join(documentDirectory.path, 'ScansDb.db');
    print(path);

    // Crear Base de Datos
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db){},
      onCreate: (Database db, int version) async{
        await db.execute('''
          CREATE TABLE Scans(
            id INTEGER PRIMARY KEY,
            tipo TEXT,
            valor TEXT
          )
        ''');
      }
    );
    
  }

  Future<int> nuevoScanRaw(ScanModel nuevoScan) async{

    final id    =nuevoScan.id;
    final tipo  =nuevoScan.tipo;
    final valor =nuevoScan.valor;


    // Obteniendo la referencia a la base de datos
    final db = await database;

    // Procedimiento de la inserccion
    final res = await db.rawInsert('''
      INSERT INTO Scans (id, tipo, valor)
      VALUES($id, '$tipo', '$valor')
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel newScan) async{

    final db = await database;

    final res = await db.insert('Scans', newScan.toJson());

    print("Registro numero: $res");

    return res;
  }

  Future<ScanModel>getScanById(int id) async{
    final db = await database;

    final res = await db.query("Scans", where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty
            ? ScanModel.fromJson(res.first) // Le mando el primer elemento de la respuesta
            : null;
  }

  Future<List<ScanModel>>getAll() async{
    final db = await database;

    final res = await db.query("Scans");

    return res.isNotEmpty
            ? res.map((scan) => ScanModel.fromJson(scan)).toList()
            : [];
  }

  Future<List<ScanModel>>getForType(String tipo) async{
    final db = await database;

    final res = await db.rawQuery('''
    SELECT * FROM  Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty
            ? res.map((scan) => ScanModel.fromJson(scan)).toList()
            : [];
  }

  //Actualización de registro
  Future<int> updateScan(ScanModel nuevoScan) async{
    final db = await database;

    final res =await db.update("Scans", nuevoScan.toJson(), where: "id=?", whereArgs: [nuevoScan.id]);
    return res;
  }

  //Borrar registros
  Future<int> deleteScans (int id) async{
    final db = await database;
    final res = await db.delete("Scans", where:"id = ?", whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans () async{
    final db = await database;
    final res = await db.rawDelete("DELETE FROM Scans");
    return res;
  }

}
