import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart'; 
import 'package:path/path.dart' as path;
import 'package:logger/logger.dart';
import 'package:open_filex/open_filex.dart';
import '/l10n/app_localizations.dart';
import 'package:journal_ti/utils/permissions_utils.dart';
//import 'package:journal_ti/utils/locale_language.dart';
//import 'package:journal_ti/widgets/stats_graph.dart';
import 'package:journal_ti/utils/pdf_utils.dart';

import 'dart:io';
import 'dart:async';

final logger = Logger();
late AppLocalizations tr;

class FichiersPDFPage extends StatefulWidget {
  const FichiersPDFPage({super.key});

  @override
  State<FichiersPDFPage> createState() => _FichiersPDFPageState();
}

class _FichiersPDFPageState extends State<FichiersPDFPage> {
  List<File> fichiers = [];
  Set<File> selectionnes = {};

  @override
  void initState() {
    super.initState();
    chargerFichiers();
  }

  Future<void> chargerFichiers() async {
    final status = await PermissionHelper.requestStoragePermission();
    if (!mounted) return;
    if (!status) {
      tr = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(tr.skbar_granted_refused)),
      );
      return;
    }

    final dossier = Directory('/storage/emulated/0/Documents/JournalTI');
    if (!await dossier.exists()) return;

    final liste = dossier
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.pdf'))
        .toList();

    setState(() {
      fichiers = liste;
      selectionnes.clear();
    });
  }

  void supprimerFichiersSelectionnes() async {
    for (var fichier in selectionnes) {
      await fichier.delete();
    }
    await chargerFichiers();
  }

  void supprimerTousLesFichiers() async {
    for (var fichier in fichiers) {
      await fichier.delete();
    }
    await chargerFichiers();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    final fichiersRapport = fichiers.where((f) => path.basename(f.path).startsWith('rapport_')).toList();
    final fichiersGraphiques = fichiers.where((f) => path.basename(f.path).startsWith('chart_')).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.pdf_page_title),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: selectionnes.isEmpty ? null : supprimerFichiersSelectionnes,
            tooltip: tr.pdf_page_delete_select,
          ),
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: fichiers.isEmpty
                ? null
                : () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(tr.alert_dialog_del_all_files),
                content: Text(tr.alert_dialog_confirm_delete_all),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(tr.button_cancel),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      supprimerTousLesFichiers();
                    },
                    child: Text(tr.button_delete),
                  ),
                ],
              ),
            ),
            tooltip: tr.pdf_page_delete_all,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.picture_as_pdf),
              label: Text(tr.journal_page_export_pdf),
              onPressed: () async {
                final partager = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(tr.journal_page_export_pdf),
                    content: Text(tr.journal_page_share_export),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(tr.button_no),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(tr.button_yes),
                      ),
                    ],
                  ),
                );
                if (partager != null && context.mounted) {
                  await generatePdfFromDatabase(context, partager: partager);
                }
              },
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              icon: const Icon(Icons.bar_chart),
              label: Text(tr.journal_page_export_charts),
              onPressed: () => Navigator.pushNamed(context, '/stats'),
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
                  icon: const Icon(Icons.refresh),
                  label: Text(tr.button_refresh),
                  onPressed: chargerFichiers,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: fichiers.isEmpty
                  ? Center(child: Text(tr.pdf_page_empty_dir))
                  : ListView(
                children: [
                  if (fichiersRapport.isNotEmpty) ...[
                    Text(tr.pdf_page_reports, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ...fichiersRapport.map((f) => buildFileTile(context, f)).toList(),
                    const Divider(),
                  ],
                  if (fichiersGraphiques.isNotEmpty) ...[
                    Text(tr.pdf_page_charts, style: const TextStyle(fontWeight: FontWeight.bold)),
                    ...fichiersGraphiques.map((f) => buildFileTile(context, f)).toList(),
                  ],
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),
          ],
        ),
      ),
    );
  }

  Widget buildFileTile(BuildContext context, File fichier) {
    final nom = path.basename(fichier.path);
    final estSelectionne = selectionnes.contains(fichier);
    final tr = AppLocalizations.of(context)!;

    return ListTile(
      leading: Checkbox(
        value: estSelectionne,
        onChanged: (bool? value) {
          setState(() {
            if (value == true) {
              selectionnes.add(fichier);
            } else {
              selectionnes.remove(fichier);
            }
          });
        },
      ),
      title: Text(nom),
      onTap: () {
        setState(() {
          estSelectionne ? selectionnes.remove(fichier) : selectionnes.add(fichier);
        });
      },
      trailing: IconButton(
        icon: const Icon(Icons.open_in_new),
        onPressed: () async {
          final status = await PermissionHelper.requestStoragePermission();
          if (status) {
            final result = await OpenFilex.open(fichier.path);
            logger.i("Ouverture réussie : ${result.message}");
          } else {
            openAppSettings();
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(tr.skbar_granted_file_refused)),
            );
          }
        },
      ),
    );
  }
}