import 'package:sqflite/sqflite.dart';
import 'package:suscription_reminder_v2/model/suscription_model.dart';

class SuscriptionDatabase {
  Database _db;

  //onCreate se ejecutara la primera vez que corra el archivo
  initDB() async {
    _db = await openDatabase(
      'my_datb.db', version: 1,
      onCreate: (Database db, int version) {
        db.execute("CREATE TABLE suscriptions (id INTEGER PRIMARY KEY, " +
            "name TEXT NOT NULL, price INTEGER NOT NULL, initialDate TEXT NOT NULL," +
            " finalDate TEXT NOT NULL, activated INTEGER DEFAULT 0)");

        print("We did it ");
      },
      //onUpgrade sirve para modificar las tabla de la base de datos ya creada
      /* onUpgrade: (db, oldVersion, newVersion) {
        if ((oldVersion > 2) && (newVersion < 5)) {
          db.execute(
              "ALTER TABLE suscriptions ADD COLUMN activated INTEGER DEFAULT 0;");
        }
      },*/
    );
  }

// Define define una funcion que introduce una suscripcion a la tabla
  insert(Suscription suscription) async {
    print(await _db.insert("suscriptions", suscription.toMap()));
  }

  Future<List<Suscription>> getAllSuscriptions() async {
    List<Map<String, dynamic>> results = await _db.query("suscriptions");

    print("Got: ${results.length}");
    return results.map((map) => Suscription.fromMap(map)).toList();
  }

  updateSuscription(Suscription suscription) {
    _db.update("suscriptions", suscription.toMap(),
        where: "id = ?", whereArgs: [suscription.id]);
  }

  deleteSuscription(Suscription suscription) {
    _db.delete("suscriptions", where: "id = ?", whereArgs: [suscription.id]);
  }
}
