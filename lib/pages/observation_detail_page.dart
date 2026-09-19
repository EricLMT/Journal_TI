import 'package:flutter/material.dart';
//import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
//import 'package:journal_ti/utils/geoloc_utils.dart';

//import 'package:journal_ti/utils/forms_utils.dart';
import 'package:journal_ti/utils/db_utils.dart';
import 'package:journal_ti/observation.dart';
//import 'dart:io';
//import 'dart:async';
//import 'dart:convert';
//import 'package:sqflite/sqflite.dart';
import '/l10n/app_localizations.dart';
import 'package:journal_ti/pages/observation_form_page.dart';
import 'package:logger/logger.dart';
import 'package:journal_ti/utils/locale_language.dart';

final logger = Logger();

class ObservationDetailPage extends StatefulWidget {
  final Observation observation;

  const ObservationDetailPage({super.key, required this.observation});

  @override
  State<ObservationDetailPage> createState() => _ObservationDetailPageState();
}

class _ObservationDetailPageState extends State<ObservationDetailPage> {
  late Observation observation;

  @override
  void initState() {
    super.initState();
    observation = widget.observation;
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(tr.obs_detail_page_title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      tr.obs_detail_page_title_sheet,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(thickness: 2),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text('${tr.obs_detail_page_title_sheet} : ${observation.id}'),
              Text('${tr.obs_date} : ${DateFormat('dd/MM/yyyy').format(
                  observation.date)} ${DateFormat('HH:mm').format(
                  observation.heure)}'),
              Text('${tr.obs_place} : ${tr.getTranslation(observation.lieu ?? '')}'),
              Text('${tr.obs_comportement} : ${observation.comportement}'),
              Text('${tr.obs_temoins} : ${observation.personnes}'),
              Text('${tr.obs_interaction_type} : ${tr.getTranslation(observation.interactiontype ?? '')}'),
              Text('${tr.obs_interaction_link} : ${tr.getTranslation(observation.interactionlink ?? '')}'),
              Text('${tr.obs_repeat} : ${tr.getTranslation(observation.repetition ?? '')}'),
              Text(
                '${tr.obs_psy_impacts} : ${observation.impactspsychologiques != null && observation.impactspsychologiques!.isNotEmpty
                    ? observation.impactspsychologiques!
                    .map((e) => tr.getTranslation(e.trim().toString()))
                    .join(', ')
                    : '-'}',
              ),
              Text(
                '${tr.obs_phy_impacts} : ${observation.impactsphysiques != null && observation.impactsphysiques!.isNotEmpty
                    ? observation.impactsphysiques!
                    .map((e) => tr.getTranslation(e.trim().toString()))
                    .join(', ')
                    : '-'}',
              ),
              Text('${tr.obs_temoins} : ${observation.temoins}'),
              Text('${tr.obs_remarques} : ${observation.remarques}'),
              Text('${tr.obs_localisation} : ${observation.localisation}'),

              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  final updated = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ObservationFormPage(observation: observation),
                    ),
                  );
                  if (updated != null && context.mounted) {
                    Navigator.pop(context, true); // Retourne à la liste avec un flag de mise à jour
                  }
                },
                child: Text(tr.button_modify),
              ),
              const SizedBox(height: 8),
              ElevatedButton.icon(
                icon: const Icon(Icons.delete),
                label: Text(tr.obs_detail_page_delete),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (ctx) =>
                        AlertDialog(
                          title: Text(tr.alert_dialog_confirm),
                          content: Text(tr.alert_dialog_confirm_delete),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(ctx, false),
                              child: Text(tr.button_cancel),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(ctx, true),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red),
                              child: Text(tr.button_delete),
                            ),
                          ],
                        ),
                  );

                  if (confirm == true && observation.id != null) {
                    await DBHelper.deleteObservation(observation.id!);
                    if (context.mounted) {
                      Navigator.pop(context, true);
                      //Navigator.pushNamed(context, '/liste');
                    }
                  }
                },
              ),
              SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),
            ]
        ),
      ),
    );
  }
}