// ignore_for_file: camel_case_types

import 'dart:typed_data';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void dataBase() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await openDatabase(
    join(await getDatabasesPath(), 'my_database.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE my_table(id INTEGER PRIMARY KEY, text TEXT, image BLOB, created_at TEXT)',
      );
    },
    version: 1,
  );

  runApp(bdData(database: database));
}

class bdData extends StatefulWidget {
  final Database database;

  const bdData({Key? key, required this.database}) : super(key: key);

  @override
  State<bdData> createState() => _bdDataState();
}

class _bdDataState extends State<bdData> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(database: widget.database),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Database>('database', widget.database));
  }
}

class MyHomePage extends StatefulWidget {
  final Database database;

  const MyHomePage({Key? key, required this.database}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Insertar datos en la base de datos
            await insertData();

            // Consultar datos de la base de datos
            List<Map<String, dynamic>> data = await fetchData();

            // Imprimir datos en la consola
            for (var row in data) {
              print(
                  'ID: ${row['id']}, Texto: ${row['text']}, Fecha: ${row['created_at']}');
            }
          },
          child: Text('Operaciones SQLite'),
        ),
      ),
    );
  }

  Future<void> insertData() async {
    String currentDate = DateTime.now().toLocal().toString();
    await widget.database.insert(
      'my_table',
      {
        'text': 'Ejemplo de texto',
        'image': await File('ruta_de_tu_imagen').readAsBytes(),
        'created_at': currentDate,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> fetchData() async {
    return await widget.database.query('my_table');
  }
}
