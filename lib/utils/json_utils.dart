import 'package:permission_handler/permission_handler.dart'; 
import 'package:logger/logger.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';

final logger = Logger();

Future<void> sauvegarderObservation(Map<String, dynamic> data) async {
    // Demande de permission   
    if (!await Permission.manageExternalStorage.request().isGranted) {
      logger.i("Permission refusée. Aller dans les paramètres.");
      openAppSettings(); // Pour ouvrir les paramètres
      return;
    }
    // Sauvegarde du fichier
    final dir = Directory('/storage/emulated/0/Documents/JournalTI/json');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }    
    final file = File('${dir.path}/observations.json');
    
    // Convertir les DateTime en String
    final Map<String, dynamic> observation = data.map((key, value) {
      if (value is DateTime) {
        return MapEntry(key, value.toIso8601String());
      }
      return MapEntry(key, value);
    });
    
    List<Map<String, dynamic>> liste = [];
    
    if (await file.exists()) {      
      try {
        final contenu = await file.readAsString();
        final decoded = jsonDecode(contenu);
        if (decoded is List) {
          liste = List<Map<String, dynamic>>.from(decoded);
        }
      } catch (e) {
        // Si le fichier est mal formé, on repart de zéro
        logger.i("Erreur lecture JSON, fichier réinitialisé.");
        logger.i(e);
        liste = [];
      }
    }
    logger.i("Observation à sauvegarder : $observation");
    liste.add(observation);
    await file.writeAsString(jsonEncode(liste), flush: true);
    logger.i("Observation sauvegardée dans fichier JSON : ${file.path}");    
  }

  Future<List<Map<String, dynamic>>> chargerObservations() async {
    // Demande de permission   
    if (!await Permission.manageExternalStorage.request().isGranted) {
      logger.i("Permission refusée. Aller dans les paramètres.");
      openAppSettings(); // Pour ouvrir les paramètres
      return [];
    }
    final file = File('/storage/emulated/0/Documents/JournalTI/json/observations.json');

    if (!await file.exists()) return [];
    
    try {
      final contenu = await file.readAsString();
      final decoded = jsonDecode(contenu);

      return List<Map<String, dynamic>>.from(decoded);
    } catch (e) {
      logger.i("Erreur lors de la lecture du fichier JSON : $e");
      return [];
    }    
}

Future<List<Map<String, dynamic>>> chargerObservationsOne() async {
    final dir = Directory('/storage/emulated/0/Documents/JournalTI/json');
    if (!await dir.exists()) return [];

    final fichiers = dir.listSync().where((f) => f.path.endsWith('.json'));

    List<Map<String, dynamic>> observations = [];

    for (final fichier in fichiers) {
      final contenu = await File(fichier.path).readAsString();
      final map = jsonDecode(contenu);
      observations.add(map);
    }

    return observations;
}

 