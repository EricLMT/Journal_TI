import 'dart:io';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';
import 'package:journal_ti/observation.dart';


final logger = Logger();


//final List<Map<String, dynamic>> results = await db.query('observations');
//final observations = results.map((map) => Observation.fromMap(map)).toList();


class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final databasesPath = await getDatabasesPath();
    final dbPath = path.join(databasesPath, 'observations.db');

    final dbFile = File(dbPath);
    if (!await dbFile.exists()) {
      logger.i("La base n'existe pas encore. Elle sera créée à l'ouverture.");
    }

    // Ouvrir ou créer la base de données
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS observations (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT,
            heure TEXT,
            lieu TEXT,
            contexte TEXT,
            comportement TEXT,
            personnes TEXT,
            interactiontype TEXT,
            interactionlink TEXT,
            repetition TEXT,
            impactspsychologiques TEXT,
            impactsphysiques TEXT,
            temoins TEXT,
            remarques TEXT,
            localisation TEXT
          )
        ''');
      },
    );    
  }

  static Future<Observation?> getObservationById(int id) async {
    final database = await db;

    try {
      final result = await database.query(
        'observations',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (result.isEmpty) {
        logger.i("Aucune observation trouvée avec l'id $id.");
        return null;
      }

      final map = Map<String, dynamic>.from(result.first);

      return Observation.fromMap({
        ...map,
        'impactspsychologiques': (map['impactspsychologiques'] as String?)?.split(', ') ?? [],
        'impactsphysiques': (map['impactsphysiques'] as String?)?.split(', ') ?? [],
        'repetition': map['repetition'] == 1,
      });
    } catch (e) {
      logger.e("Erreur lors de la récupération de l'observation : $e");
      return null;
    }
  }


  static Future<List<Observation>> getAllObservations() async {
    final database = await db;
    try {
      final result = await database.query('observations');
      if (result.isEmpty) {
        logger.i("Aucune observation trouvée.");
        return [];
      } else {
        return result.map((e) {
          final map = Map<String, dynamic>.from(e);
          return Observation.fromMap({
            ...map,
            'impactspsychologiques': (map['impactspsychologiques'] as String?)?.split(',') ?? [],
            'impactsphysiques': (map['impactsphysiques'] as String?)?.split(',') ?? [],
            //'repetition': map['repetition'] == 1,
          });
        }).toList();
      }      
    } catch (e) {
      logger.e("Erreur lors de la récupération des observations : $e");
      return [];
    }    
  }

  static Future<List<Observation>> getObservationsPaginated({int offset = 0, int limit = 10}) async {
    final database = await db;
    try {
      final result = await database.query(
        'observations',
        orderBy: 'date DESC',
        limit: limit,
        offset: offset,
      );
      if (result.isEmpty) {
        logger.i("Aucune observation trouvée.");
        return [];
      } else {
        return result.map((map) {
          return Observation.fromMap({
            ...map,
            'impactspsychologiques': (map['impactspsychologiques'] as String?)
                ?.split(',') ?? [],
            'impactsphysiques': (map['impactsphysiques'] as String?)?.split(
                ',') ?? [],
            'repetition': map['repetition'], // == 1,
          });
        }).toList();
      }
    } catch (e) {
      logger.e("Erreur lors de la récupération des observations : $e");
      return [];
    }
  }

  static Future<void> deleteAll() async {
    final database = await db;
    await database.delete('observations');
  }

  static Future<void> supprimerBaseDeDonnees() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = path.join(dir.path, 'observations.db');
    
    // Ferme la DB si elle est ouverte
    final database = await db;
    await database.close();

    if (await File(dbPath).exists()) {
      await deleteDatabase(dbPath);      
      logger.i("Base de données supprimée : $dbPath");
      logger.i("Création d'une nouvelle Base de données...");      
    } else {
      logger.i('Aucune base de données trouvée à : $dbPath');
      logger.i("Création d'une nouvelle Base de données...");    
    }
    // Réinitialise
    DBHelper._db = null;
    await DBHelper.initDB();
  }
 
  static Future<void> deleteObservation(int id) async {
    final dbClient = await db;
    await dbClient.delete('observations', where: 'id = ?', whereArgs: [id]);
  }

  static Future<void> insertObservation(Observation obs) async {
    final database = await db;
    await database.insert(
      'observations',
      {
        ...obs.toMap(),
        'id':'',
        'impactspsychologiques': obs.impactspsychologiques?.join(','),        // conversion liste → String
        'impactsphysiques': obs.impactsphysiques?.join(','),
        'repetition': obs.repetition,
        // == true ? 1 : 0,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    logger.i("Observation sauvegardée dans SQL : $obs");
  }


  static Future<void> sauvegarderSQLObservation(Map<String, dynamic> data) async {
    // Nettoyer et formater les champs multi-sélection
    String format(dynamic champ) {
      if (champ is List) return champ.join(',');
      return champ?.toString() ?? '';
    }

    // Construire la map SQL 
    final observation = {
      'date': format(data['date']),
      'heure': format(data['heure']),
      'lieu': data['lieu'] ?? '',
      'contexte': data['contexte'] ?? '',
      'comportement': data['comportement'] ?? '',
      'personnes': data['personnes'] ?? '',
      'interactiontype': data['interactiontype'] ?? '',
      'interactionlink': data['interactionlink'] ?? '',
      'repetition': data['repetition'] ?? '',
      'impactspsychologiques': format(data['impactspsychologiques']),
      'impactsphysiques': format(data['impactsphysiques']),
      'temoins': data['temoins'] ?? '',
      'remarques': data['remarques'] ?? '',
      'localisation': data['localisation'] ?? '',
    };

    // Insérer dans la base
    final database = await db;
    await database.insert('observations',observation);    
    logger.i("Observation sauvegardée dans SQL : $observation");
  }

  static Future<void> updateObservation(Map<String, dynamic> data) async {
    // Nettoyer et formater les champs multi-sélection
    String format(dynamic champ) {
      if (champ is List) return champ.join(', ');
      return champ?.toString() ?? '';
    }

    // Construire la map SQL
    final observation = {
      'id': format(data['id'] ?? ''),
      'date': format(data['date']),
      'heure': format(data['heure']),
      'lieu': data['lieu'] ?? '',
      'contexte': data['contexte'] ?? '',
      'comportement': data['comportement'] ?? '',
      'personnes': data['personnes'] ?? '',
      'interactiontype': data['interactiontype'] ?? '',
      'interactionlink': data['interactionlink'] ?? '',
      'repetition': data['repetition'] ?? '',
      'impactspsychologiques': format(data['impactspsychologiques']),
      'impactsphysiques': format(data['impactsphysiques']),
      'temoins': data['temoins'] ?? '',
      'remarques': data['remarques'] ?? '',
      'localisation': data['localisation'] ?? '',
    };

    final database = await db;
    await database.update(
      'observations',observation,
      where: 'id = ?',
      whereArgs: [observation['id']],
    );
    logger.i("Observation mise à jour dans SQL : $observation");
  }

  static Future<void> exporterBaseDeDonnees() async {
    final dbPath = path.join(await getDatabasesPath(), 'observations.db');

    final externalDir = Directory('/storage/emulated/0/Documents/JournalTI');
    if (!await externalDir.exists()) {
      await externalDir.create(recursive: true);
    }
    final exportPath = path.join(externalDir.path, 'observations_export.db');
    await File(dbPath).copy(exportPath);

    final dbFile = File(exportPath);

    if (await dbFile.exists()) {
      logger.i('Base de données exportée vers : $exportPath');
    } else {
      logger.i('Base de données introuvable à : $dbPath');
    }
  }

  static Future<void> importerBaseDeDonnees(String pathImport) async {
      final databasesPath = await getDatabasesPath();
      final dbPath = '$databasesPath/observations.db';

      final importFile = File(pathImport);
      final dbFile = File(dbPath);

      if (await importFile.exists()) {
        await dbFile.writeAsBytes(await importFile.readAsBytes());
        logger.i('Base de données importée depuis : $pathImport');
      } else {
        logger.i('Fichier d\'importation introuvable');
      }
  }

  static Future<Map<String, int>> getLieuStats() async {
    final database = await db;
    final results = await database.rawQuery('SELECT lieu, COUNT(*) as total FROM observations GROUP BY lieu');
    if (results.isEmpty) return {};
    return {
      for (var row in results)
        row['lieu'] as String: row['total'] as int
    };
  }

  static Future<Map<String, int>> getTypeStats() async {
      final database = await db;
      final results = await database.rawQuery('SELECT interactiontype, COUNT(*) as total FROM observations GROUP BY interactiontype');
      if (results.isEmpty) return {};
      return {
        for (var row in results)
          row['interactiontype'] as String: row['total'] as int
      };
  }

  static Future<Map<String, int>> getLienStats() async {
      final database = await db;
      final results = await database.rawQuery('SELECT interactionlink, COUNT(*) as total FROM observations GROUP BY interactionlink');
      if (results.isEmpty) return {};
      return {
        for (var row in results)
          row['interactionlink'] as String: row['total'] as int
      };
  }

  static Future<Map<String, int>> getTopImpPsyStats({int limit = 5}) async {
    final db = await DBHelper.db;
    final results = await db.rawQuery(
        'SELECT impactspsychologiques FROM observations WHERE impactspsychologiques IS NOT NULL'
    );

    final Map<String, int> impactCounts = {};

    for (final row in results) {
      final String? raw = row['impactspsychologiques'] as String?;
      if (raw != null) {
        final List<String> items = raw
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

        for (final item in items) {
          impactCounts[item] = (impactCounts[item] ?? 0) + 1;
        }
      }
    }

    // Trie et limite à top N
    final sorted = impactCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sorted.take(limit));
  }

  static Future<Map<String, int>> getTopImpPhyStats({int limit = 5}) async {
    final db = await DBHelper.db;
    final results = await db.rawQuery(
        'SELECT impactsphysiques FROM observations WHERE impactsphysiques IS NOT NULL'
    );

    final Map<String, int> impactCounts = {};

    for (final row in results) {
      final String? raw = row['impactsphysiques'] as String?;
      if (raw != null) {
        final List<String> items = raw
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

        for (final item in items) {
          impactCounts[item] = (impactCounts[item] ?? 0) + 1;
        }
      }
    }

    // Trie et limite à top N
    final sorted = impactCounts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Map.fromEntries(sorted.take(limit));
  }
}

