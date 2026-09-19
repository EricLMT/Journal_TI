import 'package:flutter/material.dart';
import '/l10n/app_localizations.dart';
//import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:journal_ti/widgets/check_update.dart';

class AProposPage extends StatelessWidget {
  const AProposPage({super.key});


  @override
  Widget build(BuildContext context) {
    final tr = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(tr.about_title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${tr.title}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Divider(),
            Text('${tr.about_text}\n\n',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
            Text(
              'Auteur: Eric LAMETTE © 2026\n'
                  'ericlmt@gmail.com\n'
                  'https://www.facebook.com/groups/tibelgium\n\n'
                  'GNU General Public License\n'
                  '<https://www.gnu.org/licenses/>\n'
                  'Fait avec l\'assistance dévouée de l\'IA\n',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
            const SizedBox(height: 16, width: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.update),
              label: Text(
                tr.app_update_check,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              onPressed: () => Navigator.pushNamed(context, '/update'),
            ),
            SizedBox(height: MediaQuery.of(context).viewPadding.bottom + 2),
          ],
        ),
      ),
    );
  }
}
