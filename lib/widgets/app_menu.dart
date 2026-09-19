import 'package:flutter/material.dart';
import 'package:journal_ti/pages/langue_page.dart';
//import 'package:journal_ti/utils/locale_language.dart';
//import 'package:journal_ti/widgets/boutons_bas.dart';
import '/l10n/app_localizations.dart';


class AppDrawer extends StatelessWidget {
  final VoidCallback onNouvelleObservation;
  final VoidCallback onVoirFichiers;
  final VoidCallback? onExporterVersExcel;
  //final VoidCallback? onExporterVersPdf;
  final VoidCallback? onQuitter;
  final VoidCallback? onOptions;
  final VoidCallback? onApropos;


  const AppDrawer({
    super.key,
    required this.onNouvelleObservation,
    required this.onVoirFichiers,
    this.onExporterVersExcel,
    //this.onExporterVersPdf,
    this.onQuitter,
    this.onOptions,
    this.onApropos,
  });


  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: const Color.fromARGB(255, 90, 120, 180)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/ti_banderole_trans.jpg',
                  height: 80,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 10),
                Text(
                  tr.app_menu_title,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
             ],
            ),
          ),

          ListTile(
            leading: const Icon(Icons.note_add),
            title: Text(tr.app_menu_observation),
            onTap: () {
              Navigator.pop(context);
              onNouvelleObservation();
            },
          ),

          ListTile(
            leading: const Icon(Icons.picture_as_pdf),
            title: Text(tr.app_menu_pdf_files),
            onTap: () {
              Navigator.pop(context);
              onVoirFichiers();
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: Text('Stats'),
            onTap: () {
              Navigator.pushNamed(context, '/stats');
            },
          ),
          //ListTile(
          //  leading: const Icon(Icons.content_paste_go),
          //  title: Text(tr.app_menu_pdf_report),
          //  onTap: () {
          //    Navigator.pop(context);
          //    onExporterVersPdf!();
          //  },
          //),
          if (onExporterVersExcel != null) 
            ListTile(
              leading: const Icon(Icons.table_chart),
              title: Text(tr.app_menu_xlsx_export),
              onTap: () {
                Navigator.pop(context);
                onExporterVersExcel!();
              },
            ),
          ListTile(
            leading: const Icon(Icons.storage),
            title: Text(tr.app_menu_db_options),
            onTap: () {
              Navigator.pop(context);
              onOptions!();              
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: Text(tr.app_menu_language),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LanguagePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text(tr.app_menu_help),
            onTap: () {
              Navigator.pushNamed(context, '/help');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: Text(tr.app_menu_about),
            onTap: () {
              Navigator.pop(context);
              onApropos!();                
            },
          ), 
          if (onQuitter != null)
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: Text(tr.app_menu_exit),
              onTap: () {
                Navigator.pop(context);
                onQuitter!();
              },
            ),
        ],
      ),
    );
  }
}