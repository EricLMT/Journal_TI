import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:excel/excel.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'dart:async';
import 'package:intl/intl.dart';
import '/l10n/app_localizations.dart';
import 'package:journal_ti/utils/permissions_utils.dart';
import 'package:journal_ti/utils/locale_language.dart';


final logger = Logger();

  Future<void> exportToExcel(List<Map<String, dynamic>> observations, BuildContext context) async {
    final tr = AppLocalizations.of(context)!;

    // Demande de permission
    final status = await PermissionHelper.requestStoragePermission();
    if (!status) {
      logger.i("Permission refusée. Aller dans les paramètres.");
      openAppSettings(); // Pour ouvrir les paramètres
      return;
    }


    logger.i("Observations à exporter (${observations.length} éléments) :");
    for (final o in observations) {
      logger.i(o.toString());
    }
    logger.i("Clés disponibles : ${observations.first.keys}");

    // Création du document Excel
    final excel = Excel.createExcel();
    final Sheet sheet = excel.sheets.values.first; // Utilise directement la première feuille
    //final sheet = excel['Observations'];

    // Ajout de l'en-tête
    sheet.appendRow([
      TextCellValue(tr.obs_id),
      TextCellValue(tr.obs_date),
      TextCellValue(tr.obs_hour),
      TextCellValue(tr.obs_localisation),
      TextCellValue(tr.obs_place),
      TextCellValue(tr.obs_detail_place),
      TextCellValue(tr.obs_comportement),
      TextCellValue(tr.obs_personnes),
      TextCellValue(tr.obs_interaction_type),
      TextCellValue(tr.obs_interaction_link),
      TextCellValue(tr.obs_repeat),
      TextCellValue(tr.obs_psy_impacts),
      TextCellValue(tr.obs_phy_impacts),
      TextCellValue(tr.obs_temoins),
      TextCellValue(tr.obs_remarques)
    ]);
      
    // Remplissage avec les données
    for (final obs in observations) {
      final dateStr = _formatDate(obs['date']);
      final heureStr = _formatHeure(obs['heure']);
      final lieuStr = tr.getTranslation(obs['lieu'] ?? '');
      final interactTypeStr = tr.getTranslation(obs['interactiontype'] ?? '');
      final interactLinkStr = tr.getTranslation(obs['interactionlink'] ?? '');
      final repetStr = tr.getTranslation(obs['repetition'] ?? '');
      final impactsPsy = (obs['impactspsychologiques'] != null && obs['impactspsychologiques']!.isNotEmpty
          ? obs['impactspsychologiques']!
          .map((e) => tr.getTranslation(e.trim().toString()))
          .join(', ')
          : '-');
      final impactsPhy = (obs['impactsphysiques'] != null && obs['impactsphysiques']!.isNotEmpty
          ? obs['impactsphysiques']!
          .map((e) => tr.getTranslation(e.trim().toString()))
          .join(', ')
          : '-');

      sheet.appendRow([
        sanitize(obs['id'] ?? ''),
        sanitize(dateStr),
        sanitize(heureStr),
        sanitize(obs['localisation'] ?? ''),
        sanitize(lieuStr),
        sanitize(obs['contexte'] ?? ''),
        sanitize(obs['comportement'] ?? ''),
        sanitize(obs['personnes'] ?? ''),
        sanitize(interactTypeStr),
        sanitize(interactLinkStr),
        sanitize(repetStr),
        sanitize(impactsPsy),
        sanitize(impactsPhy),
        sanitize(obs['temoins'] ?? ''),
        sanitize(obs['remarques'] ?? ''),
      ]);
    }

    // Sauvegarde du fichier
    final dir = Directory('/storage/emulated/0/Documents/JournalTI');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    final file = File('${dir.path}/export_observations.xlsx');
    await file.writeAsBytes(excel.encode()!, flush: true);

    logger.i('Fichier Excel exporté dans : ${file.path}');
  }

  dynamic toEncodable(dynamic item) {
    if (item is DateTime) {
      return item.toIso8601String();
    }
    return item;
  }

String _formatDate(dynamic value) {
  if (value is DateTime) {
    return DateFormat('dd/MM/yyyy').format(value);
  }
  if (value is String && value.contains('T')) {
    return DateFormat('dd/MM/yyyy').format(DateTime.parse(value));
  }
  return value.toString(); // fallback
}

String _formatHeure(dynamic value) {
  if (value is DateTime) {
    return DateFormat('HH:mm').format(value);
  }
  if (value is String && value.contains('T')) {
    return DateFormat('HH:mm').format(DateTime.parse(value));
  }
  return value.toString(); // fallback
}

TextCellValue sanitize(dynamic val) {
  if (val == null) return TextCellValue('');
  return TextCellValue(val.toString().replaceAll(RegExp(r'[\x00-\x1F]'), ' '));
}