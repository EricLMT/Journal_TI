import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:journal_ti/utils/db_utils.dart';
import 'package:journal_ti/observation.dart';
import 'package:intl/intl.dart';
import '/l10n/app_localizations.dart';
import 'package:journal_ti/utils/locale_language.dart';

final logger = Logger();




class ObservationsDbPage extends StatefulWidget {
  const ObservationsDbPage({super.key});
  @override
  State<ObservationsDbPage> createState() => _ObservationsDbPageState();
}

class _ObservationsDbPageState extends State<ObservationsDbPage> {
  List<Observation> observations = [];

  @override
  void initState() {
    super.initState();
    charger();
  }

  Future<void> charger() async {
    final all = await DBHelper.getAllObservations();
    setState(() {
      observations = all;
    });
  }

  Future<void> supprimer(int id) async {
    await DBHelper.deleteObservation(id);
    charger(); // recharge après suppression
  }

  String afficherResumeObservation(Observation obs) {
    final tr = AppLocalizations.of(context)!;
    final aDate = obs.date == obs.date;
    final aLieu = obs.lieu != null && obs.lieu!.trim().isNotEmpty;

    if (aDate && aLieu) {
      return 'ID: ${obs.id} - ${DateFormat('dd/MM/yyyy').format(obs.date)} - ${DateFormat('HH:mm').format(obs.date)} (${tr.getTranslation(obs.lieu ?? '')})';
    } else if (aDate) {
      return 'ID: ${obs.id} - ${DateFormat('dd/MM/yyyy').format(obs.date)} - ${DateFormat('HH:mm').format(obs.date)} (${tr.db_page_lieu_unknow})';
    } else if (aLieu) {
      return 'ID: ${obs.id} - ${tr.db_page_date_unknow} (${tr.getTranslation(obs.lieu ?? '')})';
    } else {
      return 'ID: ${obs.id} - ${tr.db_page_date_lieu_unknow}';
    }
  }


  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            tr.db_page_records,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          Divider(),
          ...observations.map((obs) => ListTile(
                title: Text(afficherResumeObservation(obs)),
                subtitle: Text(obs.comportement ?? ''),
                leading: const Icon(Icons.delete),
                onTap: () async {
                  final confirmation = await showDialog<bool>(
                    context: context,
                    builder: (context) =>
                        AlertDialog(
                          title: Text(tr.alert_dialog_confirm),
                          content: Text(tr.alert_dialog_confirm_delete),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              // annuler
                              child: Text(tr.button_cancel),
                            ),
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context, true),
                              // confirmer
                              child: Text(tr.alert_dialog_delete),
                            ),
                          ],
                        ),
                  );
                  if (confirmation == true) {
                    await supprimer(obs.id!);
                    if (!context.mounted) return;
                    await showDialog(
                      context: context,
                      builder: (context) =>
                          AlertDialog(
                            title: Text(tr.alert_dialog_del_ok),
                            content: Text(tr.alert_dialog_del_rec_ok),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(tr.alert_dialog_ok),
                              ),
                            ],
                          ),
                    );
                  }
                }
              )
          ),
          SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),
        ],
      ),
    );
  }
}
