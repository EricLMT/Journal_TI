import 'package:flutter/material.dart';
import '/l10n/app_localizations.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:journal_ti/widgets/card_ink.dart';


class HelpPage extends StatelessWidget {
  const HelpPage({super.key});


  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(tr.help_title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Presentation
            Text(tr.help_title_sub,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Divider(),
            // Section : Aide App
            Text(tr.help_section_app,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(tr.help_text_app,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Divider(),
            // Section : Aide Observation
            Text(tr.help_section_obs,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(tr.help_text_obs,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Divider(),
            // Section : Aide Options
            Text(tr.help_section_options,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(tr.help_text_options,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Divider(),
            // Section : Aide Import/Export
            Text(tr.help_section_import_export,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(tr.help_text_import_export,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Divider(),
            // Section : Aide DB
            Text(tr.help_section_db,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(tr.help_text_db,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),
          ],
        ),
      ),
    );
  }
}
