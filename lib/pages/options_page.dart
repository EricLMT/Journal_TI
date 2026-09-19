import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:logger/logger.dart';
import 'dart:io';
//import 'package:permission_handler/permission_handler.dart';
import 'package:journal_ti/utils/db_utils.dart'; 
import 'package:journal_ti/pages/db_page.dart';
import '/l10n/app_localizations.dart';
import 'package:journal_ti/utils/permissions_utils.dart';

final logger = Logger();


class OptionsPage extends StatefulWidget {
  const OptionsPage({super.key});

  @override
  State<OptionsPage> createState() => _OptionsPageState();
}

class _OptionsPageState extends State<OptionsPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  late TabController _tabController;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(tr.options_page_db),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          // couleur sélectionnée
          unselectedLabelColor: Colors.grey,
          // non sélectionnée
          indicatorColor: Colors.black,
          // soulignement
          labelStyle: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 20),
          tabs: [
            Tab(text: tr.options_page_db_tab_rec),
            Tab(text: tr.options_page_db_tab_db),
          ],
        ),
      ),
      body: FormBuilder(
        key: _formKey,
        child: TabBarView(
          controller: _tabController,
          children: [
            ObservationsDbPage(),
            pageBaseDonnees(context),
          ],
        ),
      ),
    );
  }

 // @override

  Widget pageBaseDonnees(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
         Text(tr.options_page_db_list,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const Divider(),

        // Exporter
        ListTile(
          leading: const Icon(Icons.import_export),
          title: Text(tr.options_page_db_export),
          subtitle: Text(tr.options_page_db_export_sub),
          onTap: () async {
            await DBHelper.exporterBaseDeDonnees();
            if (!context.mounted) return;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(tr.skbar_export_db_ok)),
            );
          },
        ),
        const Divider(),

        // Importer
        ListTile(
          leading: const Icon(Icons.import_export),
          title: Text(tr.options_page_db_import),
          subtitle: Text(tr.options_page_db_import_sub),
          onTap: () async {
            final cheminImport = "/storage/emulated/0/Documents/JournalTI/observations_export.db";

            // Vérifie permission
            final status = await PermissionHelper.requestStoragePermission();
            if (!status) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(tr.skbar_granted_refused)),
              );
              return;
            }

            final fichier = File(cheminImport);

            if (!await fichier.exists()) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(tr.skbar_no_file)),
              );
              return;
            }

            final confirm = await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(tr.options_page_db_import_confirm),
                content: Text(tr.options_page_db_import_confirm_sub),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text(tr.button_cancel),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text(tr.button_import),
                  ),
                ],
              ),
            );

            if (confirm == true) {
              await DBHelper.importerBaseDeDonnees(cheminImport);

              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(tr.skbar_import_db_ok)),
              );
            }
          },
        ),
        const Divider(),
        // Supprimer toute la base
        ListTile(
          leading: const Icon(Icons.delete_forever, color: Colors.red),
          title: Text(tr.options_page_db_delete_all),
          subtitle: Text(tr.options_page_db_delete_all_sub),
          onTap: () async {
            final confirmation = await showDialog<bool>(
              context: context,
              builder: (context) =>
                  AlertDialog(
                    title: Text(tr.alert_dialog_confirm),
                    content: Text(tr.alert_dialog_delete_db),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: Text(tr.button_cancel),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: Text(tr.button_delete),
                      ),
                    ],
                  ),
            );

            if (confirmation == true) {
              await DBHelper.supprimerBaseDeDonnees();
              if (!context.mounted) return;
              await showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: Text(tr.alert_dialog_del_ok),
                      content: Text(tr.alert_dialog_delete_db_ok),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(tr.alert_dialog_ok),
                        ),
                      ],
                    ),
              );
            }
          },
        ),
        SizedBox(height: MediaQuery
            .of(context)
            .viewPadding
            .bottom + 2),
      ],

    );
  }
}