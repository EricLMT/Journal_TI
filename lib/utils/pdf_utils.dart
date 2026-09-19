import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path/path.dart' as path;
import 'package:printing/printing.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:logger/logger.dart';
import 'dart:io';
import 'dart:async';

import 'package:journal_ti/utils/db_utils.dart'; 
import 'package:journal_ti/utils/geoloc_utils.dart'; 
//import 'package:journal_ti/utils/json_utils.dart';
import '/l10n/app_localizations.dart';
import 'package:journal_ti/utils/locale_language.dart';
//import 'package:journal_ti/observation.dart';

final logger = Logger();


Future<void> generatePdfFromDatabase(BuildContext context, {bool partager = false}) async {
  late AppLocalizations tr;

  final pdf = pw.Document();
  
  final now = DateTime.now();
  final dateStr = DateFormat('dd-MM-yyyy').format(now);
  final heureStr = DateFormat('HH\'h\'mm').format(now);
  
  // Autorisation géolocalisation
  bool autorise = await demanderPermissionGeoloc();
  if (!autorise) return;


  // Position + adresse
  Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

  tr = AppLocalizations.of(context)!;
  String adresseredaction = placemarks.isNotEmpty
      ? "${placemarks.first.postalCode} ${placemarks.first.locality}, ${placemarks.first.country}"
      : tr.geoloc_unknow;

  // Charger les données de la DB
  final observations = await DBHelper.getAllObservations();



  // Si vide, on avertit
  if (observations.isEmpty) {
    if (!context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(tr.skbar_export_empty)),
    );
    return;
  }

  // Format date et heure pour nom fichier
  //String dateStr = DateFormat('dd-MM-yyyy').format(date_rapport);
  //String heureStr = DateFormat('HH\'h\'mm').format(heure_rapport);

  pw.Widget section(String title, Map<String, dynamic> content) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 10),
        pw.Text(title, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 6),
        ...content.entries.map((e) => pw.Text('${e.key}: ${e.value ?? "-"}')),
      ],
    );
  }
  
  // Page de couverture
  pdf.addPage(pw.Page(
    build: (context) => pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(tr.pdf_utils_report_title, style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 18),
        pw.Text("${tr.pdf_utils_report_place} : $adresseredaction"),
        pw.Text("${tr.pdf_utils_report_date} : $dateStr -- ${tr.pdf_utils_report_hour} : $heureStr"),
        pw.Divider(),
        pw.Text("${tr.pdf_utils_report_nb_obs} : ${observations.length}"),
        pw.SizedBox(height: 16),
      ],
    ),
  ));


  // Ajout d'une page par observation
  for (final obs in observations) {
    // Format date et heure pour nom fichier
    String dateStr = DateFormat('dd-MM-yyyy').format(obs.date);
    String heureStr = DateFormat('HH\'h\'mm').format(obs.heure);
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(24),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('${tr.obs_detail_page_title_sheet} n°${obs.id}', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 12),
            section(tr.pdf_utils_section_datetime, {
              tr.obs_date: dateStr,
              tr.obs_hour: heureStr,
              tr.obs_localisation: obs.localisation,
            }),

            section(tr.pdf_utils_section_place, {
              tr.obs_place: tr.getTranslation(obs.lieu ?? ''),
              tr.obs_detail_place: obs.contexte,
            }),

            section(tr.pdf_utils_section_observation, {
              tr.obs_comportement: obs.comportement,
              tr.obs_personnes: obs.personnes,
              tr.obs_interaction_type: tr.getTranslation(obs.interactiontype ?? ''),
              tr.obs_interaction_link: tr.getTranslation(obs.interactionlink ?? ''),
              tr.obs_repeat: tr.getTranslation(obs.repetition ?? ''), // == true ? tr.button_yes : tr.button_no,
            }),

            section(tr.pdf_utils_section_impacts, {
              tr.obs_psy_impacts: (obs.impactspsychologiques != null && obs.impactspsychologiques!.isNotEmpty
                  ? obs.impactspsychologiques!
                  .map((e) => tr.getTranslation(e.trim().toString()))
                  .join(', ')
                  : '-'),
              tr.obs_phy_impacts: (obs.impactsphysiques != null && obs.impactsphysiques!.isNotEmpty
                  ? obs.impactsphysiques!
                  .map((e) => tr.getTranslation(e.trim().toString()))
                  .join(', ')
                  : '-'),
            }),

            section(tr.pdf_utils_section_other, {
              tr.obs_temoins: obs.temoins,
              tr.obs_remarques: obs.remarques,
           }),
         ],
       ),
     ),
   );
  }

  // Création dossier
  final directory = Directory('/storage/emulated/0/Documents/JournalTI');
  if (!await directory.exists()) await directory.create(recursive: true);

  // Nom du fichier
  final fileName = "rapport_observations_${dateStr}_$heureStr.pdf";
  final filePath = path.join(directory.path, fileName);

  // Sauvegarde
  final file = File(filePath);
  await file.writeAsBytes(await pdf.save());
  if (!context.mounted) return;
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('${tr.skbar_pdf_file} ${observations.length} observation(s)'),
  ));

  // Partage
  if (partager) {
    await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
  }
}
