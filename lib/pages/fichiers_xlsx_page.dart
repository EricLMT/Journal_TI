import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart'; 
import 'package:path/path.dart' as path;
import 'package:logger/logger.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';

import 'package:journal_ti/utils/excel_utils.dart';
import 'package:journal_ti/utils/db_utils.dart';
import '/l10n/app_localizations.dart';
import 'package:journal_ti/utils/permissions_utils.dart';

final logger = Logger();


class FichierXLSXPage extends StatefulWidget {
  const FichierXLSXPage({super.key});

  @override
  State<FichierXLSXPage> createState() => _FichierXLSXPageState();
}

class _FichierXLSXPageState extends State<FichierXLSXPage> {
  List<FileSystemEntity> fichiers = [];

  Future<void> chargerFichiers() async {
    final directory = Directory('/storage/emulated/0/Documents/JournalTI');

    if (await directory.exists()) {
      final files = directory
          .listSync()
          .where((f) => f.path.endsWith('.xlsx'))
          .toList()
        ..sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));

      setState(() {
        fichiers = files;
      });
    }
  }
  
  @override
  void initState() {
    super.initState();
    chargerFichiers();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(tr.xlsx_page_title)),
      body:
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(tr.xlsx_page_generate,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: Text(tr.xlsx_page_export,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  final data = await DBHelper.getAllObservations();
                  if (data.isEmpty) {
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(tr.skbar_export_empty)),
                    );
                    return;
                  }
                  final maps = data.map((obs) => obs.toMap()).toList();
                  await exportToExcel(maps, context);
                  chargerFichiers();
                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(tr.skbar_export_ok)),
                  );
                },
              ),
            ),
            //const SizedBox(height: 10),
            Expanded(
              child: fichiers.isEmpty
                  ? Center(child: Text(tr.xlsx_page_empty_dir))
                  : ListView.builder(
                itemCount: fichiers.length,
                itemBuilder: (context, index) {
                  final fichier = fichiers[index];
                  final nom = path.basename(fichier.path);

                  return ListTile(
                    title: Text(nom),
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
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),
          ],
        ),
    );
  }
}